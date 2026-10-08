package com.google.oslo;

/** Transient experiment state. No preview or foreground lease is written to Settings. */
public final class ExperimentPolicy {
    private String leaseToken, previewToken;
    private long leaseUntil, previewUntil;
    private int previewStyle, previewSpeed;
    private boolean previewTrails;

    public static int style(int value) { return value >= 0 && value <= 4 ? value : 0; }
    public static int speed(int value) { return Math.max(50, Math.min(200, value)); }

    public synchronized void lease(String token, long now) {
        if (token == null || token.isEmpty()) return;
        leaseToken = token;
        leaseUntil = now + 6000;
    }
    public synchronized void end(String token) {
        if (token != null && token.equals(leaseToken)) { leaseUntil = 0; leaseToken = null; }
        if (token != null && token.equals(previewToken)) { previewUntil = 0; previewToken = null; }
    }
    public synchronized boolean active(long now) {
        return leaseToken != null && now < leaseUntil && leaseUntil - now <= 6000;
    }
    public synchronized void preview(String token, int theme, int tempo, long now) {
        preview(token, theme, tempo, false, now);
    }
    public synchronized void preview(String token, int theme, int tempo, boolean trails, long now) {
        if (token == null || token.isEmpty()) return;
        previewToken = token;
        previewStyle = style(theme);
        previewSpeed = speed(tempo);
        previewTrails = trails;
        previewUntil = now + 8000;
    }
    public synchronized boolean previewing(long now) {
        return previewToken != null && now < previewUntil && previewUntil - now <= 8000;
    }
    public synchronized int theme(int saved, long now) {
        return previewing(now) ? previewStyle : style(saved);
    }
    public synchronized int tempo(int saved, long now) {
        return previewing(now) ? previewSpeed : speed(saved);
    }
    public synchronized boolean trails(boolean saved, long now) {
        return previewing(now) ? previewTrails : saved;
    }
}
