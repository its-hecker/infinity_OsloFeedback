.class public final Lcom/google/oslo/MotionFeedback$Snapshot;
.super Ljava/lang/Object;
.source "MotionFeedback.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/oslo/MotionFeedback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Snapshot"
.end annotation


# instance fields
.field direction:I

.field identity:Ljava/lang/String;

.field user:I

.field volume:I


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    const/4 v0, -0x1

    iput v0, p0, Lcom/google/oslo/MotionFeedback$Snapshot;->volume:I

    .line 23
    iput v0, p0, Lcom/google/oslo/MotionFeedback$Snapshot;->user:I

    return-void
.end method
