//
//  YFXSnow.m
//  Pods-VisualizationFX_Example
//
//  Created by Le Viet Quang on 1/7/18.
//

#import "YFXSnow.h"
#import "Utils.h"

@implementation YFXSnowParticle

@synthesize x = _x;
@synthesize y = _y;
@synthesize r = _r;
@synthesize d = _d;

-(instancetype) initWithX:(float)in_x withY:(float)in_y withR:(float)in_r withD:(float)in_d
{
    self = [super init];
    if(self)
    {
        _x = in_x; _y = in_y; _r = in_r; _d = in_d;
    }
    return self;
}

-(void) refreshWithX:(float) in_x withY:(float) in_y withR:(float) in_r withD:(float) in_d
{
    _x = in_x; _y = in_y; _r = in_r; _d = in_d;
}

@end

@implementation YFXSnow

@synthesize particle_arr        = _particle_arr;

-(instancetype) initWithFrame:(CGRect)frame andMaxItem:(int) max_items
{
    self = [super initWithFrame:frame];
    if(self)
    {
        width = frame.size.width;
        height = frame.size.height;
        max_item = max_items;
        angle = 0;
        speedAnimation = 0.03;
        draw_rect = CGRectMake(0, 0, width, height);
        snow_color = [UIColor UIColorWithRed:255 green:255 blue:255 alpha:0.4];
        self.backgroundColor = [UIColor clearColor];
        [self createParticle];
    }
    return self;
}

-(void) setSnowItemColor:(UIColor *)color
{
    [self stopAnimation];
    snow_color = nil;
    snow_color = color;
    [self startAnimation];
}

-(void) viewChangeToFrame:(CGRect)frame
{
    [self stopAnimation];
    self.frame = frame;
    width = frame.size.width;
    height = frame.size.height;
    draw_rect = CGRectMake(0, 0, width, height);
    [self refreshParticle];
    [self startAnimation];
}

-(void) startAnimation
{
    is_animation = YES;
    [NSTimer scheduledTimerWithTimeInterval:speedAnimation
                                     target:self
                                   selector:@selector(drawView)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) stopAnimation
{
    is_animation = NO;
}

-(void) setSpeed:(float) speed
{
    [self stopAnimation];
    speedAnimation = speed;
    [self startAnimation];
}

#pragma mark - Private Function
-(float) randomNum
{
    return [YFX Random];
}

-(void) createParticle
{
    _particle_arr = [[NSMutableArray alloc] init];
    for (int i=0; i <= max_item; i++)
    {
        YFXSnowParticle* item = [[YFXSnowParticle alloc] initWithX:[self randomNum]*width withY:[self randomNum]*height withR:([self randomNum]*4+1) withD:[self randomNum]*max_item];
        [_particle_arr addObject:item];
    }
}

-(void) refreshParticle
{
    for (int i=0; i <= max_item; i++) {
        YFXSnowParticle* part = (YFXSnowParticle*) [_particle_arr objectAtIndex:i];
        [part refreshWithX:[self randomNum]*width withY:[self randomNum]*height withR:([self randomNum]*4+1) withD:[self randomNum]*max_item];
    }
}

-(void) updateView
{
    angle += 0.01;
    for (int i=0; i <= max_item; i++) {
        YFXSnowParticle* part = (YFXSnowParticle*) [_particle_arr objectAtIndex:i];
        
        part.y += cos(angle+part.d) + 1 + part.r/2;
        part.x += sin(angle) * 2;
        
        if(part.x > width+5 || part.x < -5 || part.y > height)
        {
            if(i%3 > 0) //66.67% of the flakes
            {
                part.x = [self randomNum]*width;
                part.y = -10;
            }
            else
            {
                //If the flake is exitting from the right
                if(sin(angle) > 0)
                {
                    //Enter from the left
                    part.x = -5;
                    part.y = [self randomNum]*height;
                }
                else
                {
                    //Enter from the right
                    part.x = width + 5;
                    part.y = [self randomNum]*height;
                }
            }
        }
    }
}

-(void) drawView
{
    if(is_animation == NO) return;
    
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx,[UIColor clearColor].CGColor);
    CGContextClearRect(ctx,draw_rect);
    CGContextSetBlendMode(ctx,kCGBlendModeNormal);
    
    CGContextSetFillColorWithColor(ctx,snow_color.CGColor);
    
    for (int i=0; i <= max_item; i++)
    {
        CGContextBeginPath(ctx);
        YFXSnowParticle* part = (YFXSnowParticle*) [_particle_arr objectAtIndex:i];
        CGContextAddArc(ctx,part.x, part.y, part.r, 0, 2*M_PI, 1);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
    
    [self updateView];
}

@end
