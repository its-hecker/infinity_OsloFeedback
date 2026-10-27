"""Run the production controller with small deterministic Android API doubles.

The build also compiles it against the real SDK; these doubles test behavior, not API shape.
"""
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[2]
STUBS = {
    'content/ContentResolver': '''public class ContentResolver {
        public java.util.Map<String, Integer> settings = new java.util.HashMap<>();
        public boolean writable = true;
    }''',
    'content/Context': '''public class Context {
        private final ContentResolver resolver = new ContentResolver();
        public ContentResolver getContentResolver() { return resolver; }
        public final java.util.List<Intent> events = new java.util.ArrayList<>();
        public String permission; public boolean failFeedback;
        public void sendBroadcast(Intent event, String permission) {
            if(failFeedback) throw new IllegalStateException("feedback receiver unavailable");
            this.permission=permission;events.add(event);
        }
    }''',
    'content/Intent': '''public class Intent {
        public final String action;public String target;
        public final java.util.Map<String,Object> extras=new java.util.HashMap<>();
        public Intent(String action){this.action=action;}
        public Intent setPackage(String target){this.target=target;return this;}
        public Intent putExtra(String key,Object value){extras.put(key,value);return this;}
    }''',
    'app/ActivityManager': '''public class ActivityManager {
        public static int user;public static int getCurrentUser(){return user;}
    }''',
    'provider/Settings': '''public class Settings {
        public static class Secure {
            public static int getInt(android.content.ContentResolver r, String key, int fallback) {
                return r.settings.getOrDefault(key, fallback);
            }
            public static boolean putInt(android.content.ContentResolver r, String key, int value) {
                if (!r.writable) return false;
                r.settings.put(key, value); return true;
            }
        }
    }''',
    'os/SystemClock': '''public class SystemClock {
        public static long now = 10000;
        public static long elapsedRealtime() { return now; }
    }''',
    'util/Log': '''public class Log {
        public static int w(String tag, String msg, Throwable error) { return 0; }
        public static int i(String tag, String msg) { return 0; }
    }''',
    'media/MediaMetadata': '''public class MediaMetadata {
        public static final String METADATA_KEY_DURATION = "duration";
        public static final String METADATA_KEY_MEDIA_ID="id",METADATA_KEY_TITLE="title";
        public long duration;
        public long getLong(String key) { return duration; }
        public String getString(String key){return null;}
    }''',
    'media/session/PlaybackState': '''public class PlaybackState {
        public static final int STATE_PLAYING = 3;
        public static final long ACTION_SKIP_TO_NEXT = 32, ACTION_SKIP_TO_PREVIOUS = 16,
                ACTION_SEEK_TO = 256;
        public int state = 3; public long actions = 304, position = 20000, updated;
        public float speed = 1;
        public int getState() { return state; }
        public long getActions() { return actions; }
        public long getPosition() { return position; }
        public long getLastPositionUpdateTime() { return updated; }
        public float getPlaybackSpeed() { return speed; }
        public long getActiveQueueItemId(){return -1;}
    }''',
    'media/session/MediaController': '''public class MediaController {
        public final String name;
        public PlaybackState state = new PlaybackState();
        public PlaybackInfo info = new PlaybackInfo();
        public android.media.MediaMetadata metadata = new android.media.MediaMetadata();
        public final TransportControls controls = new TransportControls();
        public int volumeCalls, direction; public boolean dead;
        public MediaController(String name) { this.name = name; }
        public String getPackageName() { return name; }
        public String getSessionToken(){return name;}
        public PlaybackState getPlaybackState() { return state; }
        public PlaybackInfo getPlaybackInfo() { return info; }
        public android.media.MediaMetadata getMetadata() { return metadata; }
        public TransportControls getTransportControls() {
            if (dead) throw new IllegalStateException("session died");
            return controls;
        }
        public void adjustVolume(int direction, int flags) { volumeCalls++; this.direction = direction; }
        public static class PlaybackInfo {
            public int control = 1;
            public int getVolumeControl() { return control; }
            public int getCurrentVolume(){return 5;}
        }
        public static class TransportControls {
            public int next, previous, seeks,plays,pauses; public long target;
            public void play(){plays++;}public void pause(){pauses++;}
            public void skipToNext() { next++; }
            public void skipToPrevious() { previous++; }
            public void seekTo(long target) { seeks++; this.target = target; }
        }
    }''',
}

TEST = '''package com.google.oslo;
import android.content.Context;
import android.media.session.MediaController;
import android.os.SystemClock;
import android.provider.Settings;
import java.util.Arrays;
import java.util.Collections;

public class AirDjControllerTest {
    private static int checks;
    private static void check(boolean condition, String message) {
        checks++; if (!condition) throw new AssertionError(message);
    }
    private static Context enabled(int mode) {
        Context c = new Context();
        Settings.Secure.putInt(c.getContentResolver(), "aware_enabled", 1);
        AirDjController.isEnabled(c); // default-off resets debounce state
        Settings.Secure.putInt(c.getContentResolver(), AirDjController.ENABLED, 1);
        Settings.Secure.putInt(c.getContentResolver(), AirDjController.MODE, mode);
        SystemClock.now = 10000;
        return c;
    }
    public static void main(String[] args) {
        MediaController a = new MediaController("a"), b = new MediaController("b");
        Context c = new Context();
        check(!AirDjController.handleFlick(c, Arrays.asList(a), true), "off falls through");
        Settings.Secure.putInt(c.getContentResolver(), AirDjController.ENABLED, 1);
        check(!AirDjController.handleTap(c, Arrays.asList(a), true), "master off falls through");
        c = enabled(0);
        check(AirDjController.handleTap(c, Arrays.asList(a), false), "nondetection consumed");
        check(Settings.Secure.getInt(c.getContentResolver(), AirDjController.MODE, -1) == 0,
                "nondetection doesn't cycle");
        AirDjController.handleTap(c, Collections.emptyList(), true);
        check(Settings.Secure.getInt(c.getContentResolver(), AirDjController.MODE, -1) == 0,
                "no playing media doesn't cycle");
        AirDjController.handleTap(c, Arrays.asList(a), true);
        check(Settings.Secure.getInt(c.getContentResolver(), AirDjController.MODE, -1) == 1,
                "tap cycles to volume");
        AirDjController.handleTap(c, Arrays.asList(a), true);
        check(Settings.Secure.getInt(c.getContentResolver(), AirDjController.MODE, -1) == 1,
                "duplicate tap suppressed");
        SystemClock.now += 750;
        AirDjController.handleTap(c, Arrays.asList(a), true);
        check(Settings.Secure.getInt(c.getContentResolver(), AirDjController.MODE, -1) == 2,
                "tap cycles to seek");
        SystemClock.now += 750;
        AirDjController.handleTap(c, Arrays.asList(a), true);
        check(Settings.Secure.getInt(c.getContentResolver(), AirDjController.MODE, -1) == 0,
                "tap wraps to track");
        c = enabled(0);
        AirDjController.handleFlick(c, Arrays.asList(a, b), true);
        check(a.controls.next == 1 && b.controls.next == 0, "one target only");
        SystemClock.now += 500;
        AirDjController.handleFlick(c, Arrays.asList(a), false);
        check(a.controls.previous == 1, "reverse direction");
        c = enabled(0); a.state.actions = 16;
        AirDjController.handleFlick(c, Arrays.asList(a), true);
        check(a.controls.next == 1 && AirDjController.getLastActionPackage() == null,
                "unsupported next no false success");
        c = enabled(1);
        AirDjController.handleFlick(c, Arrays.asList(a), true);
        check(a.volumeCalls == 1 && a.direction == 1, "session volume route");
        SystemClock.now += 500; a.info.control = 0;
        AirDjController.handleFlick(c, Arrays.asList(a), true);
        check(a.volumeCalls == 1 && AirDjController.getLastActionPackage() == null,
                "fixed volume ignored and previous success cleared");
        c = enabled(2); a.state.actions = 256; a.state.updated = 8000;
        AirDjController.handleFlick(c, Arrays.asList(a), true);
        check(a.controls.target == 32000, "seek compensates stale position");
        c = enabled(2); a.state.actions = 0;
        AirDjController.handleFlick(c, Arrays.asList(a), true);
        check(a.controls.seeks == 1, "no seek fallback to skip");
        c = enabled(2); a.state.actions = 256; a.state.position = -1;
        AirDjController.handleFlick(c, Arrays.asList(a), true);
        check(a.controls.seeks == 1, "unknown position ignored");
        c = enabled(0); b.dead = true;
        check(AirDjController.handleFlick(c, Arrays.asList(b), true)
                && AirDjController.getLastActionPackage() == null, "dead session consumed safely");
        c = enabled(99); b.dead = false; a.state.state = 2;
        AirDjController.handleFlick(c, Arrays.asList(a, b), true);
        check(b.controls.next == 1, "invalid mode normalizes; paused session ignored");
        c = enabled(0); c.getContentResolver().writable = false;
        AirDjController.handleTap(c, Arrays.asList(b), true);
        check(AirDjController.getLastActionPackage() == null, "failed setting write no success");
        check(c.events.isEmpty(), "failed mode write produces no feedback");
        c=enabled(0); a.dead=false;a.state.state=3;a.state.actions=304;
        android.app.ActivityManager.user=10;
        AirDjController.handleFlick(c,Arrays.asList(a),true);
        check(c.events.size()==1,"successful Air DJ dispatch emits one event");
        var event=c.events.get(0);
        check(event.action.equals(MotionFeedback.ACTION)&&event.target.equals("com.android.systemui")
                &&c.permission.equals("android.permission.STATUS_BAR_SERVICE"),"package/permission-scoped event");
        check(event.extras.get("action").equals(MotionFeedback.NEXT)
                &&event.extras.get("user").equals(10)&&event.extras.get("session").equals("a"),"real action/session/current user");
        int count=c.events.size();
        AirDjController.handleFlick(c,Arrays.asList(a),true);
        check(c.events.size()==count,"cooldown rejection emits nothing");
        MotionFeedback.play(c,a);MotionFeedback.pause(c,a);MotionFeedback.previous(c,a);
        check(a.controls.plays==1&&a.controls.pauses==1&&c.events.size()==count+3,"stock wrappers dispatch once then report");
        count=c.events.size();b.dead=true;
        try {MotionFeedback.next(c,b);throw new AssertionError("dead command accepted");}
        catch(IllegalStateException expected){}
        check(c.events.size()==count,"failed transport emits nothing");
        c.failFeedback=true;int sent=a.controls.next;MotionFeedback.next(c,a);
        check(a.controls.next==sent+1&&c.events.size()==count,"feedback failure preserves actual media action");
        c.failFeedback=false;var snapshot=MotionFeedback.before(a);android.app.ActivityManager.user=11;
        MotionFeedback.sent(c,a,MotionFeedback.NEXT,snapshot);
        check(c.events.size()==count,"user switch during dispatch cannot relabel old session as the new user");
        android.app.ActivityManager.user=10;
        MotionFeedback.next(c,a,4);
        check(c.events.get(c.events.size()-1).extras.get("direction").equals(-1),
                "next uses physical left even when skip mapping reversed");
        MotionFeedback.previous(c,a,2);
        check(c.events.get(c.events.size()-1).extras.get("direction").equals(1),
                "previous uses physical right rather than semantic action");
        MotionFeedback.pause(c,a);
        check(c.events.get(c.events.size()-1).extras.get("direction").equals(0),
                "tap never inherits prior flick direction");
        check(MotionFeedback.physicalDirection(1)==1&&MotionFeedback.physicalDirection(8)==1
                &&MotionFeedback.physicalDirection(5)==-1&&MotionFeedback.physicalDirection(6)==-1
                &&MotionFeedback.physicalDirection(0)==0&&MotionFeedback.physicalDirection(3)==0,
                "raw direction matches native OsloOverlay switch including diagonals");
        c=enabled(0);a.dead=false;a.state.state=3;a.state.actions=304;
        AirDjController.handleFlick(c,Arrays.asList(a),true,5);
        check(c.events.size()==1&&c.events.get(0).extras.get("direction").equals(-1),
                "Air DJ preserves raw side independently of forward flag");
        System.out.println("Air DJ controller: " + checks + " checks passed");
    }
}
'''

with tempfile.TemporaryDirectory(prefix='airdj-tests-') as temp:
    temp = Path(temp)
    for name, source in STUBS.items():
        file = temp / ('android/' + name + '.java')
        file.parent.mkdir(parents=True, exist_ok=True)
        package = 'android.' + name.rsplit('/', 1)[0].replace('/', '.')
        file.write_text('package ' + package + ';\n' + source)
    test = temp / 'AirDjControllerTest.java'
    test.write_text(TEST)
    classes = temp / 'classes'
    sources = list(temp.rglob('*.java')) + [ROOT / 'airdj/src/com/google/oslo/AirDjPolicy.java',
            ROOT / 'airdj/src/com/google/oslo/MotionFeedback.java',
            ROOT / 'airdj/src/com/google/oslo/AirDjController.java']
    subprocess.run(['java', 'com.sun.tools.javac.Main', '-d', str(classes)]
                   + [str(p) for p in sources], check=True)
    subprocess.run(['java', '-cp', str(classes), 'com.google.oslo.AirDjControllerTest'], check=True)
