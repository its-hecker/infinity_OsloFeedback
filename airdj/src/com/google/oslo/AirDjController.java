package com.google.oslo;

import android.content.Context;
import android.media.MediaMetadata;
import android.media.session.MediaController;
import android.media.session.PlaybackState;
import android.os.SystemClock;
import android.provider.Settings;
import android.util.Log;
import java.util.List;

/** Opt-in routing for the existing media gesture clients; never starts a radar subscription. */
public final class AirDjController {
    public static final String ENABLED = "aware_air_dj";
    public static final String MODE = "aware_air_dj_mode";
    private static final String TAG = "Oslo.AirDJ";
    private static final AirDjPolicy POLICY = new AirDjPolicy();
    private static String lastActionPackage;

    private AirDjController() {}

    public static boolean isEnabled(Context context) {
        try {
            boolean enabled = Settings.Secure.getInt(context.getContentResolver(), ENABLED, 0) == 1
                    && Settings.Secure.getInt(context.getContentResolver(), "aware_enabled", 0) == 1;
            if (!enabled) POLICY.reset();
            return enabled;
        } catch (RuntimeException e) {
            Log.w(TAG, "Unable to read Air DJ settings", e);
            return false;
        }
    }

    private static int getMode(Context context) {
        return AirDjPolicy.normalizeMode(
                Settings.Secure.getInt(context.getContentResolver(), MODE, 0));
    }

    private static MediaController playing(List<MediaController> sessions) {
        for (MediaController controller : sessions) {
            PlaybackState state = controller.getPlaybackState();
            if (state != null && state.getState() == PlaybackState.STATE_PLAYING) return controller;
        }
        return null;
    }

    /** Null for ignored/failed gestures, so callers don't report false success feedback. */
    public static String getLastActionPackage() {
        return lastActionPackage;
    }

    public static boolean handleTap(Context context, List<MediaController> sessions,
            boolean detected) {
        lastActionPackage = null;
        if (!isEnabled(context)) return false;
        try {
            MediaController controller = playing(sessions);
            if (!detected || controller == null
                    || !POLICY.acceptGesture(SystemClock.elapsedRealtime(), 750)) return true;
            int next = AirDjPolicy.nextMode(getMode(context));
            if (Settings.Secure.putInt(context.getContentResolver(), MODE, next)) {
                lastActionPackage = controller.getPackageName();
                Log.i(TAG, "Mode: " + next);
            }
        } catch (RuntimeException e) {
            // Consume the gesture: falling through would unexpectedly pause playback.
            Log.w(TAG, "Air DJ mode switch failed", e);
        }
        return true;
    }

    public static boolean handleFlick(Context context, List<MediaController> sessions,
            boolean forward) {
        lastActionPackage = null;
        if (!isEnabled(context)) return false;
        try {
            MediaController controller = playing(sessions);
            if (controller == null
                    || !POLICY.acceptGesture(SystemClock.elapsedRealtime(), 500)) return true;
            PlaybackState state = controller.getPlaybackState();
            if (state == null || state.getState() != PlaybackState.STATE_PLAYING) return true;
            long actions = state.getActions();
            switch (getMode(context)) {
                case AirDjPolicy.TRACK:
                    long required = forward ? PlaybackState.ACTION_SKIP_TO_NEXT
                            : PlaybackState.ACTION_SKIP_TO_PREVIOUS;
                    if ((actions & required) == 0) return true;
                    if (forward) controller.getTransportControls().skipToNext();
                    else controller.getTransportControls().skipToPrevious();
                    break;
                case AirDjPolicy.VOLUME:
                    MediaController.PlaybackInfo info = controller.getPlaybackInfo();
                    if (info == null || info.getVolumeControl() == 0) return true;
                    // Route through the media session, including remote playback devices.
                    controller.adjustVolume(forward ? 1 : -1, 1);
                    break;
                case AirDjPolicy.SEEK:
                    if ((actions & PlaybackState.ACTION_SEEK_TO) == 0) return true;
                    MediaMetadata metadata = controller.getMetadata();
                    long duration = metadata == null ? 0
                            : metadata.getLong(MediaMetadata.METADATA_KEY_DURATION);
                    long target = AirDjPolicy.seekPosition(state.getPosition(),
                            state.getLastPositionUpdateTime(), SystemClock.elapsedRealtime(),
                            state.getPlaybackSpeed(), duration, forward);
                    if (target < 0) return true;
                    controller.getTransportControls().seekTo(target);
                    break;
            }
            lastActionPackage = controller.getPackageName();
            Log.i(TAG, "Action sent to " + lastActionPackage);
        } catch (RuntimeException e) {
            // A dead/rejecting media session must never take down the SystemUI plugin.
            Log.w(TAG, "Air DJ action failed", e);
        }
        return true;
    }
}
