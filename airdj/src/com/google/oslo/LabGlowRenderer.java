package com.google.oslo;

import android.opengl.GLES20;
import android.os.SystemClock;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

/** A bounded, non-interactive visual pass on Oslo's existing GL surface. */
public final class LabGlowRenderer {
    private int program, width = 1, height = 1;
    private final FloatBuffer quad = ByteBuffer.allocateDirect(32).order(ByteOrder.nativeOrder())
            .asFloatBuffer();
    private static final String VERTEX = "attribute vec2 p;varying vec2 uv;void main(){"
            + "uv=(p+1.0)*0.5;gl_Position=vec4(p,0.0,1.0);}";
    private static final String FRAGMENT = "precision mediump float;varying vec2 uv;"
            + "uniform float age,style,tempo,alpha,trail,side,strip,aspect;uniform vec3 color;"
            + "void main(){float y=(1.0-uv.y)*aspect;"
            + "float line=exp(-pow((y-0.015)/0.009,2.0));"
            + "float edge=smoothstep(0.05,0.2,uv.x)*(1.0-smoothstep(0.8,0.95,uv.x));"
            + "vec3 c=color;float a=line*edge*strip;"
            + "if(style>0.5&&style<1.5){a*=1.0+0.25*sin(age*8.0*tempo);c=mix(c,vec3(1.0,0.1,0.7),0.35);}"
            + "if(style>1.5&&style<2.5){c=mix(vec3(0.1,0.9,0.6),vec3(0.65,0.2,1.0),0.5+0.5*sin(uv.x*7.0+age*tempo*3.0));}"
            + "if(style>2.5&&style<3.5){a*=step(0.35,fract(uv.x*22.0-age*tempo));}"
            + "if(style>3.5){a*=0.45;}"
            + "float t=clamp(age*tempo,0.0,1.0);float head=mix(0.15,0.85,t);"
            + "if(side<0.0)head=1.0-head;"
            + "float tail=exp(-pow((uv.x-head)/0.13,2.0))*line;"
            + "a=max(a,tail*trail*(1.0-t));"
            + "gl_FragColor=vec4(c,clamp(a*alpha,0.0,1.0));}";

    public LabGlowRenderer() { quad.put(new float[] {-1,-1, 1,-1, -1,1, 1,1}).position(0); }
    public void reset() { program = 0; }
    public void resize(int w, int h) { width = Math.max(1, w); height = Math.max(1, h); }
    private static int shader(int type, String source) {
        int id = GLES20.glCreateShader(type);
        GLES20.glShaderSource(id, source); GLES20.glCompileShader(id);
        int[] result = new int[1];
        GLES20.glGetShaderiv(id, GLES20.GL_COMPILE_STATUS, result, 0);
        if (result[0] == 0) { GLES20.glDeleteShader(id); return 0; }
        return id;
    }
    private boolean initialize() {
        int vertex = shader(GLES20.GL_VERTEX_SHADER, VERTEX);
        int fragment = shader(GLES20.GL_FRAGMENT_SHADER, FRAGMENT);
        if (vertex == 0 || fragment == 0) {
            if (vertex != 0) GLES20.glDeleteShader(vertex);
            if (fragment != 0) GLES20.glDeleteShader(fragment);
            return false;
        }
        program = GLES20.glCreateProgram();
        GLES20.glAttachShader(program, vertex); GLES20.glAttachShader(program, fragment);
        GLES20.glLinkProgram(program);
        GLES20.glDeleteShader(vertex); GLES20.glDeleteShader(fragment);
        int[] result = new int[1]; GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, result, 0);
        if (result[0] == 0) { GLES20.glDeleteProgram(program); program = 0; return false; }
        return true;
    }
    private void uniform(String name, float value) {
        GLES20.glUniform1f(GLES20.glGetUniformLocation(program, name), value);
    }
    public void draw() {
        long now = SystemClock.elapsedRealtime();
        boolean preview = OsloExperiments.POLICY.previewing(now);
        int style = OsloExperiments.POLICY.theme(OsloExperiments.savedStyle, now);
        long delta = now - OsloExperiments.gestureAt;
        if (!OsloExperiments.enabled || (!preview && (!OsloExperiments.shown || delta >= 1200
                || delta < 0 || (style == 0 && !OsloExperiments.trails)))) return;
        if (program == 0 && !initialize()) return;
        int[] previous = new int[1]; GLES20.glGetIntegerv(GLES20.GL_CURRENT_PROGRAM,previous,0);
        GLES20.glUseProgram(program);
        int position = GLES20.glGetAttribLocation(program, "p");
        quad.position(0); GLES20.glEnableVertexAttribArray(position);
        GLES20.glVertexAttribPointer(position, 2, GLES20.GL_FLOAT, false, 0, quad);
        uniform("age", preview ? (now % 1200) / 1200f : delta / 1200f);
        uniform("style", style);
        uniform("tempo", OsloExperiments.POLICY.tempo(OsloExperiments.savedSpeed, now) / 100f);
        uniform("alpha", OsloExperiments.brightness / 100f * (preview ? 1f : 1f-delta/1200f));
        uniform("trail", OsloExperiments.POLICY.trails(OsloExperiments.trails,now)
                && (preview || OsloExperiments.direction != 0) ? 1f : 0f);
        uniform("side", OsloExperiments.direction);
        uniform("strip", style != 0 || preview ? 1f : 0f);
        uniform("aspect", height / (float) width);
        float hue = OsloExperiments.airDj && !preview ? AirDjPolicy.glowHue(OsloExperiments.airMode) : 190f;
        int color = android.graphics.Color.HSVToColor(new float[] {hue, .75f, 1f});
        GLES20.glUniform3f(GLES20.glGetUniformLocation(program, "color"),
                android.graphics.Color.red(color)/255f, android.graphics.Color.green(color)/255f,
                android.graphics.Color.blue(color)/255f);
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4);
        GLES20.glDisableVertexAttribArray(position);
        GLES20.glUseProgram(previous[0]);
    }
}
