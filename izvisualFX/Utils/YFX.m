//
//  YFX.m
//  Pods-VisualizationFX_Example
//
//  Created by Le Viet Quang on 1/7/18.
//

#import "YFX.h"

@implementation YFX

@synthesize yfx_target = _yfx_target;

-(instancetype) initWithTarget:(id) target
{
    self = [super init];
    if (self)
    {
        _yfx_target = target;
        frame_rate = 30;
        yfx_amplitude = 0;
        yfx_curent_frame = 0;
        yfx_period = 0;
        yfx_is_stop = NO;
        yfx_is_pause = NO;
    }
    return self;
}

-(void) doAnimationWithBegin:(float) beginValue
                     withEnd:(float) endValue
                withDuration:(float) duration
                    withType:(YFXEaseType) type
                  withAction:(YFXActionAnimation) action
                 withHandler:(YFXActionAnimationComplete) handler
{
    yfx_action = action;
    yfx_handler = handler;
    yfx_duration = duration;
    yfx_begin = beginValue;
    yfx_change = endValue - beginValue;
    yfx_interval = 1000/frame_rate;
    yfx_duration = yfx_duration*1000;
    yfx_delta_time = yfx_interval;
    yfx_frame = (int) yfx_duration/yfx_interval;
    yfx_interval = yfx_interval/1000;
    [self setAnimationFunctionWithType:type];
}

-(void) setAnimationType:(YFXEaseType) type
{
    [self setAnimationFunctionWithType:type];
}

-(void) setAnimationFunctionWithType:(YFXEaseType) type
{
    switch (type) {
        case YFXLinearEase:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period) {
                return [YFX YFXLinearEaseWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
            break;
        case YFXEaseInQuad:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period) {
                return [YFX YFXEaseInQuadWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
            break;
        case YFXEaseOutQuad:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period) {
                return [YFX YFXEaseOutQuadWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
            break;
        case YFXEaseInOutQuad:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInCubic:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutCubic:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutCubic:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInQuart:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXeaseOutQuart:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutQuart:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInQuint:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutQuint:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutQuint:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInSine:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutSine:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutSine:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInExpo:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutExpo:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutExpo:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInCirc:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutCirc:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutCirc:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInElastic:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutElastic:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutElastic:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInBack:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutBack:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutBack:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInBounce:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseOutBounce:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        case YFXEaseInOutBounce:
            yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return 0;
            };
        default:
            break;
    }
}

-(void) animation
{
    if (_yfx_target != nil)
    {
        if (yfx_is_pause == YES)
        {
            float value = yfx_function(yfx_curent_frame*yfx_delta_time, yfx_begin, yfx_change, yfx_duration, yfx_amplitude, yfx_period);
            yfx_action(_yfx_target,value);
            yfx_handler(_yfx_target,false);
        }
        else
        {
            if(yfx_is_stop == YES)
            {
                yfx_action(_yfx_target,yfx_begin);
                yfx_curent_frame = 0;
                yfx_handler(_yfx_target,true);
            }
            else
            {
                if(yfx_curent_frame < yfx_frame)
                {
                    float value = yfx_function(yfx_curent_frame*yfx_delta_time, yfx_begin, yfx_change, yfx_duration, yfx_amplitude, yfx_period);
                    yfx_action(_yfx_target,value);
                    [self performSelector:@selector(animation) withObject:nil afterDelay:yfx_interval];
                    yfx_curent_frame = yfx_curent_frame + 1;
                }
                else {
                    yfx_action(_yfx_target,yfx_change+yfx_begin);
                    yfx_handler(_yfx_target,true);
                    yfx_curent_frame = 0;
                }
            }
        }
    }
}

-(void) startAnimation
{
    if(yfx_is_pause != YES || yfx_is_stop != YES)
    {
        [self animation];
    }
}

-(void) stopAnimation
{
    yfx_is_stop = YES;
}

-(void) pauseAnimation
{
    yfx_is_pause = YES;
}

-(void) resumAnimation
{
    yfx_is_pause = NO;
    [self animation];
}

#pragma mark - Static Function
+(NSString*) animationNameByType:(YFXEaseType) type
{
    NSString* name = @"YFXLinearEase";
    switch (type) {
        case YFXLinearEase:
            name = @"YFXLinearEase";
            break;
        case YFXEaseInQuad:
            name = @"YFXEaseInQuad";
            break;
        case YFXEaseOutQuad:
            name = @"YFXEaseOutQuad";
            break;
        case YFXEaseInOutQuad:
            name = @"YFXEaseInOutQuad";
            break;
        case YFXEaseInCubic:
            name = @"YFXEaseInCubic";
            break;
        case YFXEaseOutCubic:
            name = @"YFXEaseOutCubic";
            break;
        case YFXEaseInOutCubic:
            name = @"YFXEaseInOutCubic";
            break;
        case YFXEaseInQuart:
            name = @"YFXEaseInQuart";
            break;
        case YFXeaseOutQuart:
            name = @"YFXeaseOutQuart";
            break;
        case YFXEaseInOutQuart:
            name = @"YFXEaseInOutQuart";
            break;
        case YFXEaseInQuint:
            name = @"YFXEaseInQuint";
            break;
        case YFXEaseOutQuint:
            name = @"YFXEaseOutQuint";
            break;
        case YFXEaseInOutQuint:
            name = @"YFXEaseInOutQuint";
            break;
        case YFXEaseInSine:
            name = @"YFXEaseInSine";
            break;
        case YFXEaseOutSine:
            name = @"YFXEaseOutSine";
            break;
        case YFXEaseInOutSine:
            name = @"YFXEaseInOutSine";
            break;
        case YFXEaseInExpo:
            name = @"YFXEaseInExpo";
            break;
        case YFXEaseOutExpo:
            name = @"YFXEaseOutExpo";
            break;
        case YFXEaseInOutExpo:
            name = @"YFXEaseInOutExpo";
            break;
        case YFXEaseInCirc:
            name = @"YFXEaseInCirc";
            break;
        case YFXEaseOutCirc:
            name = @"YFXEaseOutCirc";
            break;
        case YFXEaseInOutCirc:
            name = @"YFXLinearEase";
            break;
        case YFXEaseInElastic:
            name = @"YFXEaseInElastic";
            break;
        case YFXEaseOutElastic:
            name = @"YFXEaseOutElastic";
            break;
        case YFXEaseInOutElastic:
            name = @"YFXEaseInOutElastic";
            break;
        case YFXEaseInBack:
            name = @"YFXEaseInBack";
            break;
        case YFXEaseOutBack:
            name = @"YFXEaseOutBack";
            break;
        case YFXEaseInOutBack:
            name = @"YFXEaseInOutBack";
            break;
        case YFXEaseInBounce:
            name = @"YFXEaseInBounce";
            break;
        case YFXEaseOutBounce:
            name = @"YFXEaseOutBounce";
            break;
        case YFXEaseInOutBounce:
            name = @"YFXEaseInOutBounce";
            break;
        default:
            break;
    }
    return name;
}

+(float) Random
{
    return (float)rand() / RAND_MAX;
}

+(float) YFXLinearEaseWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    return change*(frame/duration)+begin;
}

+(float) YFXEaseInQuadWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    frame = frame/duration;
    return change*frame*frame + begin;
}

+(float) YFXEaseOutQuadWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    frame = frame/duration;
    return -change*frame*(frame-2) + begin;
}

+(float) YFXEaseInOutQuadWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    float value = 0;
    frame = 2*frame/duration;
    if (frame < 1) {
        value = (change/2*frame*frame + begin);
        return value;
    }
    frame = frame - 1;
    value = (-change/2 * (frame*(frame-2) - 1) + begin);
    return value;
}

+(float) YFXEaseInCubicWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    frame = frame/duration;
    return change*frame*frame*frame + begin;
}

+(float) YFXEaseOutCubicWithFrame:(float) frame
                        withBegin:(float) begin
                       withChange:(float) change
                     withDuration:(float) duration
                    withAmplitude:(float) amplitude
                       withPeriod:(float) period
{
    frame=frame/duration-1;
    return change*(frame*frame*frame + 1) + begin;
}

+(float) YFXEaseInOutCubicWithFrame:(float) frame
                          withBegin:(float) begin
                         withChange:(float) change
                       withDuration:(float) duration
                      withAmplitude:(float) amplitude
                         withPeriod:(float) period
{
    frame = 2*frame/duration;
    if (frame < 1) return change/2*frame*frame*frame + begin;
    frame = frame - 2;
    return change/2*(frame*frame*frame + 2) + begin;
}

+(float) YFXEaseInQuartWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    frame = frame/duration;
    return change*frame*frame*frame*frame + begin;
}

+(float) YFXeaseOutQuartWithFrame:(float) frame
                        withBegin:(float) begin
                       withChange:(float) change
                     withDuration:(float) duration
                    withAmplitude:(float) amplitude
                       withPeriod:(float) period
{
    frame = frame/(duration-1);
    return -change * (frame*frame*frame*frame - 1) + begin;
}

+(float) YFXEaseInOutQuartWithFrame:(float) frame
                          withBegin:(float) begin
                         withChange:(float) change
                       withDuration:(float) duration
                      withAmplitude:(float) amplitude
                         withPeriod:(float) period
{
    frame = 2*frame/duration;
    if (frame < 1) return change/2*frame*frame*frame*frame + begin;
    frame = frame - 2;
    return -change/2 * (frame*frame*frame*frame - 2) + begin;
}

+(float) YFXEaseInQuintWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    frame = frame/duration;
    return change*frame*frame*frame*frame*frame + begin;
}

+(float) YFXEaseOutQuintWithFrame:(float) frame
                        withBegin:(float) begin
                       withChange:(float) change
                     withDuration:(float) duration
                    withAmplitude:(float) amplitude
                       withPeriod:(float) period
{
    frame = frame/(duration-1);
    return change*(frame*frame*frame*frame*frame + 1) + begin;
}

+(float) YFXEaseInOutQuintWithFrame:(float) frame
                          withBegin:(float) begin
                         withChange:(float) change
                       withDuration:(float) duration
                      withAmplitude:(float) amplitude
                         withPeriod:(float) period
{
    frame = 2*frame/duration;
    if (frame < 1) return change/2*frame*frame*frame*frame*frame + begin;
    frame = frame - 2;
    return change/2*(frame*frame*frame*frame*frame + 2) + begin;
}

+(float) YFXEaseInSineWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    return 0;
//    return -change * cos(frame/duration * (Math.PI/2)) + change + begin;
}

+(float) YFXEaseOutSineWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInOutSineWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInExpoWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseOutExpoWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInOutExpoWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInCircWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseOutCircWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInOutCircWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInElasticWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseOutElasticWithFrame:(float) frame
                          withBegin:(float) begin
                         withChange:(float) change
                       withDuration:(float) duration
                      withAmplitude:(float) amplitude
                         withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInOutElasticWithFrame:(float) frame
                            withBegin:(float) begin
                           withChange:(float) change
                         withDuration:(float) duration
                        withAmplitude:(float) amplitude
                           withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInBackWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseOutBackWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInOutBackWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInBounceWithFrame:(float) frame
                        withBegin:(float) begin
                       withChange:(float) change
                     withDuration:(float) duration
                    withAmplitude:(float) amplitude
                       withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseOutBounceWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return 0;
}

+(float) YFXEaseInOutBounceWithFrame:(float) frame
                           withBegin:(float) begin
                          withChange:(float) change
                        withDuration:(float) duration
                       withAmplitude:(float) amplitude
                          withPeriod:(float) period
{
    return 0;
}
@end
