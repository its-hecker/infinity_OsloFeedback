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
    .locals 5
    .param p0, "color"    # I

    const-string v0, "aware_glow_custom"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-nez v0, :custom

    return p0

    :custom
    const-string v0, "aware_glow_hue"

    const/16 v1, 0x10e

    invoke-static {v0, v1}, Lcom/google/oslo/OsloTweaks;->getInt(Ljava/lang/String;I)I

    move-result v0

    int-to-float v0, v0

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
