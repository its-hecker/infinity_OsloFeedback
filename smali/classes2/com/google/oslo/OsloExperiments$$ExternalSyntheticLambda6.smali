.class public final synthetic Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda6;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/opengl/GLSurfaceView;


# direct methods
.method public synthetic constructor <init>(Landroid/opengl/GLSurfaceView;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda6;->f$0:Landroid/opengl/GLSurfaceView;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 2

    .line 0
    iget-object v0, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda6;->f$0:Landroid/opengl/GLSurfaceView;

    invoke-static {v0}, Lcom/google/oslo/OsloExperiments;->lambda$detach$5(Landroid/opengl/GLSurfaceView;)V

    return-void
.end method
