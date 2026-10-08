package com.google.oslo;
import java.util.Arrays;
public final class ArtworkPaletteTest {
    private static int checks;
    private static void check(boolean value) { checks++; if (!value) throw new AssertionError("check "+checks); }
    public static void main(String[] args) {
        check(ArtworkPalette.extract(null)==0 && ArtworkPalette.extract(new int[0])==0);
        check(ArtworkPalette.extract(new int[] {0x00ff0000,0x7f00ff00})==0);
        check(ArtworkPalette.extract(new int[] {0xff000000,0xff121212})==0);
        check(ArtworkPalette.extract(new int[] {0xffaa0000,0xffab0000})==0xffff0000);
        check(ArtworkPalette.extract(new int[] {0xff002200,0xff002200})==0xff00ff00);
        check(ArtworkPalette.extract(new int[] {0xff999999})==0xffffffff);
        int[] cover=new int[100];Arrays.fill(cover,0xffeeeeee);Arrays.fill(cover,0,20,0xff0080ff);
        int color=ArtworkPalette.extract(cover);check((color&255)==255 && ((color>>>16)&255)==0);
        check(ArtworkPalette.tint(0x8070a0e0,0)==0x8070a0e0);
        check(ArtworkPalette.tint(0x8070a0e0,0xffff0000)==0x80e00000);
        check(ArtworkPalette.tint(0x2070a0e0,0xff00ff00)==0x2000e000);
        check(ArtworkPalette.tint(0xff000000,0xffff0000)==0xff000000);
        System.out.println("Artwork palette: "+checks+" checks passed");
    }
}
