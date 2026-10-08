#!/usr/bin/env python3
"""Run the real artwork controller with deterministic media callbacks and queued workers.

The build separately compiles against the real Android SDK; these small doubles
exercise callback order, ownership and stale results rather than device rendering.
"""
import subprocess
import tempfile
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
STUBS={
 'content/Context': '''import android.media.session.MediaSessionManager;
public class Context {
 public final MediaSessionManager manager=new MediaSessionManager();
 public <T> T getSystemService(Class<T> type) { return type.cast(manager); }
}''',
 'os/Looper': '''import java.util.ArrayList;
public class Looper {
 public static final Looper MAIN=new Looper(); public static Looper work;
 public final ArrayList<Runnable> queue=new ArrayList<>();
 public static Looper getMainLooper() { return MAIN; }
 public void drain() { while(!queue.isEmpty()) queue.remove(0).run(); }
}''',
 'os/Handler': '''public class Handler {
 private final Looper looper; public Handler(Looper l) { looper=l; }
 public boolean post(Runnable r) { looper.queue.add(r); return true; }
 public boolean postDelayed(Runnable r,long delay) { return post(r); }
 public void removeCallbacks(Runnable r) { looper.queue.removeIf(x -> x==r); }
 public void removeCallbacksAndMessages(Object token) { looper.queue.clear(); }
}''',
 'os/HandlerThread': '''public class HandlerThread {
 private final Looper looper=new Looper(); public static int stopped;
 public HandlerThread(String name) { Looper.work=looper; }
 public void start() {} public Looper getLooper() { return looper; }
 public boolean quitSafely() { stopped++; return true; }
}''',
 'util/Log': '''public class Log { public static int w(String tag,String text,Throwable e) { return 0; } }''',
 'graphics/Bitmap': '''public class Bitmap {
 public enum Config { ARGB_8888,HARDWARE }
 public int width,height,color; public Config config=Config.ARGB_8888;
 public boolean recycled; public static int largestRead;
 public Bitmap(int w,int h,int c) { width=w; height=h; color=c; }
 public int getWidth() { return width; } public int getHeight() { return height; }
 public boolean isRecycled() { return recycled; } public Config getConfig() { return config; }
 public static Bitmap createScaledBitmap(Bitmap b,int w,int h,boolean filter) {
  if(w==b.width && h==b.height) return b;
  Bitmap result=new Bitmap(w,h,b.color);result.config=b.config;return result;
 }
 public Bitmap copy(Config c,boolean mutable) { Bitmap b=new Bitmap(width,height,color);b.config=c;return b; }
 public void getPixels(int[] out,int offset,int stride,int x,int y,int w,int h) {
  if(recycled || config==Config.HARDWARE) throw new IllegalStateException();
  largestRead=Math.max(largestRead,w*h);java.util.Arrays.fill(out,color);
 }
 public void recycle() { recycled=true; }
}''',
 'media/MediaMetadata': '''import android.graphics.Bitmap;
public class MediaMetadata {
 public static final String METADATA_KEY_ART="art",METADATA_KEY_ALBUM_ART="album";
 public Bitmap art,album; public Bitmap getBitmap(String key) { return key.equals("art") ? art : album; }
}''',
 'media/session/MediaSession': '''public class MediaSession { public static class Token {} }''',
 'media/session/PlaybackState': '''public class PlaybackState {
 public static final int STATE_PLAYING=3; public final int state;
 public PlaybackState(int value) { state=value; } public int getState() { return state; }
}''',
 'media/session/MediaController': '''import android.media.MediaMetadata;
import android.os.Handler;import java.util.ArrayList;
public class MediaController {
 public final MediaSession.Token token=new MediaSession.Token();
 public PlaybackState state=new PlaybackState(3); public MediaMetadata metadata;
 public boolean denied; public int removed;
 public final ArrayList<Callback> callbacks=new ArrayList<>();
 public MediaSession.Token getSessionToken() { return token; }
 public PlaybackState getPlaybackState() { return state; } public MediaMetadata getMetadata() { return metadata; }
 public void registerCallback(Callback cb,Handler h) { if(denied) throw new SecurityException(); callbacks.add(cb); }
 public void unregisterCallback(Callback cb) { callbacks.remove(cb); removed++; }
 public void playback(int value) { state=new PlaybackState(value); for(Callback cb:new ArrayList<>(callbacks)) cb.onPlaybackStateChanged(state); }
 public void artwork(MediaMetadata value) { metadata=value; for(Callback cb:new ArrayList<>(callbacks)) cb.onMetadataChanged(value); }
 public void destroy() { for(Callback cb:new ArrayList<>(callbacks)) cb.onSessionDestroyed(); }
 public static class Callback {
  public void onMetadataChanged(MediaMetadata value) {} public void onPlaybackStateChanged(PlaybackState value) {}
  public void onSessionDestroyed() {}
 }
}''',
 'media/session/MediaSessionManager': '''import android.os.Handler;import java.util.List;import java.util.ArrayList;
public class MediaSessionManager {
 public boolean denied; public int added,removed;
 public List<MediaController> controllers=new ArrayList<>(); public OnActiveSessionsChangedListener listener;
 public interface OnActiveSessionsChangedListener { void onActiveSessionsChanged(List<MediaController> list); }
 public void addOnActiveSessionsChangedListener(OnActiveSessionsChangedListener l,Object n,Handler h) {
  if(denied) throw new SecurityException(); listener=l; added++;
 }
 public void removeOnActiveSessionsChangedListener(OnActiveSessionsChangedListener l) { listener=null; removed++; }
 public List<MediaController> getActiveSessions(Object n) { return controllers; }
 public void update(List<MediaController> list) { controllers=list; if(listener!=null) listener.onActiveSessionsChanged(list); }
}''',
}
TEST='''package com.google.oslo;
import android.content.Context;import android.graphics.Bitmap;import android.media.MediaMetadata;
import android.media.session.MediaController;import android.os.Looper;import android.os.HandlerThread;
import java.util.Arrays;import java.util.ArrayList;
public class AlbumArtControllerTest {
 static int checks,changes; static void check(boolean c,String message) { checks++;if(!c)throw new AssertionError(message); }
 static MediaMetadata art(Bitmap b) { MediaMetadata m=new MediaMetadata();m.art=b;return m; }
 static void flush() { Looper.MAIN.drain();if(Looper.work!=null)Looper.work.drain();Looper.MAIN.drain(); }
 static void configure(Context c,boolean enabled) { AlbumArtController.configure(c,enabled,() -> changes++); }
 public static void main(String[] args) {
  Context c=new Context();configure(c,false);
  check(c.manager.added==0 && AlbumArtController.getColor()==0,"off has no listener or tint");
  Bitmap red=new Bitmap(1,1,0xffff0000),blue=new Bitmap(1,1,0xff0000ff);
  MediaController a=new MediaController();a.metadata=art(red);
  c.manager.controllers=Arrays.asList(a);configure(c,true);flush();
  check(AlbumArtController.getColor()==0xffff0000 && changes==1,"playing track publishes artwork");
  check(!red.recycled,"player bitmap is never recycled");
  configure(c,true);check(c.manager.added==1 && a.callbacks.size()==1,"repeated enable has one subscription");
  a.playback(2);check(AlbumArtController.getColor()==0,"pause restores saved tint immediately");
  a.playback(3);flush();check(AlbumArtController.getColor()==0xffff0000,"resume refreshes artwork");
  a.artwork(new MediaMetadata());flush();check(AlbumArtController.getColor()==0,"missing art clears old track");
  MediaMetadata album=new MediaMetadata();album.album=blue;a.artwork(album);flush();
  check(AlbumArtController.getColor()==0xff0000ff,"album bitmap fallback");
  a.artwork(art(red));Looper.MAIN.drain();Runnable old=Looper.work.queue.remove(0);
  a.artwork(art(blue));old.run();Looper.MAIN.drain();
  check(AlbumArtController.getColor()==0,"stale worker result cannot tint new track");
  flush();check(AlbumArtController.getColor()==0xff0000ff,"newest track wins");
  a.artwork(art(red));Looper.MAIN.drain();old=Looper.work.queue.remove(0);
  configure(c,false);old.run();flush();
  check(AlbumArtController.getColor()==0 && a.callbacks.isEmpty() && c.manager.listener==null,"disable invalidates work and removes subscriptions");
  check(HandlerThread.stopped==1,"worker shuts down on disable");
  MediaController b=new MediaController();b.metadata=art(blue);a.state=new android.media.session.PlaybackState(2);
  c.manager.controllers=Arrays.asList(a,b);configure(c,true);flush();
  check(AlbumArtController.getColor()==0xff0000ff && a.callbacks.size()==1,"paused session is watched but not selected");
  a.playback(3);flush();check(AlbumArtController.getColor()==0xffff0000,"higher-priority session takes over when playing");
  a.destroy();flush();check(AlbumArtController.getColor()==0xff0000ff,"destroyed session falls back to playing session");
  c.manager.update(Arrays.asList(b,b));flush();check(b.callbacks.size()==1,"duplicate session tokens register once");
  Bitmap hardware=new Bitmap(2048,1024,0xff00ff00);hardware.config=Bitmap.Config.HARDWARE;
  b.artwork(art(hardware));flush();
  check(AlbumArtController.getColor()==0xff00ff00 && Bitmap.largestRead<=2304 && !hardware.recycled,"hardware artwork is sampled with bounded pixels and safe ownership");
  Bitmap dead=new Bitmap(1,1,0xffff0000);dead.recycle();b.artwork(art(dead));flush();
  check(AlbumArtController.getColor()==0,"recycled player bitmap fails safely");
  c.manager.update(new ArrayList<>());check(b.callbacks.isEmpty() && AlbumArtController.getColor()==0,"removed sessions clean up");
  configure(c,false);c.manager.denied=true;configure(c,true);flush();
  check(AlbumArtController.getColor()==0 && c.manager.listener==null,"permission failure leaves saved tint");
  c.manager.denied=false;ArrayList<MediaController> many=new ArrayList<>();
  for(int i=0;i<20;i++) { MediaController m=new MediaController();m.metadata=art(blue);many.add(m); }
  c.manager.controllers=many;configure(c,true);flush();int subscriptions=0;
  for(MediaController m:many)subscriptions+=m.callbacks.size();
  check(subscriptions==16,"session subscriptions are bounded");configure(c,false);
  System.out.println("Album artwork controller: "+checks+" checks passed");
 }
}
'''
with tempfile.TemporaryDirectory(prefix='album-glow-tests-') as temp:
    temp=Path(temp)
    for name,source in STUBS.items():
        p=temp/('android/'+name+'.java');p.parent.mkdir(parents=True,exist_ok=True)
        package='android.'+name.rsplit('/',1)[0].replace('/','.')
        p.write_text('package '+package+';\n'+source)
    (temp/'AlbumArtControllerTest.java').write_text(TEST)
    classes=temp/'classes'
    sources=list(temp.rglob('*.java'))+[ROOT/'airdj/src/com/google/oslo/AlbumArtController.java',ROOT/'airdj/src/com/google/oslo/ArtworkPalette.java']
    subprocess.run(['java','com.sun.tools.javac.Main','-d',str(classes)]+[str(p) for p in sources],check=True)
    subprocess.run(['java','-cp',str(classes),'com.google.oslo.AlbumArtControllerTest'],check=True)
