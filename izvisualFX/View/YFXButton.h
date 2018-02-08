//
//  YFXButton.h
//  izvisualFX
//
//  Created by Le Viet Quang on 2/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : int{
    IconTop = 0,
    IconBottom,
    IconLeft,
    IconRight
} YFXButtonIconPosition;

@interface YFXButton : UIButton
{
    CGPoint content_padding;
    CGSize icon_size;
    CGSize btn_size;
    CGSize label_size;
    YFXButtonIconPosition icon_postion;
}

@property(nonatomic, retain) NSString* button_name;

-(void) settingButtonImageSize:(CGSize) size;
-(void) settingButtonLabelSize:(CGSize) size;
-(void) settingImagePostion:(YFXButtonIconPosition) position;
-(void) setFrame:(CGRect)frame;

@end
