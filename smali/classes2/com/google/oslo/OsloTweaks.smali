.class public final Lcom/google/oslo/OsloTweaks;
.super Ljava/lang/Object;
.source "OsloTweaks.java"

# Reads the Motion Sense extras from Settings.Secure. The Settings app
# writes these keys; adb works too:
#   aware_any_media_app  1 = control any media app, 0 = Google's list only
#   aware_ignore_videos  1 = do not skip or pause videos from other apps
#   aware_glow_custom    1 = tint the glow, 0 = stock blue
#   aware_glow_hue       hue of the glow in degrees, 0-359 (default 270, violet)
#   aware_media_apps     comma-separated packages on the media app list; when
#                        unset, Google's media_app_whitelist is used


# static fields
.field private static sGlowObserverRegistered:Z

.field private static sGlows:Ljava/util/ArrayList;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getInt(Ljava/lang/String;I)I
    .locals 2
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "def"    # I

    :try_start_0
    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    move-result-object v0

    if-nez v0, :have_app

    return p1

    :have_app
    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {v0, p0, p1}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    move-exception v0

    return p1
.end method

.method private static getString(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "key"    # Ljava/lang/String;

    :try_start_0
    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    move-result-object v0

    if-nez v0, :have_app

    const/4 v1, 0x0

    return-object v1

    :have_app
    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {v0, p0}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    move-exception v0

    const/4 v1, 0x0

    return-object v1
.end method

# Glow brightness factor: 0 when aware_glow_show is off, else
# aware_glow_brightness / 100 (default 100 -> 1.0). Multiplied into mOpacity.
.method public static glowOpacityFactor()F
    .locals 2

    const-string v0, "aware_glow_show"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-nez v0, :shown

    const/4 v0, 0x0

    return v0

    :shown
    const-string v0, "aware_glow_brightness"

    const/16 v1, 0x64

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    invoke-static {}, Lcom/google/oslo/OsloTweaks;->nightDimFactor()F

    move-result v1

    mul-float/2addr v0, v1

    return v0
.end method

# Glow size factor: aware_glow_size / 100 (default 100 -> 1.0, range 50-150).
# Multiplied into the glow radius.
.method public static glowSizeFactor()F
    .locals 2

    const-string v0, "aware_glow_size"

    const/16 v1, 0x64

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    return v0
.end method

# System accent (Material You) hue 0-359 for the glow; 270 as a fallback.
.method public static accentHue()F
    .locals 5

    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    move-result-object v0

    if-nez v0, :have_app

    const v0, 0x43870000    # 270.0f

    return v0

    :have_app
    invoke-virtual {v0}, Landroid/app/Application;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "system_accent1_500"

    const-string v3, "color"

    const-string v4, "android"

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-nez v1, :have_id

    const v0, 0x43870000    # 270.0f

    return v0

    :have_id
    invoke-virtual {v0, v1}, Landroid/content/Context;->getColor(I)I

    move-result v0

    const/4 v1, 0x3

    new-array v1, v1, [F

    invoke-static {v0, v1}, Landroid/graphics/Color;->colorToHSV(I[F)V

    const/4 v0, 0x0

    aget v0, v1, v0

    return v0
.end method

# Night-dim multiplier: 0.4 inside the night window (aware_glow_night_start..6)
# when aware_glow_night is on, otherwise 1.0.
.method public static nightDimFactor()F
    .locals 3

    const-string v0, "aware_glow_night"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-eqz v0, :not_dim

    invoke-static {}, Ljava/time/LocalTime;->now()Ljava/time/LocalTime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/time/LocalTime;->getHour()I

    move-result v0

    const-string v1, "aware_glow_night_start"

    const/16 v2, 0x16

    invoke-static {v1, v2}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x6

    if-lt v1, v2, :non_wrap

    if-ge v0, v1, :dim

    if-lt v0, v2, :dim

    goto :not_dim

    :non_wrap
    if-lt v0, v1, :not_dim

    if-ge v0, v2, :not_dim

    :dim
    const v0, 0x3ecccccd    # 0.4f

    return v0

    :not_dim
    const/high16 v0, 0x3f800000    # 1.0f

    return v0
.end method

# True if pkg is on the media app list: aware_media_apps when it is set
# (written by the Motion Sense page), otherwise Google's whitelist.
.method public static isListedMediaApp(Ljava/lang/String;Ljava/util/Set;)Z
    .locals 3
    .param p0, "pkg"    # Ljava/lang/String;
    .param p1, "fallback"    # Ljava/util/Set;

    const/4 v2, 0x0

    if-nez p0, :have_pkg

    return v2

    :have_pkg
    const-string v0, "aware_media_apps"

    invoke-static {v0}, Lcom/google/oslo/OsloTweaks;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :custom_list

    if-nez p1, :use_fallback

    return v2

    :use_fallback
    invoke-interface {p1, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    return v0

    # ("," + list + ",").contains("," + pkg + ",")
    :custom_list
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method public static isAnyMediaAppEnabled()Z
    .locals 2

    const-string v0, "aware_any_media_app"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-eqz v0, :off

    return v1

    :off
    const/4 v1, 0x0

    return v1
.end method

.method public static isIgnoreVideosEnabled()Z
    .locals 2

    const-string v0, "aware_ignore_videos"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-eqz v0, :off

    return v1

    :off
    const/4 v1, 0x0

    return v1
.end method

# Rotates a stock glow color (average hue 215, blue) to aware_glow_hue,
# keeping its saturation, brightness and alpha.
.method public static tintGlow(I)I
    .locals 6
    .param p0, "color"    # I

    # Air DJ mode colors override tint only while both switches are on.
    const-string v0, "aware_air_dj"
    const/4 v1, 0x0
    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I
    move-result v0
    if-eqz v0, :normal_tint
    const-string v0, "aware_enabled"
    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I
    move-result v0
    if-eqz v0, :normal_tint
    const-string v0, "aware_air_dj_mode"
    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I
    move-result v0
    invoke-static {v0}, Lcom/google/oslo/AirDjPolicy;->glowHue(I)F
    move-result v0
    goto :have_hue
    :normal_tint
    invoke-static {}, Lcom/google/oslo/AlbumArtController;->getColor()I
    move-result v0
    if-eqz v0, :saved_tint
    invoke-static {p0}, Lcom/google/oslo/AlbumArtController;->tint(I)I
    move-result v0
    return v0
    :saved_tint
    const-string v0, "aware_glow_custom"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-nez v0, :custom

    return p0

    :custom
    const-string v0, "aware_glow_accent"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-eqz v0, :not_accent

    invoke-static {}, Lcom/google/oslo/OsloTweaks;->accentHue()F

    move-result v0

    goto :have_hue

    :not_accent
    const-string v0, "aware_glow_rainbow"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-eqz v0, :fixed_hue

    # rainbow: hue = (uptimeMillis / 16) % 360, a new color each activation
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x10

    div-long/2addr v2, v4

    const-wide/16 v4, 0x168

    rem-long/2addr v2, v4

    long-to-float v0, v2

    goto :have_hue

    :fixed_hue
    const-string v0, "aware_glow_hue"

    const/16 v1, 0x10e

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    int-to-float v0, v0

    :have_hue
    const/4 v1, 0x3

    new-array v1, v1, [F

    invoke-static {p0, v1}, Landroid/graphics/Color;->colorToHSV(I[F)V

    const/4 v2, 0x0

    aget v3, v1, v2

    add-float/2addr v3, v0

    # 215.0f
    const v4, 0x43570000

    sub-float/2addr v3, v4

    # 360.0f
    const v4, 0x43b40000

    add-float/2addr v3, v4

    rem-float/2addr v3, v4

    # rem-float keeps the sign, so fold a negative hue back into range
    const/4 v4, 0x0

    cmpg-float v4, v3, v4

    if-gez v4, :hue_ok

    const v4, 0x43b40000

    add-float/2addr v3, v4

    :hue_ok
    aput v3, v1, v2

    invoke-static {p0}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    invoke-static {v0, v1}, Landroid/graphics/Color;->HSVToColor(I[F)I

    move-result v0

    return v0
.end method

# Keeps a weak reference to each ShaderGlow, and registers one observer for
# the glow settings, so a new glow color shows without restarting SystemUI.
# Called on the main thread from the ShaderGlow constructor.
.method public static registerGlow(Ljava/lang/Object;)V
    .locals 4
    .param p0, "glow"    # Ljava/lang/Object;

    sget-object v0, Lcom/google/oslo/OsloTweaks;->sGlows:Ljava/util/ArrayList;

    if-nez v0, :have_list

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/google/oslo/OsloTweaks;->sGlows:Ljava/util/ArrayList;

    :have_list
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    sget-boolean v0, Lcom/google/oslo/OsloTweaks;->sGlowObserverRegistered:Z

    if-nez v0, :done

    :try_start_0
    invoke-static {}, Landroid/app/ActivityThread;->currentApplication()Landroid/app/Application;

    move-result-object v0

    if-eqz v0, :done

    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    new-instance v1, Lcom/google/oslo/OsloTweaks$GlowObserver;

    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-direct {v1, v2}, Lcom/google/oslo/OsloTweaks$GlowObserver;-><init>(Landroid/os/Handler;)V

    const/4 v3, 0x0

    const-string v2, "aware_enabled"
    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v2
    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_air_dj"
    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v2
    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_air_dj_mode"
    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v2
    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_custom"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_hue"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_show"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_brightness"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_size"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_rainbow"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_accent"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_night"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v2, "aware_glow_night_start"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/oslo/OsloTweaks;->sGlowObserverRegistered:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catch_0

    :done
    return-void

    :catch_0
    move-exception v0

    return-void
.end method

# Recolors every live ShaderGlow and drops the ones that are gone.
.method static notifyGlowChanged()V
    .locals 4

    sget-object v0, Lcom/google/oslo/OsloTweaks;->sGlows:Ljava/util/ArrayList;

    if-nez v0, :have_list

    return-void

    :have_list
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    :loop
    add-int/lit8 v1, v1, -0x1

    if-ltz v1, :done

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :alive

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :loop

    :alive
    :try_start_0
    check-cast v2, Lcom/google/oslo/ui/glow/ShaderGlow;

    invoke-virtual {v2}, Lcom/google/oslo/ui/glow/ShaderGlow;->onGlowColorChanged()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catch_0

    goto :loop

    :catch_0
    move-exception v3

    goto :loop

    :done
    return-void
.end method
