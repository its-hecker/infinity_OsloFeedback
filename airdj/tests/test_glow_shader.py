#!/usr/bin/env python3
"""Exercise the actual Java GLSL strings using a software EGL/GLES context."""
import ctypes as C, ctypes.util, re, json
from pathlib import Path
E=C.CDLL(ctypes.util.find_library('EGL'))
E.eglGetProcAddress.argtypes=[C.c_char_p];E.eglGetProcAddress.restype=C.c_void_p
def egl(n,r,a):
 f=getattr(E,n);f.restype=r;f.argtypes=a;return f
vp=C.c_void_p;I=C.c_int;U=C.c_uint;F=C.c_float
platform=egl('eglGetPlatformDisplay',vp,[U,vp,C.POINTER(I)])
display=platform(0x31DD,None,None)
assert display
major=I();minor=I();assert egl('eglInitialize',U,[vp,C.POINTER(I),C.POINTER(I)])(display,C.byref(major),C.byref(minor))
assert egl('eglBindAPI',U,[U])(0x30A0)
attrs=(I*15)(0x3033,1,0x3040,4,0x3024,8,0x3023,8,0x3022,8,0x3021,8,0x3038,0,0)
config=vp();count=I();assert egl('eglChooseConfig',U,[vp,C.POINTER(I),C.POINTER(vp),I,C.POINTER(I)])(display,attrs,C.byref(config),1,C.byref(count)) and count.value
surface=egl('eglCreatePbufferSurface',vp,[vp,vp,C.POINTER(I)])(display,config,(I*5)(0x3057,240,0x3056,60,0x3038))
context=egl('eglCreateContext',vp,[vp,vp,vp,C.POINTER(I)])(display,config,None,(I*3)(0x3098,2,0x3038))
assert surface and context
assert egl('eglMakeCurrent',U,[vp,vp,vp,vp])(display,surface,surface,context)
def gl(n,r,*a):
 ptr=E.eglGetProcAddress(n.encode());assert ptr,n
 return C.CFUNCTYPE(r,*a)(ptr)
java=(Path(__file__).resolve().parents[1]/'src/com/google/oslo/LabGlowRenderer.java').read_text()
def source(name):
 part=java.split('String '+name+' = ',1)[1].split(';\n',1)[0]
 return ''.join(json.loads(q) for q in re.findall(r'"(?:[^"\\]|\\.)*"',part)).encode()
shaders=[]
for name,kind in [('VERTEX',0x8B31),('FRAGMENT',0x8B30)]:
 shader=gl('glCreateShader',U,U)(kind);src=source(name);s=C.c_char_p(src)
 gl('glShaderSource',None,U,I,C.POINTER(C.c_char_p),C.POINTER(I))(shader,1,C.byref(s),None)
 gl('glCompileShader',None,U)(shader);ok=I();gl('glGetShaderiv',None,U,U,C.POINTER(I))(shader,0x8B81,C.byref(ok))
 if not ok.value:
  log=C.create_string_buffer(4096);gl('glGetShaderInfoLog',None,U,I,C.POINTER(I),C.c_char_p)(shader,4096,None,log);raise AssertionError(log.value)
 shaders.append(shader)
program=gl('glCreateProgram',U)()
for shader in shaders:gl('glAttachShader',None,U,U)(program,shader)
gl('glLinkProgram',None,U)(program);ok=I();gl('glGetProgramiv',None,U,U,C.POINTER(I))(program,0x8B82,C.byref(ok));assert ok.value
gl('glUseProgram',None,U)(program)
p=gl('glGetAttribLocation',I,U,C.c_char_p)(program,b'p');gl('glEnableVertexAttribArray',None,U)(p)
quad=(F*8)(-1,-1,1,-1,-1,1,1,1)
gl('glVertexAttribPointer',None,U,I,U,U,I,vp)(p,2,0x1406,0,0,C.cast(quad,vp))
gl('glViewport',None,I,I,I,I)(0,0,240,60)
def uniform(name,value):
 loc=gl('glGetUniformLocation',I,U,C.c_char_p)(program,name.encode())
 gl('glUniform1f',None,I,F)(loc,value)
loc=gl('glGetUniformLocation',I,U,C.c_char_p)(program,b'color');gl('glUniform3f',None,I,F,F,F)(loc,.1,.7,1)
for name,value in {'age':.25,'tempo':1,'alpha':1,'trail':0,'side':1,'strip':1,'aspect':.25}.items():uniform(name,value)
outputs=[]
for style in range(5):
 uniform('style',style);gl('glClearColor',None,F,F,F,F)(0,0,0,0);gl('glClear',None,U)(0x4000)
 gl('glDrawArrays',None,U,I,I)(5,0,4)
 pixels=(C.c_ubyte*(240*60*4))();gl('glReadPixels',None,I,I,I,I,U,U,vp)(0,0,240,60,0x1908,0x1401,C.cast(pixels,vp))
 assert max(bytes(pixels)[3::4])>0,style
 outputs.append(bytes(pixels))
assert len(set(outputs))==5
uniform('strip',0);uniform('trail',1);uniform('style',0)
trails=[]
for side in [-1,1]:
 uniform('side',side);uniform('age',.25)
 gl('glDrawArrays',None,U,I,I)(5,0,4)
 pixels=(C.c_ubyte*(240*60*4))();gl('glReadPixels',None,I,I,I,I,U,U,vp)(0,0,240,60,0x1908,0x1401,C.cast(pixels,vp))
 trails.append(bytes(pixels)[3::4])
assert trails[0]!=trails[1] and all(max(t)>0 for t in trails)
uniform('age',1);gl('glDrawArrays',None,U,I,I)(5,0,4)
pixels=(C.c_ubyte*(240*60*4))();gl('glReadPixels',None,I,I,I,I,U,U,vp)(0,0,240,60,0x1908,0x1401,C.cast(pixels,vp))
assert max(bytes(pixels)[3::4])==0
assert gl('glGetError',U)()==0
print('EGL/GLES: vertex + fragment compiled/linked; five visible styles, directional trails and expiry rendered without GL errors')
