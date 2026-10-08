.class public final Lcom/google/oslo/ExperimentPolicy;
.super Ljava/lang/Object;
.source "ExperimentPolicy.java"


# instance fields
.field private leaseToken:Ljava/lang/String;

.field private leaseUntil:J

.field private previewSpeed:I

.field private previewStyle:I

.field private previewToken:Ljava/lang/String;

.field private previewTrails:Z

.field private previewUntil:J


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static speed(I)I
    .registers 2

    .line 11
    const/16 v0, 0xc8

    invoke-static {v0, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    const/16 v0, 0x32

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    return p0
.end method

.method public static style(I)I
    .registers 2

    .line 10
    if-ltz p0, :cond_6

    const/4 v0, 0x4

    if-gt p0, v0, :cond_6

    goto :goto_7

    :cond_6
    const/4 p0, 0x0

    :goto_7
    return p0
.end method


# virtual methods
.method public declared-synchronized active(J)Z
    .registers 5

    monitor-enter p0

    .line 23
    :try_start_1
    iget-object v0, p0, Lcom/google/oslo/ExperimentPolicy;->leaseToken:Ljava/lang/String;

    if-eqz v0, :cond_16

    iget-wide v0, p0, Lcom/google/oslo/ExperimentPolicy;->leaseUntil:J

    cmp-long v0, p1, v0

    if-gez v0, :cond_16

    iget-wide v0, p0, Lcom/google/oslo/ExperimentPolicy;->leaseUntil:J
    :try_end_d
    .catchall {:try_start_1 .. :try_end_d} :catchall_19

    sub-long/2addr v0, p1

    const-wide/16 p1, 0x1770

    cmp-long p1, v0, p1

    if-gtz p1, :cond_16

    const/4 p1, 0x1

    goto :goto_17

    :cond_16
    const/4 p1, 0x0

    :goto_17
    monitor-exit p0

    return p1

    .line 23
    :catchall_19
    move-exception p1

    :try_start_1a
    monitor-exit p0
    :try_end_1b
    .catchall {:try_start_1a .. :try_end_1b} :catchall_19

    throw p1
.end method

.method public declared-synchronized end(Ljava/lang/String;)V
    .registers 6

    monitor-enter p0

    .line 19
    const/4 v0, 0x0

    const-wide/16 v1, 0x0

    if-eqz p1, :cond_15

    :try_start_6
    iget-object v3, p0, Lcom/google/oslo/ExperimentPolicy;->leaseToken:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_15

    iput-wide v1, p0, Lcom/google/oslo/ExperimentPolicy;->leaseUntil:J

    iput-object v0, p0, Lcom/google/oslo/ExperimentPolicy;->leaseToken:Ljava/lang/String;

    goto :goto_15

    .line 18
    :catchall_13
    move-exception p1

    goto :goto_24

    .line 20
    :cond_15
    :goto_15
    if-eqz p1, :cond_26

    iget-object v3, p0, Lcom/google/oslo/ExperimentPolicy;->previewToken:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_26

    iput-wide v1, p0, Lcom/google/oslo/ExperimentPolicy;->previewUntil:J

    iput-object v0, p0, Lcom/google/oslo/ExperimentPolicy;->previewToken:Ljava/lang/String;

    goto :goto_26

    .line 18
    :goto_24
    monitor-exit p0
    :try_end_25
    .catchall {:try_start_6 .. :try_end_25} :catchall_13

    throw p1

    .line 21
    :cond_26
    :goto_26
    monitor-exit p0

    return-void
.end method

.method public declared-synchronized lease(Ljava/lang/String;J)V
    .registers 6

    monitor-enter p0

    .line 14
    if-eqz p1, :cond_16

    :try_start_3
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_a

    goto :goto_16

    .line 15
    :cond_a
    iput-object p1, p0, Lcom/google/oslo/ExperimentPolicy;->leaseToken:Ljava/lang/String;

    .line 16
    const-wide/16 v0, 0x1770

    add-long/2addr p2, v0

    iput-wide p2, p0, Lcom/google/oslo/ExperimentPolicy;->leaseUntil:J
    :try_end_11
    .catchall {:try_start_3 .. :try_end_11} :catchall_13

    .line 17
    monitor-exit p0

    return-void

    .line 13
    :catchall_13
    move-exception p1

    :try_start_14
    monitor-exit p0
    :try_end_15
    .catchall {:try_start_14 .. :try_end_15} :catchall_13

    throw p1

    .line 14
    :cond_16
    :goto_16
    monitor-exit p0

    return-void
.end method

.method public declared-synchronized preview(Ljava/lang/String;IIJ)V
    .registers 13

    monitor-enter p0

    .line 26
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move-wide v5, p4

    :try_start_7
    invoke-virtual/range {v0 .. v6}, Lcom/google/oslo/ExperimentPolicy;->preview(Ljava/lang/String;IIZJ)V
    :try_end_a
    .catchall {:try_start_7 .. :try_end_a} :catchall_c

    .line 27
    monitor-exit p0

    return-void

    .line 25
    :catchall_c
    move-exception p1

    :try_start_d
    monitor-exit p0
    :try_end_e
    .catchall {:try_start_d .. :try_end_e} :catchall_c

    throw p1
.end method

.method public declared-synchronized preview(Ljava/lang/String;IIZJ)V
    .registers 8

    monitor-enter p0

    .line 29
    if-eqz p1, :cond_24

    :try_start_3
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_a

    goto :goto_24

    .line 30
    :cond_a
    iput-object p1, p0, Lcom/google/oslo/ExperimentPolicy;->previewToken:Ljava/lang/String;

    .line 31
    invoke-static {p2}, Lcom/google/oslo/ExperimentPolicy;->style(I)I

    move-result p1

    iput p1, p0, Lcom/google/oslo/ExperimentPolicy;->previewStyle:I

    .line 32
    invoke-static {p3}, Lcom/google/oslo/ExperimentPolicy;->speed(I)I

    move-result p1

    iput p1, p0, Lcom/google/oslo/ExperimentPolicy;->previewSpeed:I

    .line 33
    iput-boolean p4, p0, Lcom/google/oslo/ExperimentPolicy;->previewTrails:Z

    .line 34
    const-wide/16 p1, 0x1f40

    add-long/2addr p5, p1

    iput-wide p5, p0, Lcom/google/oslo/ExperimentPolicy;->previewUntil:J
    :try_end_1f
    .catchall {:try_start_3 .. :try_end_1f} :catchall_21

    .line 35
    monitor-exit p0

    return-void

    .line 28
    :catchall_21
    move-exception p1

    :try_start_22
    monitor-exit p0
    :try_end_23
    .catchall {:try_start_22 .. :try_end_23} :catchall_21

    throw p1

    .line 29
    :cond_24
    :goto_24
    monitor-exit p0

    return-void
.end method

.method public declared-synchronized previewing(J)Z
    .registers 5

    monitor-enter p0

    .line 37
    :try_start_1
    iget-object v0, p0, Lcom/google/oslo/ExperimentPolicy;->previewToken:Ljava/lang/String;

    if-eqz v0, :cond_16

    iget-wide v0, p0, Lcom/google/oslo/ExperimentPolicy;->previewUntil:J

    cmp-long v0, p1, v0

    if-gez v0, :cond_16

    iget-wide v0, p0, Lcom/google/oslo/ExperimentPolicy;->previewUntil:J
    :try_end_d
    .catchall {:try_start_1 .. :try_end_d} :catchall_19

    sub-long/2addr v0, p1

    const-wide/16 p1, 0x1f40

    cmp-long p1, v0, p1

    if-gtz p1, :cond_16

    const/4 p1, 0x1

    goto :goto_17

    :cond_16
    const/4 p1, 0x0

    :goto_17
    monitor-exit p0

    return p1

    .line 37
    :catchall_19
    move-exception p1

    :try_start_1a
    monitor-exit p0
    :try_end_1b
    .catchall {:try_start_1a .. :try_end_1b} :catchall_19

    throw p1
.end method

.method public declared-synchronized tempo(IJ)I
    .registers 4

    monitor-enter p0

    .line 43
    :try_start_1
    invoke-virtual {p0, p2, p3}, Lcom/google/oslo/ExperimentPolicy;->previewing(J)Z

    move-result p2

    if-eqz p2, :cond_a

    iget p1, p0, Lcom/google/oslo/ExperimentPolicy;->previewSpeed:I

    goto :goto_e

    :cond_a
    invoke-static {p1}, Lcom/google/oslo/ExperimentPolicy;->speed(I)I

    move-result p1
    :try_end_e
    .catchall {:try_start_1 .. :try_end_e} :catchall_10

    :goto_e
    monitor-exit p0

    return p1

    .line 43
    :catchall_10
    move-exception p1

    :try_start_11
    monitor-exit p0
    :try_end_12
    .catchall {:try_start_11 .. :try_end_12} :catchall_10

    throw p1
.end method

.method public declared-synchronized theme(IJ)I
    .registers 4

    monitor-enter p0

    .line 40
    :try_start_1
    invoke-virtual {p0, p2, p3}, Lcom/google/oslo/ExperimentPolicy;->previewing(J)Z

    move-result p2

    if-eqz p2, :cond_a

    iget p1, p0, Lcom/google/oslo/ExperimentPolicy;->previewStyle:I

    goto :goto_e

    :cond_a
    invoke-static {p1}, Lcom/google/oslo/ExperimentPolicy;->style(I)I

    move-result p1
    :try_end_e
    .catchall {:try_start_1 .. :try_end_e} :catchall_10

    :goto_e
    monitor-exit p0

    return p1

    .line 40
    :catchall_10
    move-exception p1

    :try_start_11
    monitor-exit p0
    :try_end_12
    .catchall {:try_start_11 .. :try_end_12} :catchall_10

    throw p1
.end method

.method public declared-synchronized trails(ZJ)Z
    .registers 4

    monitor-enter p0

    .line 46
    :try_start_1
    invoke-virtual {p0, p2, p3}, Lcom/google/oslo/ExperimentPolicy;->previewing(J)Z

    move-result p2

    if-eqz p2, :cond_9

    iget-boolean p1, p0, Lcom/google/oslo/ExperimentPolicy;->previewTrails:Z
    :try_end_9
    .catchall {:try_start_1 .. :try_end_9} :catchall_b

    :cond_9
    monitor-exit p0

    return p1

    .line 46
    :catchall_b
    move-exception p1

    :try_start_c
    monitor-exit p0
    :try_end_d
    .catchall {:try_start_c .. :try_end_d} :catchall_b

    throw p1
.end method
