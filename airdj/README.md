# Air DJ (experimental)

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
The experimental GitHub workflow additionally aligns, signs with a validation
key and verifies its artifact. That key cannot update a platform-signed plugin
on an existing ROM. The ROM's `OsloFeedback` import must re-sign it with the
platform key.

## ROM integration and testing

Pair `features-experimental` in the coral device and vendor repositories. Both
branches start from the current `faceid` baseline; Air DJ does not establish
Face Unlock runtime compatibility. Stable Oslo `cnb`, device `lineage-24.0` and
the existing `faceid` branches are independent of these feature commits.

The vendor feature workflow builds a pinned Oslo source commit, validates it and
commits the prebuilt plugin only to `features-experimental`. A successful vendor
workflow is required before syncing/building that branch. Update its source pin
when taking subsequent Oslo feature changes.

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


## Motion Lab additions

GoogleParts exposes Touchless Game Arcade (Air Dodge / Target Rush), Gesture Training
Room, Air Control Panel, and Glow Theme Studio on `features-experimental`. The first
three bind Oslo's existing gesture service while resumed, subscribe to detected
flick/tap/reach events and deduplicate regular/echo callbacks. No new continuous
hand-position sensor is assumed. A foreground heartbeat renews a six-second,
permission-protected lease that suppresses built-in media actions while the lab is
open. Pausing the page unregisters listeners and ends the lease; expiry handles a
missed cleanup. Alarm/call actions keep their stock behavior.

Glow presets (Stock / Neon / Aurora / Pixel / Minimal), animation speed (50–200%)
and directional Gesture Trails are opt-in Secure settings. The extra GLES pass
uses the existing Oslo surface and redraws at most for the 1.2-second feedback or
eight-second preview window. It restores the stock program, vertex buffer and
visibility. Surface recreation resets its GL program. Preview commands carry a
unique token and draft values in memory; they never write the saved theme. A stale
page's cleanup cannot stop a newer page's session.

The control panel targets one active media session and checks supported controls;
Play / pause can resume a paused session. Flashlight permission is requested on
use. The torch keeps the state selected by the user when the panel closes, while
radar subscriptions stop. Default stock settings and the Air DJ switch are kept.

Checks cover policy expiry/token isolation, game/lesson rules, existing Air DJ
controller tests, public Android API compilation, AAPT resource linking, GLES
shader rendering, DEX rebuilding, alignment and validation signing. These do not
replace a full Android 17 ROM build and real Pixel 4 XL Soli/UI testing.
