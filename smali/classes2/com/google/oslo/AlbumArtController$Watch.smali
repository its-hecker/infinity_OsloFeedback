.class final Lcom/google/oslo/AlbumArtController$Watch;
.super Landroid/media/session/MediaController$Callback;
.source "AlbumArtController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/oslo/AlbumArtController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "Watch"
.end annotation


# instance fields
.field final controller:Landroid/media/session/MediaController;

.field playback:I

.field final synthetic this$0:Lcom/google/oslo/AlbumArtController;


# direct methods
.method constructor <init>(Lcom/google/oslo/AlbumArtController;Landroid/media/session/MediaController;)V
    .registers 3

    .line 94
    iput-object p1, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    invoke-direct {p0}, Landroid/media/session/MediaController$Callback;-><init>()V

    .line 93
    const/4 p1, -0x1

    iput p1, p0, Lcom/google/oslo/AlbumArtController$Watch;->playback:I

    .line 94
    iput-object p2, p0, Lcom/google/oslo/AlbumArtController$Watch;->controller:Landroid/media/session/MediaController;

    return-void
.end method


# virtual methods
.method close()V
    .registers 2

    .line 106
    :try_start_0
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->controller:Landroid/media/session/MediaController;

    invoke-virtual {v0, p0}, Landroid/media/session/MediaController;->unregisterCallback(Landroid/media/session/MediaController$Callback;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_5} :catch_6

    goto :goto_7

    :catch_6
    move-exception v0

    :goto_7
    return-void
.end method

.method public onMetadataChanged(Landroid/media/MediaMetadata;)V
    .registers 3

    .line 96
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # getter for: Lcom/google/oslo/AlbumArtController;->enabled:Z
    invoke-static {v0}, Lcom/google/oslo/AlbumArtController;->access$000(Lcom/google/oslo/AlbumArtController;)Z

    move-result v0

    if-eqz v0, :cond_15

    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # getter for: Lcom/google/oslo/AlbumArtController;->selected:Lcom/google/oslo/AlbumArtController$Watch;
    invoke-static {v0}, Lcom/google/oslo/AlbumArtController;->access$100(Lcom/google/oslo/AlbumArtController;)Lcom/google/oslo/AlbumArtController$Watch;

    move-result-object v0

    if-ne v0, p0, :cond_15

    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # invokes: Lcom/google/oslo/AlbumArtController;->schedule(Landroid/media/MediaMetadata;)V
    invoke-static {v0, p1}, Lcom/google/oslo/AlbumArtController;->access$200(Lcom/google/oslo/AlbumArtController;Landroid/media/MediaMetadata;)V

    .line 97
    :cond_15
    return-void
.end method

.method public onPlaybackStateChanged(Landroid/media/session/PlaybackState;)V
    .registers 3

    .line 99
    if-nez p1, :cond_4

    const/4 p1, -0x1

    goto :goto_8

    :cond_4
    invoke-virtual {p1}, Landroid/media/session/PlaybackState;->getState()I

    move-result p1

    .line 100
    :goto_8
    iget v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->playback:I

    if-eq p1, v0, :cond_13

    iput p1, p0, Lcom/google/oslo/AlbumArtController$Watch;->playback:I

    iget-object p1, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # invokes: Lcom/google/oslo/AlbumArtController;->choose()V
    invoke-static {p1}, Lcom/google/oslo/AlbumArtController;->access$300(Lcom/google/oslo/AlbumArtController;)V

    .line 101
    :cond_13
    return-void
.end method

.method public onSessionDestroyed()V
    .registers 3

    .line 103
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # getter for: Lcom/google/oslo/AlbumArtController;->enabled:Z
    invoke-static {v0}, Lcom/google/oslo/AlbumArtController;->access$000(Lcom/google/oslo/AlbumArtController;)Z

    move-result v0

    if-nez v0, :cond_9

    return-void

    .line 104
    :cond_9
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # getter for: Lcom/google/oslo/AlbumArtController;->watches:Ljava/util/LinkedHashMap;
    invoke-static {v0}, Lcom/google/oslo/AlbumArtController;->access$400(Lcom/google/oslo/AlbumArtController;)Ljava/util/LinkedHashMap;

    move-result-object v0

    iget-object v1, p0, Lcom/google/oslo/AlbumArtController$Watch;->controller:Landroid/media/session/MediaController;

    invoke-virtual {v1}, Landroid/media/session/MediaController;->getSessionToken()Landroid/media/session/MediaSession$Token;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0}, Lcom/google/oslo/AlbumArtController$Watch;->close()V

    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$Watch;->this$0:Lcom/google/oslo/AlbumArtController;

    # invokes: Lcom/google/oslo/AlbumArtController;->choose()V
    invoke-static {v0}, Lcom/google/oslo/AlbumArtController;->access$300(Lcom/google/oslo/AlbumArtController;)V

    .line 105
    return-void
.end method
