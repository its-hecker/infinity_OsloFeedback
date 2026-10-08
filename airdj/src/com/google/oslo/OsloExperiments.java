package com.google.oslo;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.opengl.GLSurfaceView;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.provider.Settings;
import android.util.Log;
import java.lang.ref.WeakReference;
import java.util.ArrayList;

/** Permission-protected preview and foreground lease bridge, present in each Oslo process. */
public final class OsloExperiments {
    public interface Surface {
        void refreshExperimentVisibility();
        void refreshExperimentColors();
    }
    private static final String ACTION = "com.google.oslo.EXPERIMENT_COMMAND";
    private static final Handler MAIN = new Handler(Looper.getMainLooper());
    static final ExperimentPolicy POLICY = new ExperimentPolicy();
    private static final ArrayList<WeakReference<GLSurfaceView>> VIEWS = new ArrayList<>();
    private static Context context;
    private static BroadcastReceiver receiver;
    private static ContentObserver observer;
    private static boolean service;
    static volatile int savedStyle, savedSpeed = 100, brightness = 100, airMode;
    static volatile boolean trails, enabled, shown = true, airDj, albumGlow;
    static volatile long gestureAt;
    static volatile int direction;
    private static boolean pumping;

    private OsloExperiments() {}

    public static void initialize(Context owner) {
        MAIN.post(() -> initializeMain(owner));
    }
    private static void initializeMain(Context owner) {
        if (receiver != null) return;
        context = owner.getApplicationContext();
        try {
            receiver = new BroadcastReceiver() {
                @Override public void onReceive(Context c, Intent intent) {
                    String command = intent.getStringExtra("command");
                    String token = intent.getStringExtra("token");
                    long now = SystemClock.elapsedRealtime();
                    if ("lease".equals(command)) POLICY.lease(token, now);
                    else if ("end".equals(command)) { POLICY.end(token); startFrames(); }
                    else if ("preview".equals(command)) {
                        POLICY.preview(token, intent.getIntExtra("style", 0),
                                intent.getIntExtra("speed", 100),
                                intent.getBooleanExtra("trails", trails), now);
                        startFrames();
                    }
                }
            };
            context.registerReceiver(receiver, new IntentFilter(ACTION),
                    "android.permission.WRITE_SECURE_SETTINGS", MAIN, Context.RECEIVER_EXPORTED);
            observer = new ContentObserver(MAIN) {
                @Override public void onChange(boolean selfChange) { readSettings(); }
            };
            for (String key : new String[] {"aware_glow_style", "aware_glow_speed",
                    "aware_gesture_trails", "aware_enabled", "aware_glow_show",
                    "aware_glow_brightness", "aware_air_dj", "aware_air_dj_mode"}) {
                context.getContentResolver().registerContentObserver(
                        Settings.Secure.getUriFor(key), false, observer);
            }
            context.getContentResolver().registerContentObserver(
                    Settings.Secure.getUriFor("aware_album_art_glow"),false,observer);
            for (String key : new String[] {"aware_allowed", "airplane_mode_on", "low_power"}) {
                context.getContentResolver().registerContentObserver(
                        Settings.Global.getUriFor(key), false, observer);
            }
            readSettings();
        } catch (RuntimeException e) {
            Log.w("Oslo.Experiments", "Experiment bridge unavailable", e);
            close();
        }
    }
    private static int setting(String name, int fallback) {
        return Settings.Secure.getInt(context.getContentResolver(), name, fallback);
    }
    private static void readSettings() {
        try {
            savedStyle = ExperimentPolicy.style(setting("aware_glow_style", 0));
            savedSpeed = ExperimentPolicy.speed(setting("aware_glow_speed", 100));
            trails = setting("aware_gesture_trails", 0) == 1;
            enabled = setting("aware_enabled", 0) == 1
                    && Settings.Global.getInt(context.getContentResolver(),"aware_allowed",0)==1
                    && Settings.Global.getInt(context.getContentResolver(),"airplane_mode_on",0)==0
                    && Settings.Global.getInt(context.getContentResolver(),"low_power",0)==0;
            shown = setting("aware_glow_show", 1) == 1;
            brightness = Math.max(10, Math.min(100, setting("aware_glow_brightness", 100)));
            airDj = setting("aware_air_dj", 0) == 1;
            airMode = AirDjPolicy.normalizeMode(setting("aware_air_dj_mode", 0));
            albumGlow = setting("aware_album_art_glow",0)==1;
        } catch (RuntimeException e) { enabled = false; }
        updateAlbumMonitor();
        startFrames();
    }
    public static void serviceStarted(Context owner) {
        MAIN.post(() -> { service = true; initializeMain(owner); });
    }
    public static void serviceStopped() {
        MAIN.post(() -> { service = false; if (VIEWS.isEmpty()) close(); });
    }
    public static void attach(GLSurfaceView view, Context owner) {
        MAIN.post(() -> {
            initializeMain(owner);
            for (WeakReference<GLSurfaceView> ref : VIEWS) if (ref.get() == view) return;
            VIEWS.add(new WeakReference<>(view));
            updateAlbumMonitor();
            startFrames();
        });
    }
    public static void detach(GLSurfaceView view) {
        MAIN.post(() -> {
            VIEWS.removeIf(ref -> ref.get() == null || ref.get() == view);
            updateAlbumMonitor();
            if (!service && VIEWS.isEmpty()) close();
        });
    }
    private static void close() {
        if (context != null) AlbumArtController.configure(context,false,OsloExperiments::colorsChanged);
        if (context != null && receiver != null) try { context.unregisterReceiver(receiver); }
        catch (RuntimeException ignored) {}
        if (context != null && observer != null) try {
            context.getContentResolver().unregisterContentObserver(observer);
        } catch (RuntimeException ignored) {}
        receiver = null; observer = null; context = null;
        enabled = false;
    }
    private static void updateAlbumMonitor() {
        if (context != null) AlbumArtController.configure(context,
                enabled && shown && albumGlow && !VIEWS.isEmpty(),OsloExperiments::colorsChanged);
    }
    private static void colorsChanged() {
        for (WeakReference<GLSurfaceView> ref : VIEWS) {
            GLSurfaceView view=ref.get();
            if (view instanceof Surface) ((Surface)view).refreshExperimentColors();
            if (view != null) view.requestRender();
        }
    }
    /** Called before stock media routing. Lease expiry handles crashes and missed onPause. */
    public static boolean isLabActive() {
        return POLICY.active(SystemClock.elapsedRealtime());
    }
    /** Temporarily reveal only the existing glow surface; retain the latest stock visibility. */
    public static int visibility(int stock) {
        long now=SystemClock.elapsedRealtime();
        long age=now-gestureAt;
        boolean effect=POLICY.previewing(now) || (shown && age>=0 && age<1200
                && (savedStyle!=0 || trails));
        return enabled && effect ? android.view.View.VISIBLE : stock;
    }
    public static void gesture(int side, boolean detected) {
        if (!detected) return;
        gestureAt = SystemClock.elapsedRealtime();
        direction = side;
        MAIN.post(OsloExperiments::startFrames);
    }
    private static void startFrames() {
        if (pumping) return;
        pumping = true;
        MAIN.post(FRAME);
    }
    private static final Runnable FRAME = new Runnable() {
        @Override public void run() {
            long now = SystemClock.elapsedRealtime();
            boolean preview = POLICY.previewing(now);
            long age=now-gestureAt;
            boolean effect = preview || (shown && (trails || savedStyle != 0) && age>=0 && age<1200);
            boolean visible = false;
            for (int i = VIEWS.size() - 1; i >= 0; i--) {
                GLSurfaceView view = VIEWS.get(i).get();
                if (view == null) { VIEWS.remove(i); continue; }
                if (view instanceof Surface) ((Surface)view).refreshExperimentVisibility();
                if (view.isAttachedToWindow() && view.getWindowVisibility() == 0) {
                    view.requestRender(); visible = true;
                }
            }
            // One final redraw after expiry removes transient pixels.
            if (effect && enabled && visible) MAIN.postDelayed(this, 33);
            else pumping = false;
        }
    };
}
