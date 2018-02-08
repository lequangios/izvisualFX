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
        icon_size = CGSizeZero;
        btn_size = CGSizeZero;
        label_size = CGSizeZero;
        content_padding = CGPointMake(5, 5);
    }
    return self;
}

-(void) settingButtonImageSize:(CGSize) size
{
    icon_size = size;
}

-(void) settingImagePostion:(YFXButtonIconPosition) position
{
    icon_postion = position;
}

-(void) settingButtonLabelSize:(CGSize) size
{
    label_size = size;
}

-(void) settingButtonWithFrame:(CGRect) frame
{
    btn_size = CGSizeMake(frame.size.width - 2*content_padding.x, frame.size.height - 2*content_padding.y);
    
    switch (icon_postion) {
        case IconTop:
        [self settingWithTop];
        break;
        case IconBottom:
        [self settingWithBottom];
        break;
        case IconLeft:
        [self settingWithLeft];
        break;
        case IconRight:
        [self settingWithRight];
        break;
        default:
        break;
    }
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self labelSize];
    [self settingButtonWithFrame:frame];
}

-(void) labelSize
{
    switch (icon_postion) {
        case IconTop:
        {
            label_size = CGSizeMake(btn_size.width-2*content_padding.x, btn_size.height-2*content_padding.x);
            break;
        }
        case IconBottom:
        {
            label_size = CGSizeMake(btn_size.width-2*content_padding.x, btn_size.height-2*content_padding.x);
            break;
        }
        case IconLeft:
        {
            label_size = CGSizeMake(btn_size.width-icon_size.width-2*content_padding.x, btn_size.height-2*content_padding.x);
            break;
        }
        case IconRight:
        {
            label_size = CGSizeMake(btn_size.width-icon_size.width-2*content_padding.x, btn_size.height-2*content_padding.x);
            break;
        }
        default:
            break;
    }
}

-(void) settingWithTop
{
    float left = (btn_size.width - icon_size.width)/2;
    float top = 0;
    
    self.imageView.frame = CGRectMake(left, top, icon_size.width, icon_size.height);
    top += (icon_size.height + content_padding.y);
    
    self.titleLabel.frame = CGRectMake(0, top, btn_size.width, btn_size.height-top);
}

-(void) settingWithLeft
{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    float top = (btn_size.height - icon_size.height)/2;
    float left = icon_size.width + content_padding.x;

    self.imageEdgeInsets = UIEdgeInsetsMake(top, 0, top, btn_size.width-left);
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    top = (btn_size.height - label_size.height)/2;
    self.titleEdgeInsets = UIEdgeInsetsMake(top, icon_size.width + content_padding.x - btn_size.width, top, content_padding.x);
    self.titleLabel.backgroundColor = [UIColor blueColor];
}

-(void) settingWithRight
{
    float top = (btn_size.height-icon_size.height)/2;
    float left = btn_size.width- icon_size.width;
    self.imageView.frame = CGRectMake(left, top, icon_size.width, icon_size.height);
    
    top = (btn_size.height - label_size.height)/2;
    left += content_padding.x;
    self.titleLabel.frame = CGRectMake(0, top, btn_size.width-left, btn_size.height - 2*top);
}

-(void) settingWithBottom
{
    float top = btn_size.height - icon_size.height;
    float left = (btn_size.width - icon_size.width)/2;
    
    self.imageView.frame = CGRectMake(left, top, icon_size.width, icon_size.height);
    self.titleLabel.frame = CGRectMake(0, 0, btn_size.width, btn_size.height - icon_size.height - content_padding.y);
    
}

@end
