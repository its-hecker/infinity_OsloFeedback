.class public final synthetic Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/content/Context;

.field public final synthetic f$1:Landroid/opengl/GLSurfaceView;


# direct methods
.method public synthetic constructor <init>(Landroid/content/Context;Landroid/opengl/GLSurfaceView;)V
    .registers 3

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;->f$0:Landroid/content/Context;

    iput-object p2, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;->f$1:Landroid/opengl/GLSurfaceView;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 3

    .line 0
    iget-object v0, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;->f$0:Landroid/content/Context;

    iget-object v1, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;->f$1:Landroid/opengl/GLSurfaceView;

    invoke-static {v0, v1}, Lcom/google/oslo/OsloExperiments;->lambda$attach$3(Landroid/content/Context;Landroid/opengl/GLSurfaceView;)V

    return-void
.end method
