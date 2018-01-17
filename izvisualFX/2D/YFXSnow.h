//
//  YFXSnow.h
//  Pods-VisualizationFX_Example
//
//  Created by Le Viet Quang on 1/7/18.
//

#import <UIKit/UIKit.h>

@interface YFXSnowParticle : NSObject

@property(nonatomic, assign) float x;
@property(nonatomic, assign) float y;
@property(nonatomic, assign) float r;
@property(nonatomic, assign) float d;

-(instancetype) initWithX:(float) in_x withY:(float) in_y withR:(float) in_r withD:(float) in_d;
-(void) refreshWithX:(float) in_x withY:(float) in_y withR:(float) in_r withD:(float) in_d;

@end

@interface YFXSnow : UIView
{
    int max_item;
    float width;
    float height;
    float angle;
    float speedAnimation;
    UIColor* snow_color;
    BOOL is_animation;
    CGRect draw_rect;
}

@property(nonatomic, retain) NSMutableArray* particle_arr;

-(instancetype) initWithFrame:(CGRect)frame andMaxItem:(int) max_items;
-(void) setSnowItemColor:(UIColor*) color;
-(void) viewChangeToFrame:(CGRect)frame;
-(void) setSpeed:(float) speed;
-(void) startAnimation;
-(void) stopAnimation;

@end
