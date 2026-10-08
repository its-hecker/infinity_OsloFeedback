package com.google.oslo;

public final class AirDjPolicyTest {
    private static void check(boolean condition, String message) {
        if (!condition) throw new AssertionError(message);
    }

    public static void main(String[] args) {
        check(AirDjPolicy.nextMode(0) == 1, "track to volume");
        check(AirDjPolicy.nextMode(1) == 2, "volume to seek");
        check(AirDjPolicy.nextMode(2) == 0, "seek to track");
        check(AirDjPolicy.normalizeMode(-1) == 0, "negative mode");
        check(AirDjPolicy.normalizeMode(99) == 0, "invalid mode");
        AirDjPolicy policy = new AirDjPolicy();
        check(policy.acceptGesture(0, 750), "first gesture at boot");
        check(!policy.acceptGesture(749, 750), "debounce duplicate");
        check(policy.acceptGesture(750, 750), "cooldown boundary");
        policy.reset();
        check(policy.acceptGesture(751, 750), "disable resets cooldown");
        check(AirDjPolicy.seekPosition(20000, 1000, 4000, 1f, 60000, true) == 33000,
                "extrapolate before seeking");
        check(AirDjPolicy.seekPosition(5000, 0, 4000, 1f, 60000, false) == 0,
                "clamp to beginning");
        check(AirDjPolicy.seekPosition(55000, 0, 4000, 1f, 60000, true) == 60000,
                "clamp to duration");
        check(AirDjPolicy.seekPosition(-1, 0, 4000, 1f, 0, true) == -1,
                "unknown playback position");
        check(AirDjPolicy.seekPosition(10000, 2000, 4000, 2f, 0, true) == 24000,
                "playback speed");
        check(AirDjPolicy.glowHue(0) != AirDjPolicy.glowHue(1)
                && AirDjPolicy.glowHue(1) != AirDjPolicy.glowHue(2), "distinct mode colors");
        System.out.println("Air DJ policy: 15 checks passed");
    }
}
