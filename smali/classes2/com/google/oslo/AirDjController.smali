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
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroid/media/session/MediaController;",
            ">;Z)Z"
        }
    .end annotation

    .line 77
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/google/oslo/AirDjController;->handleFlick(Landroid/content/Context;Ljava/util/List;ZI)Z

    move-result p0

    return p0
.end method

.method public static handleFlick(Landroid/content/Context;Ljava/util/List;ZI)Z
    .registers 20
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroid/media/session/MediaController;",
            ">;ZI)Z"
        }
    .end annotation

    .line 82
    const-string v11, "Oslo.AirDJ"

    const/4 v0, 0x0

    sput-object v0, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 83
    invoke-static/range {p0 .. p0}, Lcom/google/oslo/AirDjController;->isEnabled(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_d

    const/4 v0, 0x0

    return v0

    .line 85
    :cond_d
    const/4 v12, 0x1

    :try_start_e
    invoke-static/range {p1 .. p1}, Lcom/google/oslo/AirDjController;->playing(Ljava/util/List;)Landroid/media/session/MediaController;

    move-result-object v0

    .line 86
    if-eqz v0, :cond_ef

    sget-object v1, Lcom/google/oslo/AirDjController;->POLICY:Lcom/google/oslo/AirDjPolicy;

    .line 87
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x1f4

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/google/oslo/AirDjPolicy;->acceptGesture(JJ)Z

    move-result v1

    if-nez v1, :cond_24

    goto/16 :goto_ef

    .line 88
    :cond_24
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v1

    .line 89
    if-eqz v1, :cond_ee

    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getState()I

    move-result v2

    const/4 v3, 0x3

    if-eq v2, v3, :cond_33

    goto/16 :goto_ee

    .line 90
    :cond_33
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getActions()J

    move-result-wide v4

    .line 91
    move/from16 v2, p3

    invoke-static {v0, v2}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;I)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object v13

    .line 93
    invoke-static/range {p0 .. p0}, Lcom/google/oslo/AirDjController;->getMode(Landroid/content/Context;)I

    move-result v2

    const-wide/16 v14, 0x0

    packed-switch v2, :pswitch_data_f8

    .line 121
    return v12

    .line 110
    :pswitch_47
    const-wide/16 v2, 0x100

    and-long/2addr v2, v4

    cmp-long v2, v2, v14

    if-nez v2, :cond_4f

    return v12

    .line 111
    :cond_4f
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getMetadata()Landroid/media/MediaMetadata;

    move-result-object v2

    .line 112
    if-nez v2, :cond_57

    move-wide v8, v14

    goto :goto_5e

    .line 113
    :cond_57
    const-string v3, "android.media.metadata.DURATION"

    invoke-virtual {v2, v3}, Landroid/media/MediaMetadata;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    move-wide v8, v2

    .line 114
    :goto_5e
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getPosition()J

    move-result-wide v2

    .line 115
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getLastPositionUpdateTime()J

    move-result-wide v4

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    .line 116
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getPlaybackSpeed()F

    move-result v10

    .line 114
    move-wide v1, v2

    move-wide v3, v4

    move-wide v5, v6

    move v7, v10

    move/from16 v10, p2

    invoke-static/range {v1 .. v10}, Lcom/google/oslo/AirDjPolicy;->seekPosition(JJJFJZ)J

    move-result-wide v1

    .line 117
    cmp-long v3, v1, v14

    if-gez v3, :cond_7d

    return v12

    .line 118
    :cond_7d
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v3

    invoke-virtual {v3, v1, v2}, Landroid/media/session/MediaController$TransportControls;->seekTo(J)V

    .line 119
    if-eqz p2, :cond_88

    const/4 v1, 0x7

    goto :goto_8a

    :cond_88
    const/16 v1, 0x8

    .line 120
    :goto_8a
    goto :goto_ca

    .line 103
    :pswitch_8b
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackInfo()Landroid/media/session/MediaController$PlaybackInfo;

    move-result-object v1

    .line 104
    if-eqz v1, :cond_a6

    invoke-virtual {v1}, Landroid/media/session/MediaController$PlaybackInfo;->getVolumeControl()I

    move-result v1

    if-nez v1, :cond_98

    goto :goto_a6

    .line 106
    :cond_98
    if-eqz p2, :cond_9c

    move v1, v12

    goto :goto_9d

    :cond_9c
    const/4 v1, -0x1

    :goto_9d
    invoke-virtual {v0, v1, v12}, Landroid/media/session/MediaController;->adjustVolume(II)V

    .line 107
    if-eqz p2, :cond_a4

    const/4 v1, 0x5

    goto :goto_a5

    :cond_a4
    const/4 v1, 0x6

    .line 108
    :goto_a5
    goto :goto_ca

    .line 104
    :cond_a6
    :goto_a6
    return v12

    .line 95
    :pswitch_a7
    if-eqz p2, :cond_ac

    const-wide/16 v1, 0x20

    goto :goto_ae

    .line 96
    :cond_ac
    const-wide/16 v1, 0x10

    .line 97
    :goto_ae
    and-long/2addr v1, v4

    cmp-long v1, v1, v14

    if-nez v1, :cond_b4

    return v12

    .line 98
    :cond_b4
    if-eqz p2, :cond_be

    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/session/MediaController$TransportControls;->skipToNext()V

    goto :goto_c5

    .line 99
    :cond_be
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/session/MediaController$TransportControls;->skipToPrevious()V

    .line 100
    :goto_c5
    if-eqz p2, :cond_c8

    goto :goto_c9

    :cond_c8
    const/4 v3, 0x4

    .line 101
    :goto_c9
    move v1, v3

    .line 123
    :goto_ca
    move-object/from16 v2, p0

    invoke-static {v2, v0, v1, v13}, Lcom/google/oslo/MotionFeedback;->sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V

    .line 124
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 125
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
    :try_end_ed
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_ed} :catch_f0

    .line 129
    goto :goto_f6

    .line 89
    :cond_ee
    :goto_ee
    return v12

    .line 87
    :cond_ef
    :goto_ef
    return v12

    .line 126
    :catch_f0
    move-exception v0

    .line 128
    const-string v1, "Air DJ action failed"

    invoke-static {v11, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 130
    :goto_f6
    return v12

    nop

    :pswitch_data_f8
    .packed-switch 0x0
        :pswitch_a7
        :pswitch_8b
        :pswitch_47
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
    if-eqz p2, :cond_5f

    if-eqz p1, :cond_5f

    sget-object p2, Lcom/google/oslo/AirDjController;->POLICY:Lcom/google/oslo/AirDjPolicy;

    .line 59
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x2ee

    invoke-virtual {p2, v2, v3, v4, v5}, Lcom/google/oslo/AirDjPolicy;->acceptGesture(JJ)Z

    move-result p2

    if-nez p2, :cond_25

    goto :goto_5f

    .line 60
    :cond_25
    invoke-static {p0}, Lcom/google/oslo/AirDjController;->getMode(Landroid/content/Context;)I

    move-result p2

    invoke-static {p2}, Lcom/google/oslo/AirDjPolicy;->nextMode(I)I

    move-result p2

    .line 61
    invoke-static {p1}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object v2

    .line 62
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "aware_air_dj_mode"

    invoke-static {v3, v4, p2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_5e

    .line 63
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getPackageName()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/google/oslo/AirDjController;->lastActionPackage:Ljava/lang/String;

    .line 64
    add-int/lit8 v3, p2, 0x9

    invoke-static {p0, p1, v3, v2}, Lcom/google/oslo/MotionFeedback;->sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V

    .line 66
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
    :try_end_5e
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_5e} :catch_60

    .line 71
    :cond_5e
    goto :goto_66

    .line 59
    :cond_5f
    :goto_5f
    return v1

    .line 68
    :catch_60
    move-exception p0

    .line 70
    const-string p1, "Air DJ mode switch failed"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 72
    :goto_66
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
