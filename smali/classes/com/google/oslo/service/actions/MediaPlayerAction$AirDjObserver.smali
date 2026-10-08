.class final Lcom/google/oslo/service/actions/MediaPlayerAction$AirDjObserver;
.super Landroid/database/ContentObserver;
.field private final mAction:Lcom/google/oslo/service/actions/MediaPlayerAction;

.method constructor <init>(Lcom/google/oslo/service/actions/MediaPlayerAction;Landroid/content/Context;)V
    .locals 2
    new-instance v0, Landroid/os/Handler;
    invoke-virtual {p2}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    invoke-direct {p0, v0}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V
    iput-object p1, p0, Lcom/google/oslo/service/actions/MediaPlayerAction$AirDjObserver;->mAction:Lcom/google/oslo/service/actions/MediaPlayerAction;
    return-void
.end method

.method public onChange(Z)V
    .locals 2
    iget-object v0, p0, Lcom/google/oslo/service/actions/MediaPlayerAction$AirDjObserver;->mAction:Lcom/google/oslo/service/actions/MediaPlayerAction;
    invoke-virtual {v0}, Lcom/google/oslo/service/actions/MediaPlayerAction;->updateActionDetectorRegistration()V
    invoke-virtual {v0}, Lcom/google/oslo/service/actions/MediaPlayerAction;->isActionDetectorRegistered()Z
    move-result v1
    if-eqz v1, :done
    invoke-virtual {v0}, Lcom/google/oslo/service/actions/MediaPlayerAction;->scanActiveMediaSessions()V
    :done
    return-void
.end method
