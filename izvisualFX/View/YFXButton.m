//
//  YFXButton.m
//  izvisualFX
//
//  Created by Le Viet Quang on 2/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "YFXButton.h"

@implementation YFXButton

@synthesize button_name = _button_name;

-(instancetype) init
{
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        icon_postion = IconLeft;
        image_size = CGSizeZero;
    }
    return self;
}

-(void) settingButtonImageSize:(CGSize) size
{
    
}

-(void) settingImagePostion:(YFXButtonIconPosition) position
{
    
}

-(void) setFrame:(CGRect)frame
{
    
}

@end
