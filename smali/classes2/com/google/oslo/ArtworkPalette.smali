.class public final Lcom/google/oslo/ArtworkPalette;
.super Ljava/lang/Object;
.source "ArtworkPalette.java"


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static extract([I)I
    .registers 16

    .line 7
    const/4 v0, 0x0

    if-eqz p0, :cond_a1

    array-length v1, p0

    if-nez v1, :cond_8

    goto/16 :goto_a1

    .line 8
    :cond_8
    const/16 v1, 0x1000

    new-array v2, v1, [I

    new-array v3, v1, [I

    new-array v4, v1, [I

    new-array v1, v1, [I

    .line 9
    nop

    .line 10
    array-length v5, p0

    const/4 v6, -0x1

    move v7, v0

    :goto_16
    if-ge v7, v5, :cond_74

    aget v8, p0, v7

    .line 11
    ushr-int/lit8 v9, v8, 0x18

    const/16 v10, 0x80

    if-ge v9, v10, :cond_21

    goto :goto_71

    .line 12
    :cond_21
    ushr-int/lit8 v9, v8, 0x10

    and-int/lit16 v9, v9, 0xff

    ushr-int/lit8 v10, v8, 0x8

    and-int/lit16 v10, v10, 0xff

    and-int/lit16 v8, v8, 0xff

    .line 13
    invoke-static {v10, v8}, Ljava/lang/Math;->max(II)I

    move-result v11

    invoke-static {v9, v11}, Ljava/lang/Math;->max(II)I

    move-result v11

    invoke-static {v10, v8}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-static {v9, v12}, Ljava/lang/Math;->min(II)I

    move-result v12

    .line 14
    const/16 v13, 0x1c

    if-ge v11, v13, :cond_40

    goto :goto_71

    .line 15
    :cond_40
    shr-int/lit8 v13, v9, 0x4

    shl-int/lit8 v13, v13, 0x8

    shr-int/lit8 v14, v10, 0x4

    shl-int/lit8 v14, v14, 0x4

    or-int/2addr v13, v14

    shr-int/lit8 v14, v8, 0x4

    or-int/2addr v13, v14

    .line 16
    sub-int/2addr v11, v12

    div-int/lit8 v11, v11, 0x18

    add-int/lit8 v11, v11, 0x1

    .line 17
    aget v12, v2, v13

    add-int/2addr v12, v11

    aput v12, v2, v13

    aget v12, v3, v13

    mul-int/2addr v9, v11

    add-int/2addr v12, v9

    aput v12, v3, v13

    aget v9, v4, v13

    mul-int/2addr v10, v11

    add-int/2addr v9, v10

    aput v9, v4, v13

    aget v9, v1, v13

    mul-int/2addr v8, v11

    add-int/2addr v9, v8

    aput v9, v1, v13

    .line 18
    if-ltz v6, :cond_70

    aget v8, v2, v13

    aget v9, v2, v6

    if-le v8, v9, :cond_71

    :cond_70
    move v6, v13

    .line 10
    :cond_71
    :goto_71
    add-int/lit8 v7, v7, 0x1

    goto :goto_16

    .line 20
    :cond_74
    if-gez v6, :cond_77

    return v0

    .line 21
    :cond_77
    aget p0, v3, v6

    aget v0, v2, v6

    div-int/2addr p0, v0

    aget v0, v4, v6

    aget v3, v2, v6

    div-int/2addr v0, v3

    aget v1, v1, v6

    aget v2, v2, v6

    div-int/2addr v1, v2

    .line 22
    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-static {p0, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 23
    mul-int/lit16 p0, p0, 0xff

    div-int/2addr p0, v2

    shl-int/lit8 p0, p0, 0x10

    const/high16 v3, -0x1000000

    or-int/2addr p0, v3

    mul-int/lit16 v0, v0, 0xff

    div-int/2addr v0, v2

    shl-int/lit8 v0, v0, 0x8

    or-int/2addr p0, v0

    mul-int/lit16 v1, v1, 0xff

    div-int/2addr v1, v2

    or-int/2addr p0, v1

    return p0

    .line 7
    :cond_a1
    :goto_a1
    return v0
.end method

.method public static tint(II)I
    .registers 5

    .line 26
    if-nez p1, :cond_3

    return p0

    .line 27
    :cond_3
    ushr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    ushr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 v2, p0, 0xff

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 28
    const/high16 v1, -0x1000000

    and-int/2addr p0, v1

    ushr-int/lit8 v1, p1, 0x10

    and-int/lit16 v1, v1, 0xff

    mul-int/2addr v1, v0

    div-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    or-int/2addr p0, v1

    ushr-int/lit8 v1, p1, 0x8

    and-int/lit16 v1, v1, 0xff

    mul-int/2addr v1, v0

    div-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr p0, v1

    and-int/lit16 p1, p1, 0xff

    mul-int/2addr p1, v0

    div-int/lit16 p1, p1, 0xff

    or-int/2addr p0, p1

    return p0
.end method
