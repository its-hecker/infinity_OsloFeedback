.class public final Lcom/google/oslo/OsloExperiments;
.super Ljava/lang/Object;
.source "OsloExperiments.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/oslo/OsloExperiments$Surface;
    }
.end annotation


# static fields
.field private static final ACTION:Ljava/lang/String; = "com.google.oslo.EXPERIMENT_COMMAND"

.field private static final FRAME:Ljava/lang/Runnable;

.field private static final MAIN:Landroid/os/Handler;

.field static final POLICY:Lcom/google/oslo/ExperimentPolicy;

.field private static final VIEWS:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/ref/WeakReference<",
            "Landroid/opengl/GLSurfaceView;",
            ">;>;"
        }
    .end annotation
.end field

.field static volatile airDj:Z

.field static volatile airMode:I

.field static volatile brightness:I

.field private static context:Landroid/content/Context;

.field static volatile direction:I

.field static volatile enabled:Z

.field static volatile gestureAt:J

.field private static observer:Landroid/database/ContentObserver;

.field private static pumping:Z

.field private static receiver:Landroid/content/BroadcastReceiver;

.field static volatile savedSpeed:I

.field static volatile savedStyle:I

.field private static service:Z

.field static volatile shown:Z

.field static volatile trails:Z


# direct methods
.method public static synthetic $r8$lambda$ALg0_CNZiVKSi7pnU88XDskOKOU()V
    .registers 0

    invoke-static {}, Lcom/google/oslo/OsloExperiments;->startFrames()V

    return-void
.end method

.method static constructor <clinit>()V
    .registers 2

    .line 21
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    .line 22
    new-instance v0, Lcom/google/oslo/ExperimentPolicy;

    invoke-direct {v0}, Lcom/google/oslo/ExperimentPolicy;-><init>()V

    sput-object v0, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    .line 23
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    .line 28
    const/16 v0, 0x64

    sput v0, Lcom/google/oslo/OsloExperiments;->savedSpeed:I

    sput v0, Lcom/google/oslo/OsloExperiments;->brightness:I

    .line 29
    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/oslo/OsloExperiments;->shown:Z

    .line 150
    new-instance v0, Lcom/google/oslo/OsloExperiments$3;

    invoke-direct {v0}, Lcom/google/oslo/OsloExperiments$3;-><init>()V

    sput-object v0, Lcom/google/oslo/OsloExperiments;->FRAME:Ljava/lang/Runnable;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()V
    .registers 0

    .line 18
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->startFrames()V

    return-void
.end method

.method static synthetic access$100()V
    .registers 0

    .line 18
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->readSettings()V

    return-void
.end method

.method static synthetic access$200()Ljava/util/ArrayList;
    .registers 1

    .line 18
    sget-object v0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$300()Landroid/os/Handler;
    .registers 1

    .line 18
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$402(Z)Z
    .registers 1

    .line 18
    sput-boolean p0, Lcom/google/oslo/OsloExperiments;->pumping:Z

    return p0
.end method

.method public static attach(Landroid/opengl/GLSurfaceView;Landroid/content/Context;)V
    .registers 4

    .line 105
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1, p0}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda4;-><init>(Landroid/content/Context;Landroid/opengl/GLSurfaceView;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 111
    return-void
.end method

.method private static close()V
    .registers 2

    .line 119
    sget-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    if-eqz v0, :cond_12

    sget-object v0, Lcom/google/oslo/OsloExperiments;->receiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_12

    :try_start_8
    sget-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    sget-object v1, Lcom/google/oslo/OsloExperiments;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_f
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_f} :catch_10

    goto :goto_11

    .line 120
    :catch_10
    move-exception v0

    :goto_11
    nop

    .line 121
    :cond_12
    sget-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    if-eqz v0, :cond_28

    sget-object v0, Lcom/google/oslo/OsloExperiments;->observer:Landroid/database/ContentObserver;

    if-eqz v0, :cond_28

    .line 122
    :try_start_1a
    sget-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Lcom/google/oslo/OsloExperiments;->observer:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V
    :try_end_25
    .catch Ljava/lang/RuntimeException; {:try_start_1a .. :try_end_25} :catch_26

    goto :goto_27

    .line 123
    :catch_26
    move-exception v0

    :goto_27
    nop

    .line 124
    :cond_28
    const/4 v0, 0x0

    sput-object v0, Lcom/google/oslo/OsloExperiments;->receiver:Landroid/content/BroadcastReceiver;

    sput-object v0, Lcom/google/oslo/OsloExperiments;->observer:Landroid/database/ContentObserver;

    sput-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    .line 125
    const/4 v0, 0x0

    sput-boolean v0, Lcom/google/oslo/OsloExperiments;->enabled:Z

    .line 126
    return-void
.end method

.method public static detach(Landroid/opengl/GLSurfaceView;)V
    .registers 3

    .line 113
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda6;-><init>(Landroid/opengl/GLSurfaceView;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 117
    return-void
.end method

.method public static gesture(IZ)V
    .registers 4

    .line 140
    if-nez p1, :cond_3

    return-void

    .line 141
    :cond_3
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sput-wide v0, Lcom/google/oslo/OsloExperiments;->gestureAt:J

    .line 142
    sput p0, Lcom/google/oslo/OsloExperiments;->direction:I

    .line 143
    sget-object p0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    new-instance p1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda1;

    invoke-direct {p1}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda1;-><init>()V

    invoke-virtual {p0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 144
    return-void
.end method

.method public static initialize(Landroid/content/Context;)V
    .registers 3

    .line 37
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda0;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 38
    return-void
.end method

.method private static initializeMain(Landroid/content/Context;)V
    .registers 10

    .line 40
    sget-object v0, Lcom/google/oslo/OsloExperiments;->receiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_5

    return-void

    .line 41
    :cond_5
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    sput-object p0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    .line 43
    :try_start_b
    new-instance p0, Lcom/google/oslo/OsloExperiments$1;

    invoke-direct {p0}, Lcom/google/oslo/OsloExperiments$1;-><init>()V

    sput-object p0, Lcom/google/oslo/OsloExperiments;->receiver:Landroid/content/BroadcastReceiver;

    .line 58
    sget-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    sget-object v1, Lcom/google/oslo/OsloExperiments;->receiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string p0, "com.google.oslo.EXPERIMENT_COMMAND"

    invoke-direct {v2, p0}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    const-string v3, "android.permission.WRITE_SECURE_SETTINGS"

    sget-object v4, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    const/4 v5, 0x2

    invoke-virtual/range {v0 .. v5}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;I)Landroid/content/Intent;

    .line 60
    new-instance p0, Lcom/google/oslo/OsloExperiments$2;

    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    invoke-direct {p0, v0}, Lcom/google/oslo/OsloExperiments$2;-><init>(Landroid/os/Handler;)V

    sput-object p0, Lcom/google/oslo/OsloExperiments;->observer:Landroid/database/ContentObserver;

    .line 63
    const-string v1, "aware_glow_style"

    const-string v2, "aware_glow_speed"

    const-string v3, "aware_gesture_trails"

    const-string v4, "aware_enabled"

    const-string v5, "aware_glow_show"

    const-string v6, "aware_glow_brightness"

    const-string v7, "aware_air_dj"

    const-string v8, "aware_air_dj_mode"

    filled-new-array/range {v1 .. v8}, [Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x0

    move v1, v0

    :goto_44
    const/16 v2, 0x8

    if-ge v1, v2, :cond_5c

    aget-object v2, p0, v1

    .line 66
    sget-object v3, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    .line 67
    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    sget-object v4, Lcom/google/oslo/OsloExperiments;->observer:Landroid/database/ContentObserver;

    .line 66
    invoke-virtual {v3, v2, v0, v4}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 63
    add-int/lit8 v1, v1, 0x1

    goto :goto_44

    .line 69
    :cond_5c
    const-string p0, "aware_allowed"

    const-string v1, "airplane_mode_on"

    const-string v2, "low_power"

    filled-new-array {p0, v1, v2}, [Ljava/lang/String;

    move-result-object p0

    move v1, v0

    :goto_67
    const/4 v2, 0x3

    if-ge v1, v2, :cond_7e

    aget-object v2, p0, v1

    .line 70
    sget-object v3, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    .line 71
    invoke-static {v2}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    sget-object v4, Lcom/google/oslo/OsloExperiments;->observer:Landroid/database/ContentObserver;

    .line 70
    invoke-virtual {v3, v2, v0, v4}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 69
    add-int/lit8 v1, v1, 0x1

    goto :goto_67

    .line 73
    :cond_7e
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->readSettings()V
    :try_end_81
    .catch Ljava/lang/RuntimeException; {:try_start_b .. :try_end_81} :catch_82

    .line 77
    goto :goto_8d

    .line 74
    :catch_82
    move-exception p0

    .line 75
    const-string v0, "Oslo.Experiments"

    const-string v1, "Experiment bridge unavailable"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 76
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->close()V

    .line 78
    :goto_8d
    return-void
.end method

.method public static isLabActive()Z
    .registers 3

    .line 129
    sget-object v0, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/google/oslo/ExperimentPolicy;->active(J)Z

    move-result v0

    return v0
.end method

.method static synthetic lambda$attach$3(Landroid/content/Context;Landroid/opengl/GLSurfaceView;)V
    .registers 3

    .line 106
    invoke-static {p0}, Lcom/google/oslo/OsloExperiments;->initializeMain(Landroid/content/Context;)V

    .line 107
    sget-object p0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_9
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1c

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :cond_9

    return-void

    .line 108
    :cond_1c
    sget-object p0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 109
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->startFrames()V

    .line 110
    return-void
.end method

.method static synthetic lambda$detach$4(Landroid/opengl/GLSurfaceView;Ljava/lang/ref/WeakReference;)Z
    .registers 3

    .line 114
    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_f

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    if-ne p1, p0, :cond_d

    goto :goto_f

    :cond_d
    const/4 p0, 0x0

    goto :goto_10

    :cond_f
    :goto_f
    const/4 p0, 0x1

    :goto_10
    return p0
.end method

.method static synthetic lambda$detach$5(Landroid/opengl/GLSurfaceView;)V
    .registers 3

    .line 114
    sget-object v0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    new-instance v1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda3;-><init>(Landroid/opengl/GLSurfaceView;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->removeIf(Ljava/util/function/Predicate;)Z

    .line 115
    sget-boolean p0, Lcom/google/oslo/OsloExperiments;->service:Z

    if-nez p0, :cond_19

    sget-object p0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    invoke-virtual {p0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_19

    invoke-static {}, Lcom/google/oslo/OsloExperiments;->close()V

    .line 116
    :cond_19
    return-void
.end method

.method static synthetic lambda$initialize$0(Landroid/content/Context;)V
    .registers 1

    .line 37
    invoke-static {p0}, Lcom/google/oslo/OsloExperiments;->initializeMain(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic lambda$serviceStarted$1(Landroid/content/Context;)V
    .registers 2

    .line 99
    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/oslo/OsloExperiments;->service:Z

    invoke-static {p0}, Lcom/google/oslo/OsloExperiments;->initializeMain(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic lambda$serviceStopped$2()V
    .registers 1

    .line 102
    const/4 v0, 0x0

    sput-boolean v0, Lcom/google/oslo/OsloExperiments;->service:Z

    sget-object v0, Lcom/google/oslo/OsloExperiments;->VIEWS:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_e

    invoke-static {}, Lcom/google/oslo/OsloExperiments;->close()V

    :cond_e
    return-void
.end method

.method private static readSettings()V
    .registers 5

    .line 84
    const/4 v0, 0x0

    :try_start_1
    const-string v1, "aware_glow_style"

    invoke-static {v1, v0}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v1}, Lcom/google/oslo/ExperimentPolicy;->style(I)I

    move-result v1

    sput v1, Lcom/google/oslo/OsloExperiments;->savedStyle:I

    .line 85
    const-string v1, "aware_glow_speed"

    const/16 v2, 0x64

    invoke-static {v1, v2}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v1}, Lcom/google/oslo/ExperimentPolicy;->speed(I)I

    move-result v1

    sput v1, Lcom/google/oslo/OsloExperiments;->savedSpeed:I

    .line 86
    const-string v1, "aware_gesture_trails"

    invoke-static {v1, v0}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_26

    move v1, v3

    goto :goto_27

    :cond_26
    move v1, v0

    :goto_27
    sput-boolean v1, Lcom/google/oslo/OsloExperiments;->trails:Z

    .line 87
    const-string v1, "aware_enabled"

    invoke-static {v1, v0}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    if-ne v1, v3, :cond_5d

    sget-object v1, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    .line 88
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v4, "aware_allowed"

    invoke-static {v1, v4, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    if-ne v1, v3, :cond_5d

    sget-object v1, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    .line 89
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v4, "airplane_mode_on"

    invoke-static {v1, v4, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    if-nez v1, :cond_5d

    sget-object v1, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    .line 90
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v4, "low_power"

    invoke-static {v1, v4, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    if-nez v1, :cond_5d

    move v1, v3

    goto :goto_5e

    :cond_5d
    move v1, v0

    :goto_5e
    sput-boolean v1, Lcom/google/oslo/OsloExperiments;->enabled:Z

    .line 91
    const-string v1, "aware_glow_show"

    invoke-static {v1, v3}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    if-ne v1, v3, :cond_6a

    move v1, v3

    goto :goto_6b

    :cond_6a
    move v1, v0

    :goto_6b
    sput-boolean v1, Lcom/google/oslo/OsloExperiments;->shown:Z

    .line 92
    const-string v1, "aware_glow_brightness"

    invoke-static {v1, v2}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    const/16 v2, 0xa

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    sput v1, Lcom/google/oslo/OsloExperiments;->brightness:I

    .line 93
    const-string v1, "aware_air_dj"

    invoke-static {v1, v0}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    if-ne v1, v3, :cond_88

    goto :goto_89

    :cond_88
    move v3, v0

    :goto_89
    sput-boolean v3, Lcom/google/oslo/OsloExperiments;->airDj:Z

    .line 94
    const-string v1, "aware_air_dj_mode"

    invoke-static {v1, v0}, Lcom/google/oslo/OsloExperiments;->setting(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v1}, Lcom/google/oslo/AirDjPolicy;->normalizeMode(I)I

    move-result v1

    sput v1, Lcom/google/oslo/OsloExperiments;->airMode:I
    :try_end_97
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_97} :catch_98

    .line 95
    goto :goto_9b

    :catch_98
    move-exception v1

    sput-boolean v0, Lcom/google/oslo/OsloExperiments;->enabled:Z

    .line 96
    :goto_9b
    invoke-static {}, Lcom/google/oslo/OsloExperiments;->startFrames()V

    .line 97
    return-void
.end method

.method public static serviceStarted(Landroid/content/Context;)V
    .registers 3

    .line 99
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda5;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 100
    return-void
.end method

.method public static serviceStopped()V
    .registers 2

    .line 102
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    new-instance v1, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda2;

    invoke-direct {v1}, Lcom/google/oslo/OsloExperiments$$ExternalSyntheticLambda2;-><init>()V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 103
    return-void
.end method

.method private static setting(Ljava/lang/String;I)I
    .registers 3

    .line 80
    sget-object v0, Lcom/google/oslo/OsloExperiments;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {v0, p0, p1}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0

    return p0
.end method

.method private static startFrames()V
    .registers 2

    .line 146
    sget-boolean v0, Lcom/google/oslo/OsloExperiments;->pumping:Z

    if-eqz v0, :cond_5

    return-void

    .line 147
    :cond_5
    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/oslo/OsloExperiments;->pumping:Z

    .line 148
    sget-object v0, Lcom/google/oslo/OsloExperiments;->MAIN:Landroid/os/Handler;

    sget-object v1, Lcom/google/oslo/OsloExperiments;->FRAME:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 149
    return-void
.end method

.method public static visibility(I)I
    .registers 7

    .line 133
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 134
    sget-wide v2, Lcom/google/oslo/OsloExperiments;->gestureAt:J

    sub-long v2, v0, v2

    .line 135
    sget-object v4, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    invoke-virtual {v4, v0, v1}, Lcom/google/oslo/ExperimentPolicy;->previewing(J)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_2c

    sget-boolean v0, Lcom/google/oslo/OsloExperiments;->shown:Z

    if-eqz v0, :cond_2a

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-ltz v0, :cond_2a

    const-wide/16 v4, 0x4b0

    cmp-long v0, v2, v4

    if-gez v0, :cond_2a

    sget v0, Lcom/google/oslo/OsloExperiments;->savedStyle:I

    if-nez v0, :cond_2c

    sget-boolean v0, Lcom/google/oslo/OsloExperiments;->trails:Z

    if-eqz v0, :cond_2a

    goto :goto_2c

    :cond_2a
    move v0, v1

    goto :goto_2d

    :cond_2c
    :goto_2c
    const/4 v0, 0x1

    .line 137
    :goto_2d
    sget-boolean v2, Lcom/google/oslo/OsloExperiments;->enabled:Z

    if-eqz v2, :cond_34

    if-eqz v0, :cond_34

    move p0, v1

    :cond_34
    return p0
.end method
