//
//  SphereView.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/19/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

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
    
    float *textureCoordData;
    float *verticesPosition;
    int *verticesIndexData;
    int totalTextureCoord;
    int totalVerticesPosition;
    int totalVerticesIndex;
    
    int latitudeBands;
    int longitudeBands;
    
    GLuint verticesPositionBuffer;
    GLint textureCoordBuffer;
    
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    GLKMatrix4 modelViewMatrix;
    GLKMatrix4 projectionMatrix;
}
@property(nonatomic, retain) CADisplayLink* displayLink;

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
