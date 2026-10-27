.class public final Lcom/google/oslo/MotionFeedback;
.super Ljava/lang/Object;
.source "MotionFeedback.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/oslo/MotionFeedback$Snapshot;
    }
.end annotation


# static fields
.field public static final ACTION:Ljava/lang/String; = "com.google.oslo.HECKER_MOTION_FEEDBACK"

.field public static final MODE_SEEK:I = 0xb

.field public static final MODE_TRACK:I = 0x9

.field public static final MODE_VOLUME:I = 0xa

.field public static final NEXT:I = 0x3

.field public static final PAUSE:I = 0x2

.field public static final PLAY:I = 0x1

.field public static final PREVIOUS:I = 0x4

.field public static final SEEK_BACK:I = 0x8

.field public static final SEEK_FORWARD:I = 0x7

.field public static final VOLUME_DOWN:I = 0x6

.field public static final VOLUME_UP:I = 0x5


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static before(Landroid/media/session/MediaController;)Lcom/google/oslo/MotionFeedback$Snapshot;
    .registers 2

    .line 28
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;I)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object p0

    return-object p0
.end method

.method public static before(Landroid/media/session/MediaController;I)Lcom/google/oslo/MotionFeedback$Snapshot;
    .registers 10

    .line 39
    new-instance v0, Lcom/google/oslo/MotionFeedback$Snapshot;

    invoke-direct {v0}, Lcom/google/oslo/MotionFeedback$Snapshot;-><init>()V

    .line 40
    invoke-static {p1}, Lcom/google/oslo/MotionFeedback;->physicalDirection(I)I

    move-result p1

    iput p1, v0, Lcom/google/oslo/MotionFeedback$Snapshot;->direction:I

    .line 41
    invoke-static {}, Lcom/google/oslo/MotionFeedback;->currentUser()I

    move-result p1

    iput p1, v0, Lcom/google/oslo/MotionFeedback$Snapshot;->user:I

    .line 43
    :try_start_11
    invoke-virtual {p0}, Landroid/media/session/MediaController;->getMetadata()Landroid/media/MediaMetadata;

    move-result-object p1

    .line 44
    invoke-virtual {p0}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v1

    .line 45
    const/4 v2, 0x0

    if-nez p1, :cond_1e

    move-object v3, v2

    goto :goto_24

    :cond_1e
    const-string v3, "android.media.metadata.MEDIA_ID"

    invoke-virtual {p1, v3}, Landroid/media/MediaMetadata;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 46
    :goto_24
    if-nez p1, :cond_27

    :goto_26
    goto :goto_2e

    :cond_27
    const-string v2, "android.media.metadata.TITLE"

    invoke-virtual {p1, v2}, Landroid/media/MediaMetadata;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_26

    .line 47
    :goto_2e
    const-wide/16 v4, -0x1

    if-nez v1, :cond_34

    move-wide v6, v4

    goto :goto_38

    :cond_34
    invoke-virtual {v1}, Landroid/media/session/PlaybackState;->getActiveQueueItemId()J

    move-result-wide v6

    .line 48
    :goto_38
    if-nez v3, :cond_40

    if-nez v2, :cond_40

    cmp-long p1, v6, v4

    if-eqz p1, :cond_69

    .line 49
    :cond_40
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v3}, Lcom/google/oslo/MotionFeedback;->bounded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const/16 v1, 0xa

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v2}, Lcom/google/oslo/MotionFeedback;->bounded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/google/oslo/MotionFeedback$Snapshot;->identity:Ljava/lang/String;

    .line 50
    :cond_69
    invoke-virtual {p0}, Landroid/media/session/MediaController;->getPlaybackInfo()Landroid/media/session/MediaController$PlaybackInfo;

    move-result-object p0

    .line 51
    if-eqz p0, :cond_77

    invoke-virtual {p0}, Landroid/media/session/MediaController$PlaybackInfo;->getCurrentVolume()I

    move-result p0

    iput p0, v0, Lcom/google/oslo/MotionFeedback$Snapshot;->volume:I
    :try_end_75
    .catch Ljava/lang/RuntimeException; {:try_start_11 .. :try_end_75} :catch_76

    goto :goto_77

    .line 52
    :catch_76
    move-exception p0

    :cond_77
    :goto_77
    nop

    .line 53
    return-object v0
.end method

.method private static bounded(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .line 57
    if-nez p0, :cond_5

    const-string p0, ""

    goto :goto_14

    :cond_5
    const/16 v0, 0xc0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    :goto_14
    return-object p0
.end method

.method private static currentUser()I
    .registers 4

    .line 61
    :try_start_0
    const-class v0, Landroid/app/ActivityManager;

    const-string v1, "getCurrentUser"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_18
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_18} :catch_19
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_18} :catch_19

    return v0

    .line 62
    :catch_19
    move-exception v0

    const/4 v0, -0x1

    return v0
.end method

.method public static next(Landroid/content/Context;Landroid/media/session/MediaController;)V
    .registers 3

    .line 99
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/google/oslo/MotionFeedback;->next(Landroid/content/Context;Landroid/media/session/MediaController;I)V

    .line 100
    return-void
.end method

.method public static next(Landroid/content/Context;Landroid/media/session/MediaController;I)V
    .registers 4

    .line 102
    invoke-static {p1, p2}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;I)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object p2

    .line 103
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v0

    invoke-virtual {v0}, Landroid/media/session/MediaController$TransportControls;->skipToNext()V

    .line 104
    const/4 v0, 0x3

    invoke-static {p0, p1, v0, p2}, Lcom/google/oslo/MotionFeedback;->sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V

    .line 105
    return-void
.end method

.method public static pause(Landroid/content/Context;Landroid/media/session/MediaController;)V
    .registers 4

    .line 94
    invoke-static {p1}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object v0

    .line 95
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/session/MediaController$TransportControls;->pause()V

    .line 96
    const/4 v1, 0x2

    invoke-static {p0, p1, v1, v0}, Lcom/google/oslo/MotionFeedback;->sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V

    .line 97
    return-void
.end method

.method public static physicalDirection(I)I
    .registers 3

    .line 33
    const/4 v0, 0x1

    if-eq p0, v0, :cond_19

    const/4 v1, 0x2

    if-eq p0, v1, :cond_19

    const/16 v1, 0x8

    if-ne p0, v1, :cond_b

    goto :goto_19

    .line 34
    :cond_b
    const/4 v0, 0x4

    if-eq p0, v0, :cond_17

    const/4 v0, 0x5

    if-eq p0, v0, :cond_17

    const/4 v0, 0x6

    if-ne p0, v0, :cond_15

    goto :goto_17

    .line 35
    :cond_15
    const/4 p0, 0x0

    return p0

    .line 34
    :cond_17
    :goto_17
    const/4 p0, -0x1

    return p0

    .line 33
    :cond_19
    :goto_19
    return v0
.end method

.method public static play(Landroid/content/Context;Landroid/media/session/MediaController;)V
    .registers 4

    .line 89
    invoke-static {p1}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object v0

    .line 90
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/session/MediaController$TransportControls;->play()V

    .line 91
    const/4 v1, 0x1

    invoke-static {p0, p1, v1, v0}, Lcom/google/oslo/MotionFeedback;->sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V

    .line 92
    return-void
.end method

.method public static previous(Landroid/content/Context;Landroid/media/session/MediaController;)V
    .registers 3

    .line 107
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/google/oslo/MotionFeedback;->previous(Landroid/content/Context;Landroid/media/session/MediaController;I)V

    .line 108
    return-void
.end method

.method public static previous(Landroid/content/Context;Landroid/media/session/MediaController;I)V
    .registers 4

    .line 110
    invoke-static {p1, p2}, Lcom/google/oslo/MotionFeedback;->before(Landroid/media/session/MediaController;I)Lcom/google/oslo/MotionFeedback$Snapshot;

    move-result-object p2

    .line 111
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object v0

    invoke-virtual {v0}, Landroid/media/session/MediaController$TransportControls;->skipToPrevious()V

    .line 112
    const/4 v0, 0x4

    invoke-static {p0, p1, v0, p2}, Lcom/google/oslo/MotionFeedback;->sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V

    .line 113
    return-void
.end method

.method public static sent(Landroid/content/Context;Landroid/media/session/MediaController;ILcom/google/oslo/MotionFeedback$Snapshot;)V
    .registers 8

    .line 68
    const/4 v0, 0x1

    if-lt p2, v0, :cond_6e

    const/16 v1, 0xb

    if-le p2, v1, :cond_8

    goto :goto_6e

    .line 71
    :cond_8
    :try_start_8
    iget v1, p3, Lcom/google/oslo/MotionFeedback$Snapshot;->user:I

    .line 72
    if-ltz v1, :cond_64

    invoke-static {}, Lcom/google/oslo/MotionFeedback;->currentUser()I

    move-result v2

    if-eq v2, v1, :cond_13

    goto :goto_64

    .line 73
    :cond_13
    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.google.oslo.HECKER_MOTION_FEEDBACK"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v3, "com.android.systemui"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    const-string v3, "version"

    .line 74
    invoke-virtual {v2, v3, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v0

    const-string v2, "action"

    invoke-virtual {v0, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object p2

    const-string v0, "direction"

    iget v2, p3, Lcom/google/oslo/MotionFeedback$Snapshot;->direction:I

    .line 75
    invoke-virtual {p2, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object p2

    const-string v0, "user"

    .line 76
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object p2

    const-string v0, "when"

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    invoke-virtual {p2, v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    move-result-object p2

    const-string v0, "session"

    .line 77
    invoke-virtual {p1}, Landroid/media/session/MediaController;->getSessionToken()Landroid/media/session/MediaSession$Token;

    move-result-object p1

    invoke-virtual {p2, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object p1

    const-string p2, "before_identity"

    iget-object v0, p3, Lcom/google/oslo/MotionFeedback$Snapshot;->identity:Ljava/lang/String;

    .line 78
    invoke-virtual {p1, p2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    const-string p2, "before_volume"

    iget p3, p3, Lcom/google/oslo/MotionFeedback$Snapshot;->volume:I

    .line 79
    invoke-virtual {p1, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object p1

    .line 82
    const-string p2, "android.permission.STATUS_BAR_SERVICE"

    invoke-virtual {p0, p1, p2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;Ljava/lang/String;)V
    :try_end_63
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_63} :catch_65

    .line 85
    goto :goto_6d

    .line 72
    :cond_64
    :goto_64
    return-void

    .line 83
    :catch_65
    move-exception p0

    .line 84
    const-string p1, "Oslo.MotionFeedback"

    const-string p2, "Motion feedback unavailable"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 86
    :goto_6d
    return-void

    .line 68
    :cond_6e
    :goto_6e
    return-void
.end method
