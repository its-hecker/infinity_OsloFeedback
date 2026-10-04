.class final Lcom/google/oslo/OsloTweaks$GlowObserver;
.super Landroid/database/ContentObserver;
.source "OsloTweaks.java"

# Calls OsloTweaks.notifyGlowChanged() when aware_glow_custom or
# aware_glow_hue changes.


# direct methods
.method constructor <init>(Landroid/os/Handler;)V
    .locals 0
    .param p1, "handler"    # Landroid/os/Handler;

    invoke-direct {p0, p1}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    return-void
.end method


# virtual methods
.method public onChange(Z)V
    .locals 0
    .param p1, "selfChange"    # Z

    invoke-static {}, Lcom/google/oslo/OsloTweaks;->notifyGlowChanged()V

    return-void
.end method
