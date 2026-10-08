package com.google.oslo;

/** Bounded pixel histogram and tint rules, independent of Android and media transport. */
public final class ArtworkPalette {
    private ArtworkPalette() {}
    public static int extract(int[] pixels) {
        if (pixels == null || pixels.length == 0) return 0;
        int[] weight = new int[4096], red = new int[4096], green = new int[4096], blue = new int[4096];
        int winner = -1;
        for (int pixel : pixels) {
            if ((pixel >>> 24) < 128) continue;
            int r = (pixel >>> 16) & 255, g = (pixel >>> 8) & 255, b = pixel & 255;
            int high = Math.max(r, Math.max(g,b)), low = Math.min(r, Math.min(g,b));
            if (high < 28) continue; // dark artwork borders cannot produce a useful glow
            int index = (r >> 4) << 8 | (g >> 4) << 4 | (b >> 4);
            int value = 1 + (high-low) / 24; // favor visible color over a neutral border
            weight[index] += value; red[index] += r*value; green[index] += g*value; blue[index] += b*value;
            if (winner < 0 || weight[index] > weight[winner]) winner = index;
        }
        if (winner < 0) return 0;
        int r = red[winner]/weight[winner], g = green[winner]/weight[winner], b = blue[winner]/weight[winner];
        int high = Math.max(r,Math.max(g,b));
        return 0xff000000 | ((r*255/high)<<16) | ((g*255/high)<<8) | (b*255/high);
    }
    public static int tint(int original, int palette) {
        if (palette == 0) return original;
        int value = Math.max((original>>>16)&255,Math.max((original>>>8)&255,original&255));
        return (original & 0xff000000) | ((((palette>>>16)&255)*value/255)<<16)
                | ((((palette>>>8)&255)*value/255)<<8) | ((palette&255)*value/255);
    }
}
