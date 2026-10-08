.class Lcom/google/oslo/OsloExperiments$1;
.super Landroid/content/BroadcastReceiver;
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
.method constructor <init>()V
    .registers 1

    .line 46
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 11

    .line 48
    const-string p1, "command"

    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 49
    const-string v0, "token"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 50
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    .line 51
    const-string v0, "lease"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1e

    sget-object p1, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    invoke-virtual {p1, v2, v6, v7}, Lcom/google/oslo/ExperimentPolicy;->lease(Ljava/lang/String;J)V

    goto :goto_56

    .line 52
    :cond_1e
    const-string v0, "end"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2f

    sget-object p1, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    invoke-virtual {p1, v2}, Lcom/google/oslo/ExperimentPolicy;->end(Ljava/lang/String;)V

    # invokes: Lcom/google/oslo/OsloExperiments;->startFrames()V
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$000()V

    goto :goto_56

    .line 53
    :cond_2f
    const-string v0, "preview"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_56

    .line 54
    sget-object v1, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    const-string p1, "style"

    const/4 v0, 0x0

    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    .line 55
    const-string p1, "speed"

    const/16 v0, 0x64

    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v4

    sget-boolean p1, Lcom/google/oslo/OsloExperiments;->trails:Z

    .line 56
    const-string v0, "trails"

    invoke-virtual {p2, v0, p1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v5

    .line 54
    invoke-virtual/range {v1 .. v7}, Lcom/google/oslo/ExperimentPolicy;->preview(Ljava/lang/String;IIZJ)V

    .line 57
    # invokes: Lcom/google/oslo/OsloExperiments;->startFrames()V
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->access$000()V

    .line 59
    :cond_56
    :goto_56
    return-void
.end method
