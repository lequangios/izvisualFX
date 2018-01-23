//
//  SphereView.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/19/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "SphereView.h"

@implementation SphereModel

-(instancetype) initWithRadius:(GLfloat) radius withLati:(int) latitudeBands withLong:(int) longitudeBands
{
    self = [super init];
    if(self){
        totalTextureCoord       = 2*latitudeBands*longitudeBands;
        totalVerticesPosition   = 3*latitudeBands*longitudeBands;
        totalVerticesIndex      = 6*latitudeBands*longitudeBands;
        
        textureCoordData    = (GLfloat *)malloc(totalTextureCoord*sizeof(GLfloat));
        verticesPosition    = (GLfloat *)malloc(totalVerticesPosition*sizeof(GLfloat));
        verticesIndexData   = (GLint *)malloc(totalVerticesIndex*sizeof(GLint));
        
        [self initSphereDataWithRadius:radius withLati:latitudeBands withLong:longitudeBands];
    }
    return self;
}

-(void) initSphereDataWithRadius:(float) radius withLati:(int) latitudeBands withLong:(int) longitudeBands
{
    int index1 = 0;
    int index2 = 0;
    int index3 = 0;
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
            
            textureCoordData[index1] = u;
            textureCoordData[index1+1] = v;
            
            verticesPosition[index2] = radius*x;
            verticesPosition[index2+1] = radius*y;
            verticesPosition[index2+2] = radius*z;
            index1 += 2;
            index2 += 3;
        }
    }
    
    // Index array
    for (int i = 0; i < latitudeBands; i++) {
        for (int longNumber = 0; longNumber < longitudeBands; longNumber++) {
            int first = (i * (longitudeBands + 1)) + longNumber;
            int second = first + longitudeBands + 1;
            
            verticesIndexData[index3] = first;
            verticesIndexData[index3+1] = second;
            verticesIndexData[index3+2] = first + 1;
            
            verticesIndexData[index3+3] = second;
            verticesIndexData[index3+4] = second + 1;
            verticesIndexData[index3+5] = first + 1;
            
            index3 += 6;
        }
    }
}

-(void) freeBufferData
{
    free(textureCoordData);
    free(verticesPosition);
    free(verticesPosition);
}

-(unsigned int) getTextureCoordDataSize
{
    return totalTextureCoord*sizeof(GLfloat);
}

-(unsigned int) getVerticesPositionSize
{
    return totalVerticesPosition*sizeof(GLfloat);
}

-(unsigned int) getVerticesIndexDataSize
{
    return totalVerticesIndex*sizeof(GLint);
}

-(GLfloat*) getTextureCoordData
{
    return textureCoordData;
}

-(GLfloat*) getVerticesPosition
{
    return verticesPosition;
}

-(GLint*) getVerticesIndexData
{
    return verticesIndexData;
}

-(NSString*) getVertexShaderPathName
{
    return @"yfxSphere";
}

-(NSString*) getFragmentShaderPathName
{
    return @"yfxSphere";
}

@end

@implementation SphereView

@synthesize displayLink = _displayLink;
@synthesize data_model  = _data_model;
@synthesize shader_model = _shader_model;

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
//    glGenRenderbuffers(1, &_colorRenderBuffer);
//    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
//    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

-(void) setupFrameBuffer
{
//    GLuint framebuffer;
//    glGenFramebuffers(1, &framebuffer);
//    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
//    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
//                              GL_RENDERBUFFER, _colorRenderBuffer);
}

-(GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    

//    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName
//                                                           ofType:@"glsl"];
//    NSError* error;
//    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
//                                                       encoding:NSUTF8StringEncoding error:&error];
//    if (!shaderString) {
//        NSLog(@"Error loading shader: %@", error.localizedDescription);
//        exit(1);
//    }
//
//
//    GLuint shaderHandle = glCreateShader(shaderType);
//
//
//    const char * shaderStringUTF8 = [shaderString UTF8String];
//    int shaderStringLength = (int)[shaderString length];
//    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
//
//
//    glCompileShader(shaderHandle);
//
//
//    GLint compileSuccess;
//    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
//    if (compileSuccess == GL_FALSE) {
//        GLchar messages[256];
//        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
//        NSString *messageString = [NSString stringWithUTF8String:messages];
//        NSLog(@"%@", messageString);
//        exit(1);
//    }
//
    return 1;
    
}

-(void) render
{
//    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
//    glClear(GL_COLOR_BUFFER_BIT);
//    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

#pragma mark - Provide Sphere Data

#pragma mark - Interface OpenGL Function
-(void) initDefaultOpenGLData
{
    _data_model = [[SphereModel alloc] initWithRadius:radius withLati:latitudeBands withLong:longitudeBands];
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
    glGenBuffers(1, &verticesPositionBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, verticesPositionBuffer);
    glBufferData(GL_ARRAY_BUFFER, [_data_model getVerticesPositionSize], [_data_model getVerticesPosition], GL_STATIC_DRAW);
    
    glGenBuffers(1, &textureCoordBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, textureCoordBuffer);
    glBufferData(GL_ARRAY_BUFFER, [_data_model getTextureCoordDataSize], [_data_model getTextureCoordData], GL_STATIC_DRAW);
    
    glGenBuffers(1, &verticesPositionIndexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, verticesPositionIndexBuffer);
    glBufferData(GL_ARRAY_BUFFER, [_data_model getVerticesIndexDataSize], [_data_model getVerticesIndexData], GL_STATIC_DRAW);
}

-(void) initOpenGLShader
{
    _shader_model = [[ShaderUtils alloc] initWithVertex:[_data_model getVertexShaderPathName] andWithFrag:[_data_model getFragmentShaderPathName]];
    is_shader_loaded = [_shader_model loadShaders];
}

-(void) setupOpenGLShader
{
    if(is_shader_loaded == NO)
    {
        // Get-set Shader Uniform
        GLuint uPMatrix = glGetUniformLocation([_shader_model getProgramShader], [@"uPMatrix" cStringUsingEncoding:NSUTF8StringEncoding]);
        glUniformMatrix4fv(uPMatrix, 1, false, projectionMatrix.m);
        
        GLuint uMVMatrix = glGetUniformLocation([_shader_model getProgramShader], [@"uMVMatrix" cStringUsingEncoding:NSUTF8StringEncoding]);
        glUniformMatrix4fv(uMVMatrix, 1, false, modelViewMatrix.m);
        
        // Get-set Shader Attribute
        
    }
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
