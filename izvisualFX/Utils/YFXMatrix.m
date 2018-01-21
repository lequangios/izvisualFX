//
//  YFXMatrix.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/21/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "YFXMatrix.h"

@implementation YFXMatrix

+(GLKMatrix4) create
{
    return GLKMatrix4Make(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

+(GLKMatrix4) identity
{
    return GLKMatrix4Make(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0);
}


@end
