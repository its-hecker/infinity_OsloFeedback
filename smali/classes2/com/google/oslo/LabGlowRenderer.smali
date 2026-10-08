.class public final Lcom/google/oslo/LabGlowRenderer;
.super Ljava/lang/Object;
.source "LabGlowRenderer.java"


# static fields
.field private static final FRAGMENT:Ljava/lang/String; = "precision mediump float;varying vec2 uv;uniform float age,style,tempo,alpha,trail,side,strip,aspect;uniform vec3 color;void main(){float y=(1.0-uv.y)*aspect;float line=exp(-pow((y-0.015)/0.009,2.0));float edge=smoothstep(0.05,0.2,uv.x)*(1.0-smoothstep(0.8,0.95,uv.x));vec3 c=color;float a=line*edge*strip;if(style>0.5&&style<1.5){a*=1.0+0.25*sin(age*8.0*tempo);c=mix(c,vec3(1.0,0.1,0.7),0.35);}if(style>1.5&&style<2.5){c=mix(vec3(0.1,0.9,0.6),vec3(0.65,0.2,1.0),0.5+0.5*sin(uv.x*7.0+age*tempo*3.0));}if(style>2.5&&style<3.5){a*=step(0.35,fract(uv.x*22.0-age*tempo));}if(style>3.5){a*=0.45;}float t=clamp(age*tempo,0.0,1.0);float head=mix(0.15,0.85,t);if(side<0.0)head=1.0-head;float tail=exp(-pow((uv.x-head)/0.13,2.0))*line;a=max(a,tail*trail*(1.0-t));gl_FragColor=vec4(c,clamp(a*alpha,0.0,1.0));}"

.field private static final VERTEX:Ljava/lang/String; = "attribute vec2 p;varying vec2 uv;void main(){uv=(p+1.0)*0.5;gl_Position=vec4(p,0.0,1.0);}"


# instance fields
.field private height:I

.field private program:I

.field private final quad:Ljava/nio/FloatBuffer;

.field private width:I


# direct methods
.method public constructor <init>()V
    .registers 3

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    const/4 v0, 0x1

    iput v0, p0, Lcom/google/oslo/LabGlowRenderer;->width:I

    iput v0, p0, Lcom/google/oslo/LabGlowRenderer;->height:I

    .line 12
    const/16 v0, 0x20

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 13
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/google/oslo/LabGlowRenderer;->quad:Ljava/nio/FloatBuffer;

    .line 32
    iget-object v0, p0, Lcom/google/oslo/LabGlowRenderer;->quad:Ljava/nio/FloatBuffer;

    const/16 v1, 0x8

    new-array v1, v1, [F

    fill-array-data v1, :array_2e

    invoke-virtual {v0, v1}, Ljava/nio/FloatBuffer;->put([F)Ljava/nio/FloatBuffer;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/FloatBuffer;

    return-void

    :array_2e
    .array-data 4
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x3f800000    # 1.0f
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private initialize()Z
    .registers 6

    .line 44
    const v0, 0x8b31

    const-string v1, "attribute vec2 p;varying vec2 uv;void main(){uv=(p+1.0)*0.5;gl_Position=vec4(p,0.0,1.0);}"

    invoke-static {v0, v1}, Lcom/google/oslo/LabGlowRenderer;->shader(ILjava/lang/String;)I

    move-result v0

    .line 45
    const v1, 0x8b30

    const-string v2, "precision mediump float;varying vec2 uv;uniform float age,style,tempo,alpha,trail,side,strip,aspect;uniform vec3 color;void main(){float y=(1.0-uv.y)*aspect;float line=exp(-pow((y-0.015)/0.009,2.0));float edge=smoothstep(0.05,0.2,uv.x)*(1.0-smoothstep(0.8,0.95,uv.x));vec3 c=color;float a=line*edge*strip;if(style>0.5&&style<1.5){a*=1.0+0.25*sin(age*8.0*tempo);c=mix(c,vec3(1.0,0.1,0.7),0.35);}if(style>1.5&&style<2.5){c=mix(vec3(0.1,0.9,0.6),vec3(0.65,0.2,1.0),0.5+0.5*sin(uv.x*7.0+age*tempo*3.0));}if(style>2.5&&style<3.5){a*=step(0.35,fract(uv.x*22.0-age*tempo));}if(style>3.5){a*=0.45;}float t=clamp(age*tempo,0.0,1.0);float head=mix(0.15,0.85,t);if(side<0.0)head=1.0-head;float tail=exp(-pow((uv.x-head)/0.13,2.0))*line;a=max(a,tail*trail*(1.0-t));gl_FragColor=vec4(c,clamp(a*alpha,0.0,1.0));}"

    invoke-static {v1, v2}, Lcom/google/oslo/LabGlowRenderer;->shader(ILjava/lang/String;)I

    move-result v1

    .line 46
    const/4 v2, 0x0

    if-eqz v0, :cond_4b

    if-nez v1, :cond_18

    goto :goto_4b

    .line 51
    :cond_18
    invoke-static {}, Landroid/opengl/GLES20;->glCreateProgram()I

    move-result v3

    iput v3, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    .line 52
    iget v3, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    invoke-static {v3, v0}, Landroid/opengl/GLES20;->glAttachShader(II)V

    iget v3, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    invoke-static {v3, v1}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 53
    iget v3, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    invoke-static {v3}, Landroid/opengl/GLES20;->glLinkProgram(I)V

    .line 54
    invoke-static {v0}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    invoke-static {v1}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 55
    const/4 v0, 0x1

    new-array v1, v0, [I

    iget v3, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    const v4, 0x8b82

    invoke-static {v3, v4, v1, v2}, Landroid/opengl/GLES20;->glGetProgramiv(II[II)V

    .line 56
    aget v1, v1, v2

    if-nez v1, :cond_4a

    iget v0, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    iput v2, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    return v2

    .line 57
    :cond_4a
    return v0

    .line 47
    :cond_4b
    :goto_4b
    if-eqz v0, :cond_50

    invoke-static {v0}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 48
    :cond_50
    if-eqz v1, :cond_55

    invoke-static {v1}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 49
    :cond_55
    return v2
.end method

.method private static shader(ILjava/lang/String;)I
    .registers 4

    .line 36
    invoke-static {p0}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result p0

    .line 37
    invoke-static {p0, p1}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    invoke-static {p0}, Landroid/opengl/GLES20;->glCompileShader(I)V

    .line 38
    const/4 p1, 0x1

    new-array p1, p1, [I

    .line 39
    const v0, 0x8b81

    const/4 v1, 0x0

    invoke-static {p0, v0, p1, v1}, Landroid/opengl/GLES20;->glGetShaderiv(II[II)V

    .line 40
    aget p1, p1, v1

    if-nez p1, :cond_1c

    invoke-static {p0}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    return v1

    .line 41
    :cond_1c
    return p0
.end method

.method private uniform(Ljava/lang/String;F)V
    .registers 4

    .line 60
    iget v0, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    invoke-static {v0, p1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result p1

    invoke-static {p1, p2}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 61
    return-void
.end method


# virtual methods
.method public draw()V
    .registers 21

    .line 63
    move-object/from16 v0, p0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    .line 64
    sget-object v3, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    invoke-virtual {v3, v1, v2}, Lcom/google/oslo/ExperimentPolicy;->previewing(J)Z

    move-result v3

    .line 65
    sget-object v4, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    sget v5, Lcom/google/oslo/OsloExperiments;->savedStyle:I

    invoke-virtual {v4, v5, v1, v2}, Lcom/google/oslo/ExperimentPolicy;->theme(IJ)I

    move-result v4

    .line 66
    sget-wide v5, Lcom/google/oslo/OsloExperiments;->gestureAt:J

    sub-long v5, v1, v5

    .line 67
    sget-boolean v7, Lcom/google/oslo/OsloExperiments;->enabled:Z

    if-eqz v7, :cond_12d

    const-wide/16 v7, 0x4b0

    if-nez v3, :cond_36

    sget-boolean v9, Lcom/google/oslo/OsloExperiments;->shown:Z

    if-eqz v9, :cond_12d

    cmp-long v9, v5, v7

    if-gez v9, :cond_12d

    const-wide/16 v9, 0x0

    cmp-long v9, v5, v9

    if-ltz v9, :cond_12d

    if-nez v4, :cond_36

    sget-boolean v9, Lcom/google/oslo/OsloExperiments;->trails:Z

    if-nez v9, :cond_36

    goto/16 :goto_12d

    .line 69
    :cond_36
    iget v9, v0, Lcom/google/oslo/LabGlowRenderer;->program:I

    if-nez v9, :cond_41

    invoke-direct/range {p0 .. p0}, Lcom/google/oslo/LabGlowRenderer;->initialize()Z

    move-result v9

    if-nez v9, :cond_41

    return-void

    .line 70
    :cond_41
    const/4 v9, 0x1

    new-array v10, v9, [I

    const v11, 0x8b8d

    const/4 v12, 0x0

    invoke-static {v11, v10, v12}, Landroid/opengl/GLES20;->glGetIntegerv(I[II)V

    .line 71
    iget v11, v0, Lcom/google/oslo/LabGlowRenderer;->program:I

    invoke-static {v11}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 72
    iget v11, v0, Lcom/google/oslo/LabGlowRenderer;->program:I

    const-string v13, "p"

    invoke-static {v11, v13}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v11

    .line 73
    iget-object v13, v0, Lcom/google/oslo/LabGlowRenderer;->quad:Ljava/nio/FloatBuffer;

    invoke-virtual {v13, v12}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/FloatBuffer;

    invoke-static {v11}, Landroid/opengl/GLES20;->glEnableVertexAttribArray(I)V

    .line 74
    const/16 v18, 0x0

    iget-object v13, v0, Lcom/google/oslo/LabGlowRenderer;->quad:Ljava/nio/FloatBuffer;

    const/4 v15, 0x2

    const/16 v16, 0x1406

    const/16 v17, 0x0

    move v14, v11

    move-object/from16 v19, v13

    invoke-static/range {v14 .. v19}, Landroid/opengl/GLES20;->glVertexAttribPointer(IIIZILjava/nio/Buffer;)V

    .line 75
    const/high16 v13, 0x44960000    # 1200.0f

    if-eqz v3, :cond_77

    rem-long v7, v1, v7

    long-to-float v7, v7

    goto :goto_78

    :cond_77
    long-to-float v7, v5

    :goto_78
    div-float/2addr v7, v13

    const-string v8, "age"

    invoke-direct {v0, v8, v7}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 76
    const-string v7, "style"

    int-to-float v8, v4

    invoke-direct {v0, v7, v8}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 77
    sget-object v7, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    sget v8, Lcom/google/oslo/OsloExperiments;->savedSpeed:I

    invoke-virtual {v7, v8, v1, v2}, Lcom/google/oslo/ExperimentPolicy;->tempo(IJ)I

    move-result v7

    int-to-float v7, v7

    const/high16 v8, 0x42c80000    # 100.0f

    div-float/2addr v7, v8

    const-string v14, "tempo"

    invoke-direct {v0, v14, v7}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 78
    sget v7, Lcom/google/oslo/OsloExperiments;->brightness:I

    int-to-float v7, v7

    div-float/2addr v7, v8

    const/high16 v8, 0x3f800000    # 1.0f

    if-eqz v3, :cond_9f

    move v5, v8

    goto :goto_a3

    :cond_9f
    long-to-float v5, v5

    div-float/2addr v5, v13

    sub-float v5, v8, v5

    :goto_a3
    mul-float/2addr v7, v5

    const-string v5, "alpha"

    invoke-direct {v0, v5, v7}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 79
    nop

    .line 80
    sget-object v5, Lcom/google/oslo/OsloExperiments;->POLICY:Lcom/google/oslo/ExperimentPolicy;

    sget-boolean v6, Lcom/google/oslo/OsloExperiments;->trails:Z

    .line 79
    invoke-virtual {v5, v6, v1, v2}, Lcom/google/oslo/ExperimentPolicy;->trails(ZJ)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_bd

    if-nez v3, :cond_bb

    sget v1, Lcom/google/oslo/OsloExperiments;->direction:I

    if-eqz v1, :cond_bd

    .line 80
    :cond_bb
    move v1, v8

    goto :goto_be

    :cond_bd
    move v1, v2

    .line 79
    :goto_be
    const-string v5, "trail"

    invoke-direct {v0, v5, v1}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 81
    sget v1, Lcom/google/oslo/OsloExperiments;->direction:I

    int-to-float v1, v1

    const-string v5, "side"

    invoke-direct {v0, v5, v1}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 82
    if-nez v4, :cond_cf

    if-eqz v3, :cond_d0

    :cond_cf
    move v2, v8

    :cond_d0
    const-string v1, "strip"

    invoke-direct {v0, v1, v2}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 83
    iget v1, v0, Lcom/google/oslo/LabGlowRenderer;->height:I

    int-to-float v1, v1

    iget v2, v0, Lcom/google/oslo/LabGlowRenderer;->width:I

    int-to-float v2, v2

    div-float/2addr v1, v2

    const-string v2, "aspect"

    invoke-direct {v0, v2, v1}, Lcom/google/oslo/LabGlowRenderer;->uniform(Ljava/lang/String;F)V

    .line 84
    sget-boolean v1, Lcom/google/oslo/OsloExperiments;->airDj:Z

    if-eqz v1, :cond_ee

    if-nez v3, :cond_ee

    sget v1, Lcom/google/oslo/OsloExperiments;->airMode:I

    invoke-static {v1}, Lcom/google/oslo/AirDjPolicy;->glowHue(I)F

    move-result v1

    goto :goto_f0

    :cond_ee
    const/high16 v1, 0x433e0000    # 190.0f

    .line 85
    :goto_f0
    const/4 v2, 0x3

    new-array v2, v2, [F

    aput v1, v2, v12

    const/high16 v1, 0x3f400000    # 0.75f

    aput v1, v2, v9

    const/4 v1, 0x2

    aput v8, v2, v1

    invoke-static {v2}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v1

    .line 86
    iget v0, v0, Lcom/google/oslo/LabGlowRenderer;->program:I

    const-string v2, "color"

    invoke-static {v0, v2}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    .line 87
    invoke-static {v1}, Landroid/graphics/Color;->red(I)I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x437f0000    # 255.0f

    div-float/2addr v2, v3

    invoke-static {v1}, Landroid/graphics/Color;->green(I)I

    move-result v4

    int-to-float v4, v4

    div-float/2addr v4, v3

    .line 88
    invoke-static {v1}, Landroid/graphics/Color;->blue(I)I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v1, v3

    .line 86
    invoke-static {v0, v2, v4, v1}, Landroid/opengl/GLES20;->glUniform3f(IFFF)V

    .line 89
    const/4 v0, 0x5

    const/4 v1, 0x4

    invoke-static {v0, v12, v1}, Landroid/opengl/GLES20;->glDrawArrays(III)V

    .line 90
    invoke-static {v11}, Landroid/opengl/GLES20;->glDisableVertexAttribArray(I)V

    .line 91
    aget v0, v10, v12

    invoke-static {v0}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 92
    return-void

    .line 68
    :cond_12d
    :goto_12d
    return-void
.end method

.method public reset()V
    .registers 2

    .line 33
    const/4 v0, 0x0

    iput v0, p0, Lcom/google/oslo/LabGlowRenderer;->program:I

    return-void
.end method

.method public resize(II)V
    .registers 4

    .line 34
    const/4 v0, 0x1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Lcom/google/oslo/LabGlowRenderer;->width:I

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Lcom/google/oslo/LabGlowRenderer;->height:I

    return-void
.end method
