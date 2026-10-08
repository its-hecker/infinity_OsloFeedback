.class Lcom/google/oslo/OsloExperiments$2;
.super Landroid/database/ContentObserver;
.source "OsloExperiments.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/oslo/OsloExperiments;->initializeMain(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>(Landroid/os/Handler;)V
    .registers 2

    .line 63
    invoke-direct {p0, p1}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    return-void
.end method


# virtual methods
.method public onChange(Z)V
    .registers 2

    .line 64
    # invokes: Lcom/google/oslo/OsloExperiments;->readSettings()V
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$100()V

    return-void
.end method
