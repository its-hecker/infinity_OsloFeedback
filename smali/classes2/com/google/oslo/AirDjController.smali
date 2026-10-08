.class public final Lcom/google/oslo/AirDjController;
.super Ljava/lang/Object;
.source "AirDjController.java"


# static fields
.field public static final ENABLED:Ljava/lang/String; = "aware_air_dj"

.field public static final MODE:Ljava/lang/String; = "aware_air_dj_mode"

.field private static final POLICY:Lcom/google/oslo/AirDjPolicy;

.field private static final TAG:Ljava/lang/String; = "Oslo.AirDJ"

.field private static lastActionPackage:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 17
    new-instance v0, Lcom/google/oslo/AirDjPolicy;

    invoke-direct {v0}, Lcom/google/oslo/AirDjPolicy;-><init>()V

    sput-object v0, Lcom/google/oslo/AirDjController;->POLICY:Lcom/google/oslo/AirDjPolicy;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getLastActionPackage()Ljava/lang/String;
    .registers 1

    .line 49
    sget-object v0, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    return-object v0
.end method

.method private static getMode(Landroid/content/Context;)I
    .registers 3

    .line 35
    nop

    .line 36
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v0, "aware_air_dj_mode"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0

    .line 35
    invoke-static {p0}, Lcom/google/oslo/AirDjPolicy;->normalizeMode(I)I

    move-result p0

    return p0
.end method

.method public static handleFlick(Landroid/content/Context;Ljava/util/List;Z)Z
    .registers 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroid/media/session/MediaController;",
            ">;Z)Z"
        }
    .end annotation

    .line 74
    const-string v11, "Oslo.AirDJ"

    const/4 v0, 0x0

    sput-object v0, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 75
    invoke-static {p0}, Lcom/google/oslo/AirDjController;->isEnabled(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_d

    const/4 v0, 0x0

    return v0

    .line 77
    :cond_d
    const/4 v12, 0x1

    :try_start_e
    invoke-static/range {p1 .. p1}, Lcom/google/oslo/AirDjController;->playing(Ljava/util/List;)Landroid/media/session/MediaController;

    move-result-object v0

    .line 78
    if-eqz v0, :cond_d7

    sget-object v1, Lcom/google/oslo/AirDjController;->POLICY:Lcom/google/oslo/AirDjPolicy;

    .line 79
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x1f4

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/google/oslo/AirDjPolicy;->acceptGesture(JJ)Z

    move-result v1

    if-nez v1, :cond_24

    goto/16 :goto_d7

    .line 80
    :cond_24
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v1

    .line 81
    if-eqz v1, :cond_d6

    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getState()I

    move-result v2

    const/4 v3, 0x3

    if-eq v2, v3, :cond_33

    goto/16 :goto_d6

    .line 82
    :cond_33
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getActions()J

    move-result-wide v2

    .line 83
    invoke-static {p0}, Lcom/google/oslo/AirDjController;->getMode(Landroid/content/Context;)I

    move-result v4

    const-wide/16 v13, 0x0

    packed-switch v4, :pswitch_data_e0

    goto/16 :goto_b7

    .line 98
    :pswitch_42
    const-wide/16 v4, 0x100

    and-long/2addr v2, v4

    cmp-long v2, v2, v13

    if-nez v2, :cond_4a

    return v12

    .line 99
    :cond_4a
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getMetadata()Landroid/media/MediaMetadata;

    move-result-object v2

    .line 100
    if-nez v2, :cond_52

    move-wide v8, v13

    goto :goto_59

    .line 101
    :cond_52
    const-string v3, "android.media.metadata.DURATION"

    invoke-virtual {v2, v3}, Landroid/media/MediaMetadata;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    move-wide v8, v2

    .line 102
    :goto_59
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getPosition()J

    move-result-wide v2

    .line 103
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getLastPositionUpdateTime()J

    move-result-wide v4

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    .line 104
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getPlaybackSpeed()F

    move-result v10

    .line 102
    move-wide v1, v2

    move-wide v3, v4

    move-wide v5, v6

    move v7, v10

    move/from16 v10, p2

    invoke-static/range {v1 .. v10}, Lcom/google/oslo/AirDjPolicy;->seekPosition(JJJFJZ)J

    move-result-wide v1

    .line 105
    cmp-long v3, v1, v13

    if-gez v3, :cond_78

    return v12

    .line 106
    :cond_78
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v3

    invoke-virtual {v3, v1, v2}, Landroid/media/session/MediaController$TransportControls;->seekTo(J)V

    goto :goto_b7

    .line 92
    :pswitch_80
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackInfo()Landroid/media/session/MediaController$PlaybackInfo;

    move-result-object v1

    .line 93
    if-eqz v1, :cond_96

    invoke-virtual {v1}, Landroid/media/session/MediaController$PlaybackInfo;->getVolumeControl()I

    move-result v1

    if-nez v1, :cond_8d

    goto :goto_96

    .line 95
    :cond_8d
    if-eqz p2, :cond_91

    move v1, v12

    goto :goto_92

    :cond_91
    const/4 v1, -0x1

    :goto_92
    invoke-virtual {v0, v1, v12}, Landroid/media/session/MediaController;->adjustVolume(II)V

    .line 96
    goto :goto_b7

    .line 93
    :cond_96
    :goto_96
    return v12

    .line 85
    :pswitch_97
    if-eqz p2, :cond_9c

    const-wide/16 v4, 0x20

    goto :goto_9e

    .line 86
    :cond_9c
    const-wide/16 v4, 0x10

    .line 87
    :goto_9e
    and-long v1, v2, v4

    cmp-long v1, v1, v13

    if-nez v1, :cond_a5

    return v12

    .line 88
    :cond_a5
    if-eqz p2, :cond_af

    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/session/MediaController$TransportControls;->skipToNext()V

    goto :goto_b7

    .line 89
    :cond_af
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/session/MediaController$TransportControls;->skipToPrevious()V

    .line 90
    nop

    .line 109
    :goto_b7
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 110
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Action sent to "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v11, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_d5
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_d5} :catch_d8

    .line 114
    goto :goto_de

    .line 81
    :cond_d6
    :goto_d6
    return v12

    .line 79
    :cond_d7
    :goto_d7
    return v12

    .line 111
    :catch_d8
    move-exception v0

    .line 113
    const-string v1, "Air DJ action failed"

    invoke-static {v11, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 115
    :goto_de
    return v12

    nop

    :pswitch_data_e0
    .packed-switch 0x0
        :pswitch_97
        :pswitch_80
        :pswitch_42
    .end packed-switch
.end method

.method public static handleTap(Landroid/content/Context;Ljava/util/List;Z)Z
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroid/media/session/MediaController;",
            ">;Z)Z"
        }
    .end annotation

    .line 54
    const-string v0, "Oslo.AirDJ"

    const/4 v1, 0x0

    sput-object v1, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 55
    invoke-static {p0}, Lcom/google/oslo/AirDjController;->isEnabled(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_d

    const/4 p0, 0x0

    return p0

    .line 57
    :cond_d
    const/4 v1, 0x1

    :try_start_e
    invoke-static {p1}, Lcom/google/oslo/AirDjController;->playing(Ljava/util/List;)Landroid/media/session/MediaController;

    move-result-object p1

    .line 58
    if-eqz p2, :cond_56

    if-eqz p1, :cond_56

    sget-object p2, Lcom/google/oslo/AirDjController;->POLICY:Lcom/google/oslo/AirDjPolicy;

    .line 59
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x2ee

    invoke-virtual {p2, v2, v3, v4, v5}, Lcom/google/oslo/AirDjPolicy;->acceptGesture(JJ)Z

    move-result p2

    if-nez p2, :cond_25

    goto :goto_56

    .line 60
    :cond_25
    invoke-static {p0}, Lcom/google/oslo/AirDjController;->getMode(Landroid/content/Context;)I

    move-result p2

    invoke-static {p2}, Lcom/google/oslo/AirDjPolicy;->nextMode(I)I

    move-result p2

    .line 61
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v2, "aware_air_dj_mode"

    invoke-static {p0, v2, p2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-result p0

    if-eqz p0, :cond_55

    .line 62
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getPackageName()Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 63
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "Mode: "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_55
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_55} :catch_57

    .line 68
    :cond_55
    goto :goto_5d

    .line 59
    :cond_56
    :goto_56
    return v1

    .line 65
    :catch_57
    move-exception p0

    .line 67
    const-string p1, "Air DJ mode switch failed"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 69
    :goto_5d
    return v1
.end method

.method public static isEnabled(Landroid/content/Context;)Z
    .registers 4

    .line 24
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "aware_air_dj"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1b

    .line 25
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "aware_enabled"

    invoke-static {p0, v1, v0}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0

    if-ne p0, v2, :cond_1b

    goto :goto_1c

    :cond_1b
    move v2, v0

    .line 26
    :goto_1c
    if-nez v2, :cond_23

    sget-object p0, Lcom/google/oslo/AirDjController;->POLICY:Lcom/google/oslo/AirDjPolicy;

    invoke-virtual {p0}, Lcom/google/oslo/AirDjPolicy;->reset()V
    :try_end_23
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_23} :catch_24

    .line 27
    :cond_23
    return v2

    .line 28
    :catch_24
    move-exception p0

    .line 29
    const-string v1, "Oslo.AirDJ"

    const-string v2, "Unable to read Air DJ settings"

    invoke-static {v1, v2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 30
    return v0
.end method

.method private static playing(Ljava/util/List;)Landroid/media/session/MediaController;
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/media/session/MediaController;",
            ">;)",
            "Landroid/media/session/MediaController;"
        }
    .end annotation

    .line 40
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_4
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1f

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/session/MediaController;

    .line 41
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v1

    .line 42
    if-eqz v1, :cond_1e

    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getState()I

    move-result v1

    const/4 v2, 0x3

    if-ne v1, v2, :cond_1e

    return-object v0

    .line 43
    :cond_1e
    goto :goto_4

    .line 44
    :cond_1f
    const/4 p0, 0x0

    return-object p0
.end method
