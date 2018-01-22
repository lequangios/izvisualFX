//
//  SphereView.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/19/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "SphereView.h"

@implementation SphereView

@synthesize displayLink = _displayLink;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        [self render];
    }
    return self;
}

+(Class) layerClass
{
    return [CAEAGLLayer class];
}

-(void) setupLayer
{
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
    
}

-(void) setupContext
{
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

-(void) setupRenderBuffer
{
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

-(void) setupFrameBuffer
{
    GLuint framebuffer;
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, _colorRenderBuffer);
}

-(GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    

    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName
                                                           ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
                                                       encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    

    GLuint shaderHandle = glCreateShader(shaderType);
    

    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
   
    glCompileShader(shaderHandle);
    
  
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
    
}

-(void) render
{
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

#pragma mark - Provide Sphere Data
-(void) sphereData
{
    radius *= zoom;
    
    // Vertex array
    for (int i = 0; i <= latitudeBands; i++) {
        float theta = i * M_PI / latitudeBands;
        float sinTheta = sin(theta);
        float cosTheta = cos(theta);
        
        for (int j = 0; j <= longitudeBands; j++) {
            float phi = j * 2 * M_PI / longitudeBands;
            float sinPhi = sin(phi);
            float cosPhi = cos(phi);
            
            float x = cosPhi * sinTheta;
            float y = cosTheta;
            float z = sinPhi * sinTheta;
            float u = 1 - (j / longitudeBands);
            float v = 1 - (i / latitudeBands);
            
            textureCoordData[totalTextureCoord] = u;
            textureCoordData[totalTextureCoord+1] = v;
            
            verticesPosition[totalVerticesPosition] = radius*x;
            verticesPosition[totalVerticesPosition+1] = radius*y;
            verticesPosition[totalVerticesPosition+2] = radius*z;
            totalTextureCoord += 2;
            totalVerticesPosition += 3;
        }
    }
    
    // Index array
    for (int i = 0; i < latitudeBands; i++) {
        for (int longNumber = 0; longNumber < longitudeBands; longNumber++) {
            int first = (i * (longitudeBands + 1)) + longNumber;
            int second = first + longitudeBands + 1;
            
            verticesIndexData[totalVerticesIndex] = first;
            verticesIndexData[totalVerticesIndex+1] = second;
            verticesIndexData[totalVerticesIndex+2] = first + 1;
            
            verticesIndexData[totalVerticesIndex+3] = second;
            verticesIndexData[totalVerticesIndex+4] = second + 1;
            verticesIndexData[totalVerticesIndex+5] = first + 1;
        }
    }
}

#pragma mark - Interface OpenGL Function
-(void) initDefaultOpenGLData
{
    
}

-(void) initOpenGLContext
{
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

-(void) setupOpenGLViewport
{
    float dy = (width - height)/2;
    glViewport(0, -dy, width, height);
    
    aspect = width/height;
    
    direction = 0.01*sqrt(width*width + height*height)/360;
    
    if(aspect>1) {
        zoom = 1/aspect;
    }
}

-(void) setupOpenGLMatrix
{
    // Create View-Model Matrix
    GLKMatrix4 Vmatrix = GLKMatrix4MakeLookAt(0, 0, -1, 0, 0, 0, 0, 1, 0);
    
    // Create Transform Matrix
    GLKMatrix4 tmp = [YFXMatrix identity];
    GLKMatrix4 Mmatrix = GLKMatrix4Rotate(tmp, span, 0, 1, 0);
    Mmatrix = GLKMatrix4Rotate(Mmatrix, tilt, 1, 0, 0);
    Mmatrix = GLKMatrix4Translate(Mmatrix, 0, 0, 1);
    
    // Create Model View matrix
    modelViewMatrix = GLKMatrix4Multiply(Mmatrix, Vmatrix);
    
    // Create Projection Matrix
    projectionMatrix = GLKMatrix4MakePerspective(M_PI_4, width/height, 0.1, 100);
}

-(void) setupOpenGLBuffer
{
    _context
    glBufferData(<#GLenum target#>, <#GLsizeiptr size#>, <#const GLvoid *data#>, <#GLenum usage#>)
}

-(void) startRendered
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(renderedContext)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark - Relase Memory
-(void)dealloc
{
    _context = nil;
    if(_displayLink != nil)
    {
        [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
