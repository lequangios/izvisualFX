//
//  MenuView.m
//  izvisualFX
//
//  Created by quangle on 2/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "MenuView.h"
#import "VisualizationFX.h"

@implementation MenuView

@synthesize delegate                = _delegate;
@synthesize menu_item_size          = _menu_item_size;
@synthesize menu_padding            = _menu_padding;
@synthesize blendmode               = _blendmode;
@synthesize content                 = _content;

-(instancetype) init
{
    self = [super init];
    if(self){
        is_touch_down = NO;
        is_show_menu = NO;
        is_auto_complete_start = NO;
        is_auto_complete_end = YES;
        snap_to = 0;
        snap_end = 250;
        snap_start = 10;
        direction = 0;
        
        _content = [[UIScrollView alloc] init];
        _content.backgroundColor = [UIColor clearColor];
        [self addSubview:_content];
        
        _blendmode = [[YFXButton alloc] init];
        [_blendmode setBackgroundColor:[UIColor clearColor]];
        [_blendmode setImage:[[YFResourceManager shareInstance] imageRenderForResource:@"blend" andType:@"png"] forState:UIControlStateNormal];
        [_blendmode setTitle:@"Blend Mode" forState:UIControlStateNormal];
        [_blendmode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_content addSubview:_blendmode];
        
    }
    return self;
}


-(void) settingMenuWithFrame:(CGRect) frame
{
    self.frame = frame;
    self.backgroundColor = [UIColor whiteColor];
    snap_end = self.frame.size.width;
    
    [_blendmode settingImagePostion:IconLeft];
    [_blendmode settingButtonImageSize:CGSizeMake(32, 32)];
    [_blendmode settingButtonLabelSize:CGSizeMake(100, 32)];
    _blendmode.frame = CGRectMake(_menu_padding.x, 0, _menu_item_size.width, _menu_item_size.height);
    _blendmode.backgroundColor = [UIColor purpleColor];
    _content.frame = CGRectMake(0, _menu_padding.y, frame.size.width, frame.size.height - 2*_menu_padding.y);
}

-(void) touchBegin:(CGPoint) touch
{
    if(is_auto_complete_start == YES) return;
    
    current_point = touch;
    if(is_show_menu == YES)
    {
        if (current_point.x > snap_end) {
            is_touch_down = YES;
        }
    }
    else is_touch_down = YES;
}

-(void) touchMove:(CGPoint) touch
{
    if(is_touch_down == YES && is_auto_complete_start == NO)
    {
        CGPoint point = touch;
        direction = point.x - current_point.x;
        float dx = direction + self.frame.origin.x;
        current_point = point;
        if (dx <= 0) {
            self.frame = CGRectMake(dx, self.frame.origin.y, snap_end, self.frame.size.height);
            if (_delegate != nil && [_delegate respondsToSelector:@selector(moveWithDirection:)]){
                [_delegate performSelector:@selector(moveWithDirection:) withObject:[NSNumber numberWithFloat:direction]];
            }
        }
        else {
            is_show_menu = YES;
        }
    }
}

-(void) touchEnd:(CGPoint) touch
{
    // Hide it
    if(direction < -snap_start) {
        is_auto_complete_start = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(-snap_end, self.frame.origin.y, snap_end, self.frame.size.height);
            if (_delegate != nil && [_delegate respondsToSelector:@selector(snapToStart)]){
                [_delegate performSelector:@selector(snapToStart) withObject:nil];
            }
        } completion:^(BOOL finished) {
            if (_delegate != nil && [_delegate respondsToSelector:@selector(snapToStartComplete)]){
                [_delegate performSelector:@selector(snapToStartComplete) withObject:nil];
            }
            is_auto_complete_start = NO;
            is_show_menu = NO;
        }];
    }
    else if(direction > snap_start) {
        is_auto_complete_start = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(0, self.frame.origin.y, snap_end, self.frame.size.height);
            if (_delegate != nil && [_delegate respondsToSelector:@selector(snapToEnd)]){
                [_delegate performSelector:@selector(snapToEnd) withObject:nil];
            }
        } completion:^(BOOL finished) {
            if (_delegate != nil && [_delegate respondsToSelector:@selector(snapToEndComplete)]){
                [_delegate performSelector:@selector(snapToEndComplete) withObject:nil];
            }
            is_auto_complete_start = NO;
            is_show_menu = YES;
        }];
    }
    
    is_touch_down = NO;
}

-(void) showHideMenu
{
    is_auto_complete_start = YES;
}
@end
