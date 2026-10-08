.class public final Lcom/google/oslo/AlbumArtController;
.super Ljava/lang/Object;
.source "AlbumArtController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/oslo/AlbumArtController$Watch;
    }
.end annotation


# static fields
.field private static final INSTANCE:Lcom/google/oslo/AlbumArtController;

.field private static volatile color:I


# instance fields
.field private changed:Ljava/lang/Runnable;

.field private enabled:Z

.field private generation:J

.field private listenerRegistered:Z

.field private final main:Landroid/os/Handler;

.field private manager:Landroid/media/session/MediaSessionManager;

.field private pending:Ljava/lang/Runnable;

.field private selected:Lcom/google/oslo/AlbumArtController$Watch;

.field private final sessions:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

.field private thread:Landroid/os/HandlerThread;

.field private final watches:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Landroid/media/session/MediaSession$Token;",
            "Lcom/google/oslo/AlbumArtController$Watch;",
            ">;"
        }
    .end annotation
.end field

.field private worker:Landroid/os/Handler;


# direct methods
.method public static synthetic $r8$lambda$ez6rkgiJgUg6NuQpkwp5wF-eT8A(Lcom/google/oslo/AlbumArtController;Ljava/util/List;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/google/oslo/AlbumArtController;->updateSessions(Ljava/util/List;)V

    return-void
.end method

.method static constructor <clinit>()V
    .registers 1

    .line 20
    new-instance v0, Lcom/google/oslo/AlbumArtController;

    invoke-direct {v0}, Lcom/google/oslo/AlbumArtController;-><init>()V

    sput-object v0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    return-void
.end method

.method private constructor <init>()V
    .registers 3

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    .line 23
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    .line 54
    new-instance v0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda0;-><init>(Lcom/google/oslo/AlbumArtController;)V

    iput-object v0, p0, Lcom/google/oslo/AlbumArtController;->sessions:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

    .line 33
    return-void
.end method

.method static synthetic access$000(Lcom/google/oslo/AlbumArtController;)Z
    .registers 1

    .line 19
    iget-boolean p0, p0, Lcom/google/oslo/AlbumArtController;->enabled:Z

    return p0
.end method

.method static synthetic access$100(Lcom/google/oslo/AlbumArtController;)Lcom/google/oslo/AlbumArtController$Watch;
    .registers 1

    .line 19
    iget-object p0, p0, Lcom/google/oslo/AlbumArtController;->selected:Lcom/google/oslo/AlbumArtController$Watch;

    return-object p0
.end method

.method static synthetic access$200(Lcom/google/oslo/AlbumArtController;Landroid/media/MediaMetadata;)V
    .registers 2

    .line 19
    invoke-direct {p0, p1}, Lcom/google/oslo/AlbumArtController;->schedule(Landroid/media/MediaMetadata;)V

    return-void
.end method

.method static synthetic access$300(Lcom/google/oslo/AlbumArtController;)V
    .registers 1

    .line 19
    invoke-direct {p0}, Lcom/google/oslo/AlbumArtController;->choose()V

    return-void
.end method

.method static synthetic access$400(Lcom/google/oslo/AlbumArtController;)Ljava/util/LinkedHashMap;
    .registers 1

    .line 19
    iget-object p0, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    return-object p0
.end method

.method private choose()V
    .registers 6

    .line 78
    iget-boolean v0, p0, Lcom/google/oslo/AlbumArtController;->enabled:Z

    if-nez v0, :cond_5

    return-void

    .line 79
    :cond_5
    nop

    .line 80
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_10
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_30

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/oslo/AlbumArtController$Watch;

    .line 82
    :try_start_1d
    iget-object v3, v1, Lcom/google/oslo/AlbumArtController$Watch;->controller:Landroid/media/session/MediaController;

    invoke-virtual {v3}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v3

    .line 83
    if-eqz v3, :cond_2e

    invoke-virtual {v3}, Landroid/media/session/PlaybackState;->getState()I

    move-result v3
    :try_end_29
    .catch Ljava/lang/RuntimeException; {:try_start_1d .. :try_end_29} :catch_2d

    const/4 v4, 0x3

    if-ne v3, v4, :cond_2e

    goto :goto_31

    .line 84
    :catch_2d
    move-exception v1

    :cond_2e
    nop

    .line 85
    goto :goto_10

    .line 80
    :cond_30
    move-object v1, v2

    .line 86
    :goto_31
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->selected:Lcom/google/oslo/AlbumArtController$Watch;

    if-ne v0, v1, :cond_36

    return-void

    .line 87
    :cond_36
    iput-object v1, p0, Lcom/google/oslo/AlbumArtController;->selected:Lcom/google/oslo/AlbumArtController$Watch;

    .line 88
    if-nez v1, :cond_3e

    invoke-direct {p0, v2}, Lcom/google/oslo/AlbumArtController;->schedule(Landroid/media/MediaMetadata;)V

    goto :goto_4c

    .line 89
    :cond_3e
    :try_start_3e
    iget-object v0, v1, Lcom/google/oslo/AlbumArtController$Watch;->controller:Landroid/media/session/MediaController;

    invoke-virtual {v0}, Landroid/media/session/MediaController;->getMetadata()Landroid/media/MediaMetadata;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/google/oslo/AlbumArtController;->schedule(Landroid/media/MediaMetadata;)V
    :try_end_47
    .catch Ljava/lang/RuntimeException; {:try_start_3e .. :try_end_47} :catch_48

    goto :goto_4c

    :catch_48
    move-exception v0

    invoke-direct {p0, v2}, Lcom/google/oslo/AlbumArtController;->schedule(Landroid/media/MediaMetadata;)V

    .line 90
    :goto_4c
    return-void
.end method

.method public static configure(Landroid/content/Context;ZLjava/lang/Runnable;)V
    .registers 5

    .line 38
    sget-object v0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iput-object p2, v0, Lcom/google/oslo/AlbumArtController;->changed:Ljava/lang/Runnable;

    .line 39
    if-nez p1, :cond_c

    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    invoke-direct {p0}, Lcom/google/oslo/AlbumArtController;->stop()V

    return-void

    .line 40
    :cond_c
    sget-object p1, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-boolean p1, p1, Lcom/google/oslo/AlbumArtController;->enabled:Z

    if-eqz p1, :cond_13

    return-void

    .line 41
    :cond_13
    sget-object p1, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    const/4 p2, 0x1

    iput-boolean p2, p1, Lcom/google/oslo/AlbumArtController;->enabled:Z

    .line 43
    :try_start_18
    sget-object p1, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    const-class v0, Landroid/media/session/MediaSessionManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/media/session/MediaSessionManager;

    iput-object p0, p1, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    .line 44
    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object p0, p0, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    if-nez p0, :cond_30

    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    invoke-direct {p0}, Lcom/google/oslo/AlbumArtController;->stop()V

    return-void

    .line 45
    :cond_30
    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    new-instance p1, Landroid/os/HandlerThread;

    const-string v0, "OsloAlbumPalette"

    invoke-direct {p1, v0}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/google/oslo/AlbumArtController;->thread:Landroid/os/HandlerThread;

    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object p0, p0, Lcom/google/oslo/AlbumArtController;->thread:Landroid/os/HandlerThread;

    invoke-virtual {p0}, Landroid/os/HandlerThread;->start()V

    .line 46
    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    new-instance p1, Landroid/os/Handler;

    sget-object v0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object v0, v0, Lcom/google/oslo/AlbumArtController;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    .line 47
    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object p0, p0, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    sget-object p1, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object p1, p1, Lcom/google/oslo/AlbumArtController;->sessions:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

    sget-object v0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object v0, v0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Landroid/media/session/MediaSessionManager;->addOnActiveSessionsChangedListener(Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;Landroid/content/ComponentName;Landroid/os/Handler;)V

    .line 48
    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iput-boolean p2, p0, Lcom/google/oslo/AlbumArtController;->listenerRegistered:Z

    .line 49
    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    sget-object p1, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    iget-object p1, p1, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    invoke-virtual {p1, v1}, Landroid/media/session/MediaSessionManager;->getActiveSessions(Landroid/content/ComponentName;)Ljava/util/List;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/google/oslo/AlbumArtController;->updateSessions(Ljava/util/List;)V
    :try_end_74
    .catch Ljava/lang/RuntimeException; {:try_start_18 .. :try_end_74} :catch_75

    .line 52
    goto :goto_82

    .line 50
    :catch_75
    move-exception p0

    .line 51
    const-string p1, "Oslo.AlbumGlow"

    const-string p2, "Artwork monitor unavailable"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    sget-object p0, Lcom/google/oslo/AlbumArtController;->INSTANCE:Lcom/google/oslo/AlbumArtController;

    invoke-direct {p0}, Lcom/google/oslo/AlbumArtController;->stop()V

    .line 53
    :goto_82
    return-void
.end method

.method private static extract(Landroid/graphics/Bitmap;)I
    .registers 13

    .line 135
    nop

    .line 137
    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_3
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v2

    if-nez v2, :cond_a8

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    if-lez v2, :cond_a8

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    if-gtz v2, :cond_17

    goto/16 :goto_a8

    .line 138
    :cond_17
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x42400000    # 48.0f

    div-float/2addr v3, v2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 139
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    int-to-float v3, v3

    mul-float/2addr v3, v2

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    const/4 v4, 0x1

    invoke-static {v4, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 140
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    int-to-float v5, v5

    mul-float/2addr v5, v2

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v2

    invoke-static {v4, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 139
    invoke-static {p0, v3, v2, v4}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_4e
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_4e} :catch_be
    .catch Ljava/lang/OutOfMemoryError; {:try_start_3 .. :try_end_4e} :catch_be
    .catchall {:try_start_3 .. :try_end_4e} :catchall_ab

    .line 141
    :try_start_4e
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v3

    sget-object v4, Landroid/graphics/Bitmap$Config;->HARDWARE:Landroid/graphics/Bitmap$Config;

    if-ne v3, v4, :cond_6f

    .line 142
    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-virtual {v2, v3, v0}, Landroid/graphics/Bitmap;->copy(Landroid/graphics/Bitmap$Config;Z)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_5c
    .catch Ljava/lang/RuntimeException; {:try_start_4e .. :try_end_5c} :catch_a6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_4e .. :try_end_5c} :catch_a6
    .catchall {:try_start_4e .. :try_end_5c} :catchall_a4

    .line 143
    if-nez v1, :cond_70

    .line 150
    if-eqz v1, :cond_67

    if-eq v1, v2, :cond_67

    if-eq v1, p0, :cond_67

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 151
    :cond_67
    if-eqz v2, :cond_6e

    if-eq v2, p0, :cond_6e

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 143
    :cond_6e
    return v0

    .line 144
    :cond_6f
    move-object v1, v2

    .line 145
    :cond_70
    :try_start_70
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    mul-int/2addr v3, v4

    new-array v3, v3, [I

    .line 146
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v10

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v11

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v4, v1

    move-object v5, v3

    invoke-virtual/range {v4 .. v11}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 147
    invoke-static {v3}, Lcom/google/oslo/ArtworkPalette;->extract([I)I

    move-result v0
    :try_end_93
    .catch Ljava/lang/RuntimeException; {:try_start_70 .. :try_end_93} :catch_a6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_70 .. :try_end_93} :catch_a6
    .catchall {:try_start_70 .. :try_end_93} :catchall_a4

    .line 150
    if-eqz v1, :cond_9c

    if-eq v1, v2, :cond_9c

    if-eq v1, p0, :cond_9c

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 151
    :cond_9c
    if-eqz v2, :cond_a3

    if-eq v2, p0, :cond_a3

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 147
    :cond_a3
    return v0

    .line 150
    :catchall_a4
    move-exception v0

    goto :goto_ad

    .line 148
    :catch_a6
    move-exception v3

    goto :goto_c0

    .line 150
    :cond_a8
    :goto_a8
    nop

    .line 151
    nop

    .line 137
    return v0

    .line 150
    :catchall_ab
    move-exception v0

    move-object v2, v1

    :goto_ad
    if-eqz v1, :cond_b6

    if-eq v1, v2, :cond_b6

    if-eq v1, p0, :cond_b6

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 151
    :cond_b6
    if-eqz v2, :cond_bd

    if-eq v2, p0, :cond_bd

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 152
    :cond_bd
    throw v0

    .line 148
    :catch_be
    move-exception v2

    move-object v2, v1

    .line 150
    :goto_c0
    if-eqz v1, :cond_c9

    if-eq v1, v2, :cond_c9

    if-eq v1, p0, :cond_c9

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 151
    :cond_c9
    if-eqz v2, :cond_d0

    if-eq v2, p0, :cond_d0

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 148
    :cond_d0
    return v0
.end method

.method public static getColor()I
    .registers 1

    .line 34
    sget v0, Lcom/google/oslo/AlbumArtController;->color:I

    return v0
.end method

.method private publish(I)V
    .registers 3

    .line 109
    sget v0, Lcom/google/oslo/AlbumArtController;->color:I

    if-ne v0, p1, :cond_5

    return-void

    .line 110
    :cond_5
    sput p1, Lcom/google/oslo/AlbumArtController;->color:I

    iget-object p1, p0, Lcom/google/oslo/AlbumArtController;->changed:Ljava/lang/Runnable;

    if-eqz p1, :cond_10

    iget-object p1, p0, Lcom/google/oslo/AlbumArtController;->changed:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 111
    :cond_10
    return-void
.end method

.method private schedule(Landroid/media/MediaMetadata;)V
    .registers 6

    .line 113
    iget-wide v0, p0, Lcom/google/oslo/AlbumArtController;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/google/oslo/AlbumArtController;->generation:J

    .line 114
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    if-eqz v2, :cond_12

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    iget-object v3, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 115
    :cond_12
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    const/4 v3, 0x0

    if-eqz v2, :cond_1c

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 116
    :cond_1c
    nop

    .line 117
    if-eqz p1, :cond_36

    .line 118
    :try_start_1f
    const-string v2, "android.media.metadata.ART"

    invoke-virtual {p1, v2}, Landroid/media/MediaMetadata;->getBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_25
    .catch Ljava/lang/RuntimeException; {:try_start_1f .. :try_end_25} :catch_34

    .line 119
    if-nez v2, :cond_32

    :try_start_27
    const-string v3, "android.media.metadata.ALBUM_ART"

    invoke-virtual {p1, v3}, Landroid/media/MediaMetadata;->getBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object p1
    :try_end_2d
    .catch Ljava/lang/RuntimeException; {:try_start_27 .. :try_end_2d} :catch_2f

    move-object v3, p1

    goto :goto_35

    .line 120
    :catch_2f
    move-exception p1

    move-object v3, v2

    goto :goto_35

    .line 119
    :cond_32
    move-object v3, v2

    goto :goto_35

    .line 120
    :catch_34
    move-exception p1

    :goto_35
    nop

    .line 122
    :cond_36
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/google/oslo/AlbumArtController;->publish(I)V

    .line 123
    if-eqz v3, :cond_53

    iget-object p1, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    if-nez p1, :cond_41

    goto :goto_53

    .line 124
    :cond_41
    nop

    .line 125
    new-instance p1, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;

    invoke-direct {p1, p0, v0, v1, v3}, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;-><init>(Lcom/google/oslo/AlbumArtController;JLandroid/graphics/Bitmap;)V

    iput-object p1, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    .line 132
    iget-object p1, p0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    const-wide/16 v1, 0x96

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 133
    return-void

    .line 123
    :cond_53
    :goto_53
    return-void
.end method

.method private stop()V
    .registers 6

    .line 155
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/oslo/AlbumArtController;->enabled:Z

    iget-wide v1, p0, Lcom/google/oslo/AlbumArtController;->generation:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/google/oslo/AlbumArtController;->generation:J

    .line 156
    iget-object v1, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    if-eqz v1, :cond_15

    iget-object v1, p0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_15
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/google/oslo/AlbumArtController;->pending:Ljava/lang/Runnable;

    .line 157
    iget-boolean v2, p0, Lcom/google/oslo/AlbumArtController;->listenerRegistered:Z

    if-eqz v2, :cond_2a

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    if-eqz v2, :cond_2a

    :try_start_20
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    iget-object v3, p0, Lcom/google/oslo/AlbumArtController;->sessions:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

    invoke-virtual {v2, v3}, Landroid/media/session/MediaSessionManager;->removeOnActiveSessionsChangedListener(Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;)V
    :try_end_27
    .catch Ljava/lang/RuntimeException; {:try_start_20 .. :try_end_27} :catch_28

    goto :goto_29

    .line 158
    :catch_28
    move-exception v2

    :goto_29
    nop

    .line 159
    :cond_2a
    iput-boolean v0, p0, Lcom/google/oslo/AlbumArtController;->listenerRegistered:Z

    .line 160
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_36
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_46

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/oslo/AlbumArtController$Watch;

    invoke-virtual {v3}, Lcom/google/oslo/AlbumArtController$Watch;->close()V

    goto :goto_36

    :cond_46
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->clear()V

    iput-object v1, p0, Lcom/google/oslo/AlbumArtController;->selected:Lcom/google/oslo/AlbumArtController$Watch;

    .line 161
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    if-eqz v2, :cond_56

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    invoke-virtual {v2, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 162
    :cond_56
    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->thread:Landroid/os/HandlerThread;

    if-eqz v2, :cond_5f

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    :cond_5f
    iput-object v1, p0, Lcom/google/oslo/AlbumArtController;->thread:Landroid/os/HandlerThread;

    iput-object v1, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    iput-object v1, p0, Lcom/google/oslo/AlbumArtController;->manager:Landroid/media/session/MediaSessionManager;

    .line 163
    invoke-direct {p0, v0}, Lcom/google/oslo/AlbumArtController;->publish(I)V

    .line 164
    return-void
.end method

.method public static tint(I)I
    .registers 2

    .line 35
    sget v0, Lcom/google/oslo/AlbumArtController;->color:I

    invoke-static {p0, v0}, Lcom/google/oslo/ArtworkPalette;->tint(II)I

    move-result p0

    return p0
.end method

.method private updateSessions(Ljava/util/List;)V
    .registers 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/media/session/MediaController;",
            ">;)V"
        }
    .end annotation

    .line 56
    iget-boolean v0, p0, Lcom/google/oslo/AlbumArtController;->enabled:Z

    if-nez v0, :cond_5

    return-void

    .line 57
    :cond_5
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 58
    if-eqz p1, :cond_2b

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_10
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2b

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/session/MediaController;

    .line 59
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    const/16 v3, 0x10

    if-ne v2, v3, :cond_25

    goto :goto_2b

    .line 60
    :cond_25
    if-eqz v1, :cond_2a

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 61
    :cond_2a
    goto :goto_10

    .line 62
    :cond_2b
    :goto_2b
    new-instance p1, Ljava/util/LinkedHashMap;

    invoke-direct {p1}, Ljava/util/LinkedHashMap;-><init>()V

    .line 63
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_34
    :goto_34
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6a

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/session/MediaController;

    .line 65
    :try_start_40
    invoke-virtual {v1}, Landroid/media/session/MediaController;->getSessionToken()Landroid/media/session/MediaSession$Token;

    move-result-object v2
    :try_end_44
    .catch Ljava/lang/RuntimeException; {:try_start_40 .. :try_end_44} :catch_68

    .line 66
    if-eqz v2, :cond_34

    invoke-virtual {p1, v2}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4d

    goto :goto_34

    .line 67
    :cond_4d
    iget-object v3, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v3, v2}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/oslo/AlbumArtController$Watch;

    .line 68
    if-nez v3, :cond_64

    .line 69
    new-instance v3, Lcom/google/oslo/AlbumArtController$Watch;

    invoke-direct {v3, p0, v1}, Lcom/google/oslo/AlbumArtController$Watch;-><init>(Lcom/google/oslo/AlbumArtController;Landroid/media/session/MediaController;)V

    .line 70
    :try_start_5c
    iget-object v4, p0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    invoke-virtual {v1, v3, v4}, Landroid/media/session/MediaController;->registerCallback(Landroid/media/session/MediaController$Callback;Landroid/os/Handler;)V
    :try_end_61
    .catch Ljava/lang/RuntimeException; {:try_start_5c .. :try_end_61} :catch_62

    goto :goto_64

    :catch_62
    move-exception v1

    goto :goto_34

    .line 72
    :cond_64
    :goto_64
    invoke-virtual {p1, v2, v3}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 73
    goto :goto_34

    .line 65
    :catch_68
    move-exception v1

    goto :goto_34

    .line 74
    :cond_6a
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_74
    :goto_74
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_92

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/session/MediaSession$Token;

    invoke-virtual {p1, v1}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_74

    iget-object v2, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v2, v1}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/oslo/AlbumArtController$Watch;

    invoke-virtual {v1}, Lcom/google/oslo/AlbumArtController$Watch;->close()V

    goto :goto_74

    .line 75
    :cond_92
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->clear()V

    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1}, Ljava/util/LinkedHashMap;->putAll(Ljava/util/Map;)V

    invoke-direct {p0}, Lcom/google/oslo/AlbumArtController;->choose()V

    .line 76
    return-void
.end method


# virtual methods
.method synthetic lambda$schedule$0$com-google-oslo-AlbumArtController(JI)V
    .registers 6

    .line 129
    iget-boolean v0, p0, Lcom/google/oslo/AlbumArtController;->enabled:Z

    if-eqz v0, :cond_d

    iget-wide v0, p0, Lcom/google/oslo/AlbumArtController;->generation:J

    cmp-long p1, p1, v0

    if-nez p1, :cond_d

    invoke-direct {p0, p3}, Lcom/google/oslo/AlbumArtController;->publish(I)V

    :cond_d
    return-void
.end method

.method synthetic lambda$schedule$1$com-google-oslo-AlbumArtController(Landroid/graphics/Bitmap;J)V
    .registers 6

    .line 128
    invoke-static {p1}, Lcom/google/oslo/AlbumArtController;->extract(Landroid/graphics/Bitmap;)I

    move-result p1

    .line 129
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->main:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0, p2, p3, p1}, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda3;-><init>(Lcom/google/oslo/AlbumArtController;JI)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 130
    return-void
.end method

.method synthetic lambda$schedule$2$com-google-oslo-AlbumArtController(JLandroid/graphics/Bitmap;)V
    .registers 6

    .line 126
    iget-boolean v0, p0, Lcom/google/oslo/AlbumArtController;->enabled:Z

    if-eqz v0, :cond_1a

    iget-wide v0, p0, Lcom/google/oslo/AlbumArtController;->generation:J

    cmp-long v0, p1, v0

    if-nez v0, :cond_1a

    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    if-nez v0, :cond_f

    goto :goto_1a

    .line 127
    :cond_f
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController;->worker:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p3, p1, p2}, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;-><init>(Lcom/google/oslo/AlbumArtController;Landroid/graphics/Bitmap;J)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 131
    return-void

    .line 126
    :cond_1a
    :goto_1a
    return-void
.end method
