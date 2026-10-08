.class public final synthetic Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/google/oslo/AlbumArtController;

.field public final synthetic f$1:Landroid/graphics/Bitmap;

.field public final synthetic f$2:J


# direct methods
.method public synthetic constructor <init>(Lcom/google/oslo/AlbumArtController;Landroid/graphics/Bitmap;J)V
    .registers 5

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;->f$0:Lcom/google/oslo/AlbumArtController;

    iput-object p2, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;->f$1:Landroid/graphics/Bitmap;

    iput-wide p3, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;->f$2:J

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 5

    .line 0
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;->f$0:Lcom/google/oslo/AlbumArtController;

    iget-object v1, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;->f$1:Landroid/graphics/Bitmap;

    iget-wide v2, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda1;->f$2:J

    invoke-virtual {v0, v1, v2, v3}, Lcom/google/oslo/AlbumArtController;->lambda$schedule$1$com-google-oslo-AlbumArtController(Landroid/graphics/Bitmap;J)V

    return-void
.end method
