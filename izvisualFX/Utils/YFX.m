//
//  YFX.m
//  Pods-VisualizationFX_Example
//
//  Created by Le Viet Quang on 1/7/18.
//

#import "YFX.h"

@implementation YFX

@synthesize yfx_target      = _yfx_target;
@synthesize yfx_function    = _yfx_function;

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
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period) {
                return [YFX YFXLinearEaseWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
            break;
        case YFXEaseInQuad:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period) {
                return [YFX YFXEaseInQuadWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
            break;
        case YFXEaseOutQuad:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period) {
                return [YFX YFXEaseOutQuadWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
            break;
        case YFXEaseInOutQuad:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutQuadWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInCubic:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInCubicWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutCubic:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutCubicWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutCubic:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutCubicWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInQuart:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInQuartWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXeaseOutQuart:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXeaseOutQuartWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutQuart:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutQuartWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInQuint:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInQuintWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutQuint:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutQuintWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutQuint:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutQuintWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInSine:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInSineWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutSine:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutSineWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutSine:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutSineWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInExpo:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInExpoWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutExpo:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutExpoWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutExpo:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutExpoWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInCirc:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInCircWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutCirc:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutCircWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutCirc:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutCircWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInElastic:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInElasticWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutElastic:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutElasticWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutElastic:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutElasticWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInBack:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInBackWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutBack:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutBackWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutBack:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutBackWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInBounce:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInBounceWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseOutBounce:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseOutBounceWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
            };
        case YFXEaseInOutBounce:
            _yfx_function = ^float(float frame, float begin, float change, float duration, float amplitude, float period){
                return [YFX YFXEaseInOutBounceWithFrame:frame withBegin:begin withChange:change withDuration:duration withAmplitude:amplitude withPeriod:period];
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
            float value = _yfx_function(yfx_curent_frame*yfx_delta_time, yfx_begin, yfx_change, yfx_duration, yfx_amplitude, yfx_period);
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
                    float value = _yfx_function(yfx_curent_frame*yfx_delta_time, yfx_begin, yfx_change, yfx_duration, yfx_amplitude, yfx_period);
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
    return -change*cos((frame/duration)*M_PI/2) + change + begin;
}

+(float) YFXEaseOutSineWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    return change*sin((frame/duration)*M_PI/2) + begin;
}

+(float) YFXEaseInOutSineWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    return (-change/2)*(cos(M_PI*frame/duration)-1) + begin;
}

+(float) YFXEaseInExpoWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    if (frame == 0) return begin;
    else {
        return change*(pow(2, 10*frame/duration)-1) + begin;
    }
}

+(float) YFXEaseOutExpoWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    if (frame == duration) return begin+change;
    else return change*(-pow(2, -10*frame/duration)+1) + begin;
}

+(float) YFXEaseInOutExpoWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    if(frame == 0) return begin;
    if(frame == duration) return begin+change;
    frame = frame / (duration/2);
    if (frame < 1) return (change/2)*pow(2, 10*(frame-1)) + begin;
    return (change/2)*(pow(2, -10*(frame-1))) + begin;
}

+(float) YFXEaseInCircWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    frame = frame/duration;
    return -change*(sqrt(1-frame*frame)-1) + begin;
}

+(float) YFXEaseOutCircWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    frame = frame/duration-1;
    return change * sqrt(1-frame*frame) + begin;
}

+(float) YFXEaseInOutCircWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    frame = frame/(duration/2);
    if (frame < 1) return (-change/2)*(sqrt(1-frame*frame) -1) + begin;
    frame = frame - 2;
    return (change/2)*(sqrt(1-frame*frame)+1) + begin;
}

+(float) YFXEaseInElasticWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    if (frame == 0) return begin;
    frame = frame/duration;
    float s = 0;
    if(frame == 1) return begin+duration;
    if(period == 0) period = duration*0.3;
    if(amplitude < fabs(change)) {
        amplitude = change;
        s = (period/(M_PI*2))*asin(change/amplitude);
    }
    frame = frame - 1;
    return -(amplitude*pow(2, 10*frame))*sin((frame*duration-s)*(2*M_PI)/period + begin);
}

+(float) YFXEaseOutElasticWithFrame:(float) frame
                          withBegin:(float) begin
                         withChange:(float) change
                       withDuration:(float) duration
                      withAmplitude:(float) amplitude
                         withPeriod:(float) period
{
    if (frame == 0) return begin;
    frame = frame/duration;
    if(frame == 1) return begin+change;
    if(period == 0) period = duration*0.3;
    float s = 0;
    if(amplitude < fabs(change)) {
        amplitude = change;
        s = period/4;
    }else {
        amplitude = fabs(change);
        s = period/(2*M_PI)*asin(change/amplitude);
    }
    return amplitude*pow(2, -10*frame)*sin((frame*duration-s)*(2*M_PI)/period) + change + begin;
}

+(float) YFXEaseInOutElasticWithFrame:(float) frame
                            withBegin:(float) begin
                           withChange:(float) change
                         withDuration:(float) duration
                        withAmplitude:(float) amplitude
                           withPeriod:(float) period
{
    if(frame == 0) return begin;
    frame = frame/(duration/2);
    if(frame == 2) return begin + change;
    if(period == 0) period = duration*0.3*1.5;
    float s = 0;
    if(amplitude < fabs(change)){
        amplitude = change;
        s = period/4;
    }
    else{
        amplitude = fabsf(change);
        s = period/(2*M_PI)*asin(change/amplitude);
    }
    frame = frame - 1;
    if(frame < 1) return -0.5*(amplitude*pow(2, 10*frame)*sin((frame*duration-s)*(2*M_PI)/period))+begin;
    return begin + change + amplitude*pow(2,-10*frame)*sin((frame*duration-2)*(2*M_PI)/period)*0.5;
}

+(float) YFXEaseInBackWithFrame:(float) frame
                      withBegin:(float) begin
                     withChange:(float) change
                   withDuration:(float) duration
                  withAmplitude:(float) amplitude
                     withPeriod:(float) period
{
    float s = 1.70158;
    frame = frame/duration;
    return change*frame*frame*((s+1)*frame - s) + begin;
}

+(float) YFXEaseOutBackWithFrame:(float) frame
                       withBegin:(float) begin
                      withChange:(float) change
                    withDuration:(float) duration
                   withAmplitude:(float) amplitude
                      withPeriod:(float) period
{
    float s = 1.70158;
    frame = frame/duration;
    return change*((frame-1)*frame*((s+1)*frame+s)+1) +begin;
}

+(float) YFXEaseInOutBackWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    float s = 1.70158*1.525;
    frame = frame/(duration/2);
    if(frame < 1) return change/2*(frame*frame*((s+1)*frame - s)) + begin;
    frame = frame - 2;
    return change/2*(frame*frame*((s+1)*frame+s) +2) + begin;
}

+(float) YFXEaseInBounceWithFrame:(float) frame
                        withBegin:(float) begin
                       withChange:(float) change
                     withDuration:(float) duration
                    withAmplitude:(float) amplitude
                       withPeriod:(float) period
{
    return change - [YFX YFXEaseOutBounceWithFrame:duration-frame withBegin:0 withChange:change withDuration:duration withAmplitude:0 withPeriod:0];
}

+(float) YFXEaseOutBounceWithFrame:(float) frame
                         withBegin:(float) begin
                        withChange:(float) change
                      withDuration:(float) duration
                     withAmplitude:(float) amplitude
                        withPeriod:(float) period
{
    frame = frame/duration;
    if(frame < 1/2.75) return 7.5625*change*frame*frame + begin;
    else if(frame < 2/2.75) {
        frame = frame - (1.5/2.75);
        return change*(7.5625*frame*frame + 0.75) + begin;
    }
    else if(frame < 2.5/2.75){
        frame = frame - 2.25/2.75;
        return change*(7.5625*frame*frame + 0.9375) + begin;
    }
    frame = frame - 2.625/2.75;
    return change*(7.5625*frame*frame + 0.984375) + begin;
}

+(float) YFXEaseInOutBounceWithFrame:(float) frame
                           withBegin:(float) begin
                          withChange:(float) change
                        withDuration:(float) duration
                       withAmplitude:(float) amplitude
                          withPeriod:(float) period
{
    if(frame < duration/2) return [YFX YFXEaseInBounceWithFrame:frame*2 withBegin:0 withChange:change withDuration:duration withAmplitude:0 withPeriod:0]*0.5 + begin;
    return [YFX YFXEaseOutBounceWithFrame:frame*2-duration withBegin:0 withChange:change withDuration:duration withAmplitude:0 withPeriod:0]*0.5 + 0.5 + begin;
}

@end
