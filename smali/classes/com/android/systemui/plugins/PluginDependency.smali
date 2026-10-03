.class public Lcom/android/systemui/plugins/PluginDependency;
.super Ljava/lang/Object;
.source "go/retraceme be682e25c720d24c59e6dfd4503a122f336aef7d9385d1799ce92aff5c0ddfca"


# annotations
.annotation runtime Lcom/android/systemui/plugins/annotations/ProvidesInterface;
    version = 0x1
.end annotation


# static fields
.field public static final VERSION:I = 0x1

.field public static final INSTANCE:Lcom/android/systemui/plugins/PluginDependency;

.field static sProvider:Lcom/android/systemui/plugins/PluginDependency$DependencyProvider;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/android/systemui/plugins/PluginDependency;

    invoke-direct {v0}, Lcom/android/systemui/plugins/PluginDependency;-><init>()V

    sput-object v0, Lcom/android/systemui/plugins/PluginDependency;->INSTANCE:Lcom/android/systemui/plugins/PluginDependency;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    return-void
    .line 5
.end method

.method public final get(Lcom/android/systemui/plugins/Plugin;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 1

    .line 1
    sget-object v0, Lcom/android/systemui/plugins/PluginDependency;->sProvider:Lcom/android/systemui/plugins/PluginDependency$DependencyProvider;

    .line 2
    invoke-virtual {v0, p1, p2}, Lcom/android/systemui/plugins/PluginDependency$DependencyProvider;->get(Lcom/android/systemui/plugins/Plugin;Ljava/lang/Class;)Ljava/lang/Object;

    .line 4
    move-result-object p1

    .line 7
    return-object p1
    .line 8
.end method
