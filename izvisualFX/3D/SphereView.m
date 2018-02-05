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

-(NSString*) getTextureImageName
{
    return @"Earth.png";
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
        [self initDefaultOpenGLData];
    }
    return self;
}

+(Class) layerClass
{
    return [CAEAGLLayer class];
}


#pragma mark - Interface OpenGL Function
-(void) initDefaultOpenGLData
{
    latitudeBands = 30;
    longitudeBands = 30;
    radius = 0.5;
    span = 0;
    tilt = 0;
    zoom = 1;
    is_error = NO;
    is_shader_loaded = NO;
    
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
    if(is_shader_loaded == YES)
    {
        // Get-set Shader Uniform
        GLuint uPMatrix = glGetUniformLocation([_shader_model getProgramShader], [@"uPMatrix" cStringUsingEncoding:NSUTF8StringEncoding]);
        glUniformMatrix4fv(uPMatrix, 1, false, projectionMatrix.m);
        
        GLuint uMVMatrix = glGetUniformLocation([_shader_model getProgramShader], [@"uMVMatrix" cStringUsingEncoding:NSUTF8StringEncoding]);
        glUniformMatrix4fv(uMVMatrix, 1, false, modelViewMatrix.m);
        
        // Get-set Shader Attribute
        GLuint aVertexPosition = glGetAttribLocation([_shader_model getProgramShader], [@"aVertexPosition" cStringUsingEncoding:NSUTF8StringEncoding]);
        glEnableVertexAttribArray(aVertexPosition);
        glBindBuffer(GL_ARRAY_BUFFER, verticesPositionBuffer);
        glVertexAttribPointer(aVertexPosition, 3, GL_FLOAT, GL_FALSE, 3*sizeof(GLfloat), 0);
        
        GLuint aTextureCoord = glGetAttribLocation([_shader_model getProgramShader], [@"aTextureCoord" cStringUsingEncoding:NSUTF8StringEncoding]);
        glEnableVertexAttribArray(aTextureCoord);
        glBindBuffer(GL_ARRAY_BUFFER, textureCoordBuffer);
        glVertexAttribPointer(aTextureCoord, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);
        
        // Get set for Texture
        GLuint uSampler = glGetUniformLocation([_shader_model getProgramShader], [@"uSampler" cStringUsingEncoding:NSUTF8StringEncoding]);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, glTexture);
        glUniform1i(uSampler, 0);
    }
}

-(BOOL) initOpenGLTexture
{
    CGImageRef spriteImage = [UIImage imageNamed:[_data_model getTextureImageName]].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", [_data_model getTextureImageName]);
        return NO;
    }
    
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    glGenTextures(1, &glTexture);
    glPixelStorei(GL_PACK_ALIGNMENT, YES);
    
    return YES;
}

-(void) setupOpenGLTexture
{
    glBindTexture(GL_TEXTURE_2D, glTexture);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (int)width, (int)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
    glBindTexture(GL_TEXTURE_2D, 0);
    
    free(spriteData);
}

-(void) startRendered
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(renderedContext)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void) initRendered
{
    [self initOpenGLContext];
    [self setupOpenGLViewport];
    [self setupOpenGLMatrix];
    [self setupOpenGLBuffer];
    [self initOpenGLShader];
    is_error = ![self initOpenGLTexture];
    if (is_error == NO)
    {
        [self setupOpenGLTexture];
        [self setupOpenGLShader];
        [self startRendered];
    }
}

-(void) renderedContext
{
    [self setupOpenGLMatrix];
    [self setupOpenGLShader];
    [self drawOpenGLContext];
    [self updateGraphics];
}

-(void) updateGraphics
{
    tilt += 0.01;
}

-(void) drawOpenGLContext
{
    if (is_error == YES) return;
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, verticesPositionIndexBuffer);
    glDrawElements(GL_TRIANGLES, [_data_model getVerticesIndexDataSize], GL_UNSIGNED_SHORT, 0);
}

#pragma mark - Relase Memory
-(void)dealloc
{
    [_data_model freeBufferData];
    
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
