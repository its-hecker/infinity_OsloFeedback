package com.google.oslo;

import android.content.Context;
import android.graphics.Bitmap;
import android.media.MediaMetadata;
import android.media.session.MediaController;
import android.media.session.MediaSession;
import android.media.session.MediaSessionManager;
import android.media.session.PlaybackState;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.util.Log;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/** Opt-in, callback-driven artwork colors. Never downloads artwork or recycles a player's bitmap. */
public final class AlbumArtController {
    private static final AlbumArtController INSTANCE = new AlbumArtController();
    private static volatile int color;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final LinkedHashMap<MediaSession.Token,Watch> watches = new LinkedHashMap<>();
    private MediaSessionManager manager;
    private HandlerThread thread;
    private Handler worker;
    private Watch selected;
    private Runnable changed;
    private boolean enabled, listenerRegistered;
    private long generation;
    private Runnable pending;

    private AlbumArtController() {}
    public static int getColor() { return color; }
    public static int tint(int stock) { return ArtworkPalette.tint(stock,color); }
    /** Must be called on the UI thread; one monitor for the attached glow surfaces. */
    public static void configure(Context owner, boolean on, Runnable callback) {
        INSTANCE.changed = callback;
        if (!on) { INSTANCE.stop(); return; }
        if (INSTANCE.enabled) return;
        INSTANCE.enabled = true;
        try {
            INSTANCE.manager = owner.getSystemService(MediaSessionManager.class);
            if (INSTANCE.manager == null) { INSTANCE.stop(); return; }
            INSTANCE.thread = new HandlerThread("OsloAlbumPalette"); INSTANCE.thread.start();
            INSTANCE.worker = new Handler(INSTANCE.thread.getLooper());
            INSTANCE.manager.addOnActiveSessionsChangedListener(INSTANCE.sessions,null,INSTANCE.main);
            INSTANCE.listenerRegistered = true;
            INSTANCE.updateSessions(INSTANCE.manager.getActiveSessions(null));
        } catch (RuntimeException e) {
            Log.w("Oslo.AlbumGlow","Artwork monitor unavailable",e); INSTANCE.stop();
        }
    }
    private final MediaSessionManager.OnActiveSessionsChangedListener sessions = this::updateSessions;
    private void updateSessions(List<MediaController> controllers) {
        if (!enabled) return;
        List<MediaController> limited = new ArrayList<>();
        if (controllers != null) for (MediaController c : controllers) {
            if (limited.size() == 16) break;
            if (c != null) limited.add(c);
        }
        LinkedHashMap<MediaSession.Token,Watch> next = new LinkedHashMap<>();
        for (MediaController c : limited) {
            MediaSession.Token token;
            try { token = c.getSessionToken(); } catch (RuntimeException ignored) { continue; }
            if (token == null || next.containsKey(token)) continue;
            Watch w = watches.get(token);
            if (w == null) {
                w = new Watch(c);
                try { c.registerCallback(w,main); } catch (RuntimeException ignored) { continue; }
            }
            next.put(token,w);
        }
        for (MediaSession.Token token : watches.keySet()) if (!next.containsKey(token)) watches.get(token).close();
        watches.clear(); watches.putAll(next); choose();
    }
    private void choose() {
        if (!enabled) return;
        Watch next = null;
        for (Watch w : watches.values()) {
            try {
                PlaybackState state = w.controller.getPlaybackState();
                if (state != null && state.getState() == PlaybackState.STATE_PLAYING) { next=w; break; }
            } catch (RuntimeException ignored) {}
        }
        if (selected == next) return;
        selected = next;
        if (next == null) schedule(null);
        else try { schedule(next.controller.getMetadata()); } catch (RuntimeException e) { schedule(null); }
    }
    private final class Watch extends MediaController.Callback {
        final MediaController controller;
        int playback = -1;
        Watch(MediaController c) { controller=c; }
        @Override public void onMetadataChanged(MediaMetadata metadata) {
            if (enabled && selected == this) schedule(metadata);
        }
        @Override public void onPlaybackStateChanged(PlaybackState state) {
            int value=state == null ? -1 : state.getState();
            if (value != playback) { playback=value; choose(); }
        }
        @Override public void onSessionDestroyed() {
            if (!enabled) return;
            watches.remove(controller.getSessionToken()); close(); choose();
        }
        void close() { try { controller.unregisterCallback(this); } catch (RuntimeException ignored) {} }
    }
    private void publish(int next) {
        if (color == next) return;
        color=next; if (changed != null) changed.run();
    }
    private void schedule(MediaMetadata metadata) {
        final long request=++generation;
        if (pending != null) main.removeCallbacks(pending);
        if (worker != null) worker.removeCallbacksAndMessages(null);
        Bitmap artwork=null;
        if (metadata != null) try {
            artwork=metadata.getBitmap(MediaMetadata.METADATA_KEY_ART);
            if (artwork == null) artwork=metadata.getBitmap(MediaMetadata.METADATA_KEY_ALBUM_ART);
        } catch (RuntimeException ignored) {}
        // Missing artwork, stop or a new track clears the previous track's palette immediately.
        publish(0);
        if (artwork == null || worker == null) return;
        final Bitmap source=artwork;
        pending=() -> {
            if (!enabled || request != generation || worker == null) return;
            worker.post(() -> {
                int result=extract(source);
                main.post(() -> { if (enabled && request == generation) publish(result); });
            });
        };
        main.postDelayed(pending,150);
    }
    private static int extract(Bitmap source) {
        Bitmap sample=null, software=null;
        try {
            if (source.isRecycled() || source.getWidth() <= 0 || source.getHeight() <= 0) return 0;
            float scale=Math.min(1f,48f/Math.max(source.getWidth(),source.getHeight()));
            sample=Bitmap.createScaledBitmap(source,Math.max(1,Math.round(source.getWidth()*scale)),
                    Math.max(1,Math.round(source.getHeight()*scale)),true);
            if (sample.getConfig() == Bitmap.Config.HARDWARE) {
                software=sample.copy(Bitmap.Config.ARGB_8888,false);
                if (software == null) return 0;
            } else software=sample;
            int[] pixels=new int[software.getWidth()*software.getHeight()];
            software.getPixels(pixels,0,software.getWidth(),0,0,software.getWidth(),software.getHeight());
            return ArtworkPalette.extract(pixels);
        } catch (RuntimeException | OutOfMemoryError e) { return 0; }
        finally {
            if (software != null && software != sample && software != source) software.recycle();
            if (sample != null && sample != source) sample.recycle();
        }
    }
    private void stop() {
        enabled=false; generation++;
        if (pending != null) main.removeCallbacks(pending); pending=null;
        if (listenerRegistered && manager != null) try { manager.removeOnActiveSessionsChangedListener(sessions); }
        catch (RuntimeException ignored) {}
        listenerRegistered=false;
        for (Watch w : watches.values()) w.close(); watches.clear(); selected=null;
        if (worker != null) worker.removeCallbacksAndMessages(null);
        if (thread != null) thread.quitSafely(); thread=null; worker=null; manager=null;
        publish(0);
    }
}
