//
//  YFXMatrix.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/21/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <GLKit/GLKit.h>

@interface YFXMatrix : NSObject

+(GLKMatrix4) create;
+(GLKMatrix4) identity;

@end
