//
//  FlyBubble.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/14/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFXFlyBubbleParticle : NSObject

@property(nonatomic, assign) CGGradientRef f;
@property(nonatomic, assign) float x;
@property(nonatomic, assign) float y;
@property(nonatomic, assign) float r;
@property(nonatomic, assign) float a;
@property(nonatomic, assign) float v;

-(instancetype) initWithWidth:(float) width andHeight:(float) height andStartColor:(UIColor*) start andEndColor:(UIColor*) end;
-(void) resetWithWidth:(float) width andHeight:(float) height andStartColor:(UIColor*) start andEndColor:(UIColor*) end;

@end


@interface YFXFlyBubble : UIView
{
    int max_item;
    float width;
    float height;
    float interval;
    BOOL is_animation;
    CGRect draw_rect;
    UIColor* start_color;
    UIColor* end_color;
}
@property(nonatomic, retain) NSMutableArray* bubble_particles;

-(instancetype) initWithFrame:(CGRect)frame andMaxItem:(int) max_items;
-(void) setBeginColor:(UIColor*) beg andEndColor:(UIColor*) end;
-(void) viewChangeToFrame:(CGRect) frame;
-(void) setSpeed:(float) speed;
-(void) startAnimation;
-(void) stopAnimation;

@end
