# Air DJ and Motion Lab

## Coral Motion Island experiment

Branch `test/coral-root-privacy-20261027` adds a narrow media-feedback bridge for
HeckerOS. Stock play/pause/next/previous and successful Air DJ commands emit a
non-sticky `com.google.oslo.HECKER_MOTION_FEEDBACK` broadcast, explicitly addressed
to SystemUI. Both sides require the existing `STATUS_BAR_SERVICE` platform
signature permission. The v1 payload contains a bounded command identifier,
elapsed timestamp, current Android user, media-session token and pre-command
state. No sensor, media-control or root API is exported.

Ignored, partial, unsupported and training gestures emit no command events.
Transport failures retain their existing behavior; failure to publish feedback
does not change a successfully dispatched media command. A dispatched command is
not a confirmed player outcome. The native HeckerOS receiver follows actual media
state and the real glow's visibility before showing feedback.

The rebuilt input APK is at `prebuilts/OsloFeedback-MotionIsland.apk`, with build
provenance beside it. It must be imported/re-signed by the matching ROM; it is not
an installable update for another ROM's platform-signed Oslo package. Stable
branches and the existing root/attestation configuration are independent.

Air DJ is off by default. GoogleParts exposes `aware_air_dj` and the current
`aware_air_dj_mode` under Settings → System → Motion Sense. Enabling Air DJ turns
on Skip songs and Pause music because their existing flick and air-tap detectors
are used. Air tap selects a mode instead of pausing music while Air DJ is on.

| Mode | Air tap selects | Swipe in your configured next-track direction |
| --- | --- | --- |
| Track (0, blue) | Volume | Next track |
| Volume (1, green) | Seek | Raise session volume one step |
| Seek (2, orange) | Track | Seek forward ten seconds |

The opposite swipe selects previous track, lowers volume or seeks backward.
Modes can also be selected in GoogleParts. The mode survives a SystemUI restart;
turning Air DJ on starts in Track. With Air DJ off, normal skip and play/pause
handling runs unchanged. Turning off either required gesture in GoogleParts
also turns off Air DJ.

Only one eligible playing media session receives an Air DJ command. Existing
media-app and Ignore videos rules are rechecked at dispatch. Skip and seek require
the advertised action; fixed-volume sessions and unknown seek positions are
ignored. Seek positions account for playback speed and timestamp, and are clamped
to zero and the known duration. Volume follows the selected session, including
remote playback. There is no fallback from an unsupported action to skipping.

Air tap has a 750 ms cooldown; flick has a 500 ms cooldown. Failure to switch
mode or send a command is consumed without unexpected stock play/pause/skip
fallback. Success feedback means a command was sent, not that the player
completed it. The normal Show glow light and brightness controls still apply;
Air DJ uses mode colors while enabled and restores the user's tint when off.

## Build

The generated helper smali is committed so an APKEditor rebuild is self-contained.
After editing Java, regenerate it with the pinned tools:

```bash
APK_EDITOR_JAR=/path/APKEditor-1.4.9.jar \
ANDROID_JAR=/path/android-35/android.jar \
R8_JAR=/path/r8-8.7.18.jar \
bash airdj/build.sh /path/OsloFeedback-AirDJ.apk
```

This runs the policy and controller regression tests, compiles against the SDK,
regenerates helper smali and rebuilds all DEX without using stale APKEditor caches.
The GitHub workflow additionally aligns, signs with a validation
key and verifies its artifact. That key cannot update a platform-signed plugin
on an existing ROM. The ROM's `OsloFeedback` import must re-sign it with the
platform key.

## ROM integration and testing

Use `cnb-Latest-stable` in OsloFeedback and the paired coral device and vendor
repositories.

The vendor Motion Lab workflow builds a pinned Oslo source commit, validates it
and commits the prebuilt plugin to `cnb-Latest-stable`. A successful vendor
workflow is required before syncing and building. Update its source pin when
taking subsequent Oslo implementation changes.

Hardware checks still needed:

- Enable Motion Sense, play music, enable Air DJ and air tap through all three modes.
- Verify both swipe directions, session volume, ten-second seek and mode colors.
- Try an app without seek support and ensure it does not skip instead.
- Check media app exclusions, Ignore videos, stopped playback and repeated gestures.
- Disable Air DJ and verify normal skip and play/pause return.
- Disable a required gesture, restart SystemUI and reboot; check settings and behavior.
- Confirm alarm/call silence, presence, reach and wallpaper gestures still work.

Logs use the `Oslo.AirDJ` tag. Native ROM/GoogleParts compilation and on-device
testing cannot be replaced by the standalone plugin workflow.


## Motion Sense settings

Glow Light contains Show glow light, brightness, size, Rainbow, Match system
accent, and the single entry to Glow Theme Studio. The Studio saves the glow
style, animation speed and Gesture Trails, and offers an eight-second temporary
preview. Its entry is under Glow Light.

Motion Lab contains the Gesture Training Room. It uses real reach, left/right
swipe and air-tap detector events for a guided lesson with immediate feedback.
Gesture transport and foreground leases are cleaned up when the page closes.

The plugin no longer reads the former album artwork or night dimming settings.
Existing saved values therefore cannot reactivate those effects.

GoogleParts includes six original vector Lottie illustrations: Air DJ, the
Motion Lab lesson overview, Training, Glow Studio, Gesture Trails and Preview.
They use the existing theme and saved glow tint tags and respect disabled
system animations.
