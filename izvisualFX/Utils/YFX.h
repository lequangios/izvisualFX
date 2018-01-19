//
//  YFX.h
//  Pods-VisualizationFX_Example
//
//  Created by Le Viet Quang on 1/7/18.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^YFXActionAnimation)(__weak id obj, float currentValue);
typedef void (^YFXActionAnimationComplete)(__weak id obj, BOOL is_complete);
typedef float (^YFXAnimationFunction)(float frame, float begin, float change, float duration, float amplitude, float period);

typedef enum : int {
    YFXLinearEase,
    YFXEaseInQuad,
    YFXEaseOutQuad,
    YFXEaseInOutQuad,
    YFXEaseInCubic,
    YFXEaseOutCubic,
    YFXEaseInOutCubic,
    YFXEaseInQuart,
    YFXeaseOutQuart,
    YFXEaseInOutQuart,
    YFXEaseInQuint,
    YFXEaseOutQuint,
    YFXEaseInOutQuint,
    YFXEaseInSine,
    YFXEaseOutSine,
    YFXEaseInOutSine,
    YFXEaseInExpo,
    YFXEaseOutExpo,
    YFXEaseInOutExpo,
    YFXEaseInCirc,
    YFXEaseOutCirc,
    YFXEaseInOutCirc,
    YFXEaseInElastic,
    YFXEaseOutElastic,
    YFXEaseInOutElastic,
    YFXEaseInBack,
    YFXEaseOutBack,
    YFXEaseInOutBack,
    YFXEaseInBounce,
    YFXEaseOutBounce,
    YFXEaseInOutBounce
} YFXEaseType;

@interface YFX : NSObject
{
    float yfx_amplitude;
    float yfx_period;
    float frame_rate;
    float yfx_interval;
    float yfx_delta_time;
    float yfx_duration;
    float yfx_begin;
    float yfx_change;
    int yfx_frame;
    int yfx_curent_frame;
    BOOL yfx_is_pause;
    BOOL yfx_is_stop;
    YFXActionAnimation yfx_action;
    YFXActionAnimationComplete yfx_handler;
}
@property(nonatomic,weak) id yfx_target;
@property(nonatomic,assign) YFXAnimationFunction yfx_function;

-(instancetype) initWithTarget:(id) target;

-(void) doAnimationWithBegin:(float) beginValue
                     withEnd:(float) endValue
                withDuration:(float) duration
                    withType:(YFXEaseType) type
                  withAction:(YFXActionAnimation) action
                 withHandler:(YFXActionAnimationComplete) handler;

-(void) setAnimationType:(YFXEaseType) type;
-(void) startAnimation;
-(void) stopAnimation;
-(void) pauseAnimation;
-(void) resumAnimation;

#pragma mark - Static Function
+(NSString*) animationNameByType:(YFXEaseType) type;

+(float) Random;

+(float) YFXLinearEaseWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period;

+(float) YFXEaseInQuadWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period;

+(float) YFXEaseOutQuadWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period;

+(float) YFXEaseInOutQuadWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period;

+(float) YFXEaseInCubicWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutCubicWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutCubicWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInQuartWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXeaseOutQuartWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutQuartWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInQuintWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutQuintWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutQuintWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInSineWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutSineWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutSineWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInExpoWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutExpoWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutExpoWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInCircWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutCircWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutCircWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInElasticWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutElasticWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutElasticWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInBackWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutBackWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutBackWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInBounceWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseOutBounceWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

+(float) YFXEaseInOutBounceWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period;

@end
