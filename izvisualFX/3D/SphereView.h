//
//  SphereView.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/19/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface  SphereModel:NSObject
{
    GLfloat *textureCoordData;
    GLfloat *verticesPosition;
    GLint *verticesIndexData;
    
    int totalTextureCoord;
    int totalVerticesPosition;
    int totalVerticesIndex;
}

-(instancetype) initWithRadius:(GLfloat) radius withLati:(int) latitudeBands withLong:(int) longitudeBands;
-(void) freeBufferData;

-(unsigned int) getTextureCoordDataSize;
-(unsigned int) getVerticesPositionSize;
-(unsigned int) getVerticesIndexDataSize;

-(GLfloat*) getTextureCoordData;
-(GLfloat*) getVerticesPosition;
-(GLint*) getVerticesIndexData;

@end

@interface SphereView : UIView
{
    float span;
    float tilt;
    float zoom;
    float radius;
    float width;
    float height;
    float aspect;
    float direction;
    
    int latitudeBands;
    int longitudeBands;
    
    GLuint verticesPositionBuffer;
    GLint textureCoordBuffer;
    GLint verticesPositionIndexBuffer;
    
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    GLKMatrix4 modelViewMatrix;
    GLKMatrix4 projectionMatrix;
}
@property(nonatomic, retain) CADisplayLink* displayLink;
@property(nonatomic, retain) SphereModel* data_model;

+(Class) layerClass;

-(void) setupLayer;
-(void) setupContext;
-(void) setupRenderBuffer;
-(void) setupFrameBuffer;
-(void) render;

-(void) initDefaultOpenGLData;
-(void) initOpenGLContext;
-(void) setupOpenGLViewport;
-(void) setupOpenGLMatrix;
-(void) setupOpenGLBuffer;
-(void) initOpenGLShader;
-(void) drawOpenGLContext;
-(void) update;
-(void) renderedContext;
-(void) startRendered;
@end
