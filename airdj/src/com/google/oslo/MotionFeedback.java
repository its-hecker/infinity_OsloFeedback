// SPDX-License-Identifier: Apache-2.0
package com.google.oslo;

import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.media.MediaMetadata;
import android.media.session.MediaController;
import android.media.session.PlaybackState;
import android.os.SystemClock;
import android.util.Log;

/** Narrow, non-sticky feedback for commands actually dispatched by the existing gesture clients. */
public final class MotionFeedback {
    public static final String ACTION = "com.google.oslo.HECKER_MOTION_FEEDBACK";
    public static final int PLAY = 1, PAUSE = 2, NEXT = 3, PREVIOUS = 4,
            VOLUME_UP = 5, VOLUME_DOWN = 6, SEEK_FORWARD = 7, SEEK_BACK = 8,
            MODE_TRACK = 9, MODE_VOLUME = 10, MODE_SEEK = 11;

    public static final class Snapshot {
        String identity;
        int volume = -1;
        int user = -1;
        int direction;
    }

    public static Snapshot before(MediaController controller) {
        return before(controller, 0);
    }

    /** Raw Oslo directions, exactly as OsloOverlay maps onFlickLeft/onFlickRight. */
    public static int physicalDirection(int raw) {
        if (raw == 1 || raw == 2 || raw == 8) return 1;
        if (raw == 4 || raw == 5 || raw == 6) return -1;
        return 0;
    }

    public static Snapshot before(MediaController controller, int rawDirection) {
        Snapshot snapshot = new Snapshot();
        snapshot.direction = physicalDirection(rawDirection);
        snapshot.user = currentUser();
        try {
            MediaMetadata metadata = controller.getMetadata();
            PlaybackState state = controller.getPlaybackState();
            String id = metadata == null ? null : metadata.getString(MediaMetadata.METADATA_KEY_MEDIA_ID);
            String title = metadata == null ? null : metadata.getString(MediaMetadata.METADATA_KEY_TITLE);
            long queue = state == null ? -1 : state.getActiveQueueItemId();
            if (id != null || title != null || queue != -1)
                snapshot.identity = bounded(id) + '\n' + bounded(title) + '\n' + queue;
            MediaController.PlaybackInfo info = controller.getPlaybackInfo();
            if (info != null) snapshot.volume = info.getCurrentVolume();
        } catch (RuntimeException unavailable) { /* Feedback never changes media routing. */ }
        return snapshot;
    }

    private static String bounded(String value) {
        return value == null ? "" : value.substring(0, Math.min(192, value.length()));
    }

    private static int currentUser() {
        try { return (Integer) ActivityManager.class.getMethod("getCurrentUser").invoke(null); }
        catch (ReflectiveOperationException | RuntimeException unavailable) { return -1; }
    }

    /** Called after a successful dispatch, never for a partial/ignored/training gesture. */
    public static void sent(Context context, MediaController controller, int action, Snapshot before) {
        try {
            if (action < PLAY || action > MODE_SEEK) return;
            // Oslo's service may run as user zero while another Android user is active.
            // This platform-signed app already uses current-user settings in its native clients.
            int user = before.user;
            if (user < 0 || currentUser() != user) return;
            Intent event = new Intent(ACTION).setPackage("com.android.systemui")
                    .putExtra("version", 1).putExtra("action", action)
                    .putExtra("direction", before.direction)
                    .putExtra("user", user).putExtra("when", SystemClock.elapsedRealtime())
                    .putExtra("session", controller.getSessionToken())
                    .putExtra("before_identity", before.identity)
                    .putExtra("before_volume", before.volume);
            // Both sender and receiver must hold the existing platform signature permission.
            // No titles, media identifiers or tokens are sent to other packages or logged.
            context.sendBroadcast(event, "android.permission.STATUS_BAR_SERVICE");
        } catch (RuntimeException unavailable) {
            Log.w("Oslo.MotionFeedback", "Motion feedback unavailable", unavailable);
        }
    }

    public static void play(Context context, MediaController controller) {
        Snapshot before = before(controller);
        controller.getTransportControls().play();
        sent(context, controller, PLAY, before);
    }
    public static void pause(Context context, MediaController controller) {
        Snapshot before = before(controller);
        controller.getTransportControls().pause();
        sent(context, controller, PAUSE, before);
    }
    public static void next(Context context, MediaController controller) {
        next(context, controller, 0);
    }
    public static void next(Context context, MediaController controller, int rawDirection) {
        Snapshot before = before(controller, rawDirection);
        controller.getTransportControls().skipToNext();
        sent(context, controller, NEXT, before);
    }
    public static void previous(Context context, MediaController controller) {
        previous(context, controller, 0);
    }
    public static void previous(Context context, MediaController controller, int rawDirection) {
        Snapshot before = before(controller, rawDirection);
        controller.getTransportControls().skipToPrevious();
        sent(context, controller, PREVIOUS, before);
    }
    private MotionFeedback() { }
}
