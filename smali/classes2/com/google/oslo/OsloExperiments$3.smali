.class Lcom/google/oslo/OsloExperiments$3;
.super Ljava/lang/Object;
.source "OsloExperiments.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/oslo/OsloExperiments;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .registers 1

    .line 171
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 8

    .line 173
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 174
    sget-object v2, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    invoke-virtual {v2, v0, v1}, Lcom/google/oslo/ExperimentPolicy;->previewing(J)Z

    move-result v2

    .line 175
    sget-wide v3, Lcom/google/oslo/OsloExperiments;->gestureAt:J

    sub-long/2addr v0, v3

    .line 176
    const/4 v3, 0x0

    const/4 v4, 0x1

    if-nez v2, :cond_2c

    sget-boolean v2, Lcom/google/oslo/OsloExperiments;->shown:Z

    if-eqz v2, :cond_2a

    sget-boolean v2, Lcom/google/oslo/OsloExperiments;->trails:Z

    if-nez v2, :cond_1d

    sget v2, Lcom/google/oslo/OsloExperiments;->savedStyle:I

    if-eqz v2, :cond_2a

    :cond_1d
    const-wide/16 v5, 0x0

    cmp-long v2, v0, v5

    if-ltz v2, :cond_2a

    const-wide/16 v5, 0x4b0

    cmp-long v0, v0, v5

    if-gez v0, :cond_2a

    goto :goto_2c

    :cond_2a
    move v0, v3

    goto :goto_2d

    :cond_2c
    :goto_2c
    move v0, v4

    .line 177
    :goto_2d
    nop

    .line 178
    # getter for: Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$200()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    sub-int/2addr v1, v4

    move v2, v3

    :goto_38
    if-ltz v1, :cond_71

    .line 179
    # getter for: Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$200()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/ref/WeakReference;

    invoke-virtual {v5}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/opengl/GLSurfaceView;

    .line 180
    if-nez v5, :cond_54

    # getter for: Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$200()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_6e

    .line 181
    :cond_54
    instance-of v6, v5, Lcom/google/oslo/OsloExperiments$Surface;

    if-eqz v6, :cond_5e

    move-object v6, v5

    check-cast v6, Lcom/google/oslo/OsloExperiments$Surface;

    invoke-interface {v6}, Lcom/google/oslo/OsloExperiments$Surface;->refreshExperimentVisibility()V

    .line 182
    :cond_5e
    invoke-virtual {v5}, Landroid/opengl/GLSurfaceView;->isAttachedToWindow()Z

    move-result v6

    if-eqz v6, :cond_6e

    invoke-virtual {v5}, Landroid/opengl/GLSurfaceView;->getWindowVisibility()I

    move-result v6

    if-nez v6, :cond_6e

    .line 183
    invoke-virtual {v5}, Landroid/opengl/GLSurfaceView;->requestRender()V

    move v2, v4

    .line 178
    :cond_6e
    :goto_6e
    add-int/lit8 v1, v1, -0x1

    goto :goto_38

    .line 187
    :cond_71
    if-eqz v0, :cond_83

    sget-boolean v0, Lcom/google/oslo/OsloExperiments;->enabled:Z

    if-eqz v0, :cond_83

    if-eqz v2, :cond_83

    # getter for: Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$300()Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x21

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_86

    .line 188
    :cond_83
    # setter for: Lcom/google/oslo/OsloExperiments;->pumping:Z
    invoke-static {v3}, Lcom/google/oslo/OsloExperiments;->access$402(Z)Z

    .line 189
    :goto_86
    return-void
.end method
