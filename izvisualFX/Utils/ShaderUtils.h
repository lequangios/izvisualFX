//
//  ShaderUtils.h
//  izvisualFX
//
//  Created by quangle on 1/23/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <GLKit/GLKit.h>

@interface ShaderUtils : NSObject
{
    GLuint vertShader, fragShader, program;
    NSString *vertShaderPathname, *fragShaderPathname;
}

-(instancetype) initWithVertex:(NSString*) vertex_name andWithFrag:(NSString*) fragment_name;
-(GLuint) getVertexShader;
-(GLuint) getFragmentShader;
-(GLuint) getProgramShader;


@end
