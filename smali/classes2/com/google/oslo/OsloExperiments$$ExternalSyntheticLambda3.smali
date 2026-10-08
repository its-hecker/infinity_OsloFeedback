.class public final synthetic Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# instance fields
.field public final synthetic f$0:Landroid/opengl/GLSurfaceView;


# direct methods
.method public synthetic constructor <init>(Landroid/opengl/GLSurfaceView;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda3;->f$0:Landroid/opengl/GLSurfaceView;

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .registers 3

    .line 0
    iget-object v0, p0, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda3;->f$0:Landroid/opengl/GLSurfaceView;

    check-cast p1, Ljava/lang/ref/WeakReference;

    invoke-static {v0, p1}, Lcom/google/oslo/OsloExperiments;->lambda$detach$4(Landroid/opengl/GLSurfaceView;Ljava/lang/ref/WeakReference;)Z

    move-result p1

    return p1
.end method
