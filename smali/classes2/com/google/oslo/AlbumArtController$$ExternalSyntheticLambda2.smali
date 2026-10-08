.class public final synthetic Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/google/oslo/AlbumArtController;

.field public final synthetic f$1:J

.field public final synthetic f$2:Landroid/graphics/Bitmap;


# direct methods
.method public synthetic constructor <init>(Lcom/google/oslo/AlbumArtController;JLandroid/graphics/Bitmap;)V
    .registers 5

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;->f$0:Lcom/google/oslo/AlbumArtController;

    iput-wide p2, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;->f$1:J

    iput-object p4, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;->f$2:Landroid/graphics/Bitmap;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 5

    .line 0
    iget-object v0, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;->f$0:Lcom/google/oslo/AlbumArtController;

    iget-wide v1, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;->f$1:J

    iget-object v3, p0, Lcom/google/oslo/AlbumArtController$$ExternalSyntheticLambda2;->f$2:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1, v2, v3}, Lcom/google/oslo/AlbumArtController;->lambda$schedule$2$com-google-oslo-AlbumArtController(JLandroid/graphics/Bitmap;)V

    return-void
.end method
