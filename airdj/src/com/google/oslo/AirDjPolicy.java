package com.google.oslo;

/** Android-independent Air DJ rules, shared by the controller and regression tests. */
public final class AirDjPolicy {
    public static final int TRACK = 0;
    public static final int VOLUME = 1;
    public static final int SEEK = 2;
    private long lastGesture = -1;

    public static int normalizeMode(int mode) {
        return mode >= TRACK && mode <= SEEK ? mode : TRACK;
    }

    public static int nextMode(int mode) {
        return (normalizeMode(mode) + 1) % 3;
    }

    public static float glowHue(int mode) {
        switch (normalizeMode(mode)) {
            case VOLUME: return 140f;
            case SEEK: return 30f;
            default: return 215f;
        }
    }

    public synchronized boolean acceptGesture(long now, long cooldown) {
        if (lastGesture >= 0 && now >= lastGesture && now - lastGesture < cooldown) {
            return false;
        }
        lastGesture = now;
        return true;
    }

    public synchronized void reset() {
        lastGesture = -1;
    }

    /** Extrapolate a player's stale position before seeking; reject unknown positions. */
    public static long seekPosition(long position, long updated, long now, float speed,
            long duration, boolean forward) {
        if (position < 0) return -1;
        double current = position;
        if (updated > 0 && now > updated && Float.isFinite(speed)) {
            current += (now - updated) * (double) speed;
        }
        double target = Math.max(0d, current + (forward ? 10000d : -10000d));
        if (duration > 0) target = Math.min(target, duration);
        return (long) Math.min(target, Long.MAX_VALUE);
    }
}
