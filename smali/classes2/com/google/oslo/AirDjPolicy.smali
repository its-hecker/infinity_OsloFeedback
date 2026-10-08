.class public final Lcom/google/oslo/AirDjPolicy;
.super Ljava/lang/Object;
.source "AirDjPolicy.java"


# static fields
.field public static final SEEK:I = 0x2

.field public static final TRACK:I = 0x0

.field public static final VOLUME:I = 0x1


# instance fields
.field private lastGesture:J


# direct methods
.method public constructor <init>()V
    .registers 3

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/google/oslo/AirDjPolicy;->lastGesture:J

    return-void
.end method

.method public static glowHue(I)F
    .registers 1

    .line 19
    invoke-static {p0}, Lcom/google/oslo/AirDjPolicy;->normalizeMode(I)I

    move-result p0

    packed-switch p0, :pswitch_data_10

    .line 22
    const/high16 p0, 0x43570000    # 215.0f

    return p0

    .line 21
    :pswitch_a
    const/high16 p0, 0x41f00000    # 30.0f

    return p0

    .line 20
    :pswitch_d
    const/high16 p0, 0x430c0000    # 140.0f

    return p0

    :pswitch_data_10
    .packed-switch 0x1
        :pswitch_d
        :pswitch_a
    .end packed-switch
.end method

.method public static nextMode(I)I
    .registers 1

    .line 15
    invoke-static {p0}, Lcom/google/oslo/AirDjPolicy;->normalizeMode(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x1

    rem-int/lit8 p0, p0, 0x3

    return p0
.end method

.method public static normalizeMode(I)I
    .registers 2

    .line 11
    if-ltz p0, :cond_6

    const/4 v0, 0x2

    if-gt p0, v0, :cond_6

    goto :goto_7

    :cond_6
    const/4 p0, 0x0

    :goto_7
    return p0
.end method

.method public static seekPosition(JJJFJZ)J
    .registers 13

    .line 41
    const-wide/16 v0, 0x0

    cmp-long v2, p0, v0

    if-gez v2, :cond_9

    const-wide/16 p0, -0x1

    return-wide p0

    .line 42
    :cond_9
    long-to-double p0, p0

    .line 43
    cmp-long v2, p2, v0

    if-lez v2, :cond_1d

    cmp-long v2, p4, p2

    if-lez v2, :cond_1d

    invoke-static {p6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_1d

    .line 44
    sub-long/2addr p4, p2

    long-to-double p2, p4

    float-to-double p4, p6

    mul-double/2addr p2, p4

    add-double/2addr p0, p2

    .line 46
    :cond_1d
    if-eqz p9, :cond_25

    const-wide p2, 0x40c3880000000000L    # 10000.0

    goto :goto_2a

    :cond_25
    const-wide p2, -0x3f3c780000000000L    # -10000.0

    :goto_2a
    add-double/2addr p0, p2

    const-wide/16 p2, 0x0

    invoke-static {p2, p3, p0, p1}, Ljava/lang/Math;->max(DD)D

    move-result-wide p0

    .line 47
    cmp-long p2, p7, v0

    if-lez p2, :cond_3a

    long-to-double p2, p7

    invoke-static {p0, p1, p2, p3}, Ljava/lang/Math;->min(DD)D

    move-result-wide p0

    .line 48
    :cond_3a
    const-wide/high16 p2, 0x43e0000000000000L    # 9.223372036854776E18

    invoke-static {p0, p1, p2, p3}, Ljava/lang/Math;->min(DD)D

    move-result-wide p0

    double-to-long p0, p0

    return-wide p0
.end method


# virtual methods
.method public declared-synchronized acceptGesture(JJ)Z
    .registers 9

    monitor-enter p0

    .line 27
    :try_start_1
    iget-wide v0, p0, Lcom/google/oslo/AirDjPolicy;->lastGesture:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_1a

    iget-wide v0, p0, Lcom/google/oslo/AirDjPolicy;->lastGesture:J

    cmp-long v0, p1, v0

    if-ltz v0, :cond_1a

    iget-wide v0, p0, Lcom/google/oslo/AirDjPolicy;->lastGesture:J
    :try_end_11
    .catchall {:try_start_1 .. :try_end_11} :catchall_1f

    sub-long v0, p1, v0

    cmp-long p3, v0, p3

    if-gez p3, :cond_1a

    .line 28
    monitor-exit p0

    const/4 p1, 0x0

    return p1

    .line 30
    :cond_1a
    :try_start_1a
    iput-wide p1, p0, Lcom/google/oslo/AirDjPolicy;->lastGesture:J
    :try_end_1c
    .catchall {:try_start_1a .. :try_end_1c} :catchall_1f

    .line 31
    monitor-exit p0

    const/4 p1, 0x1

    return p1

    .line 26
    :catchall_1f
    move-exception p1

    :try_start_20
    monitor-exit p0
    :try_end_21
    .catchall {:try_start_20 .. :try_end_21} :catchall_1f

    throw p1
.end method

.method public declared-synchronized reset()V
    .registers 3

    monitor-enter p0

    .line 35
    const-wide/16 v0, -0x1

    :try_start_3
    iput-wide v0, p0, Lcom/google/oslo/AirDjPolicy;->lastGesture:J
    :try_end_5
    .catchall {:try_start_3 .. :try_end_5} :catchall_7

    .line 36
    monitor-exit p0

    return-void

    .line 34
    :catchall_7
    move-exception v0

    :try_start_8
    monitor-exit p0
    :try_end_9
    .catchall {:try_start_8 .. :try_end_9} :catchall_7

    throw v0
.end method
