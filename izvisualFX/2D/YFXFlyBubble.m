//
//  FlyBubble.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/14/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "YFXFlyBubble.h"
#import "Utils.h"

#pragma mark -
#pragma mark - Setup For YFXFlyBubbleParticle

@implementation YFXFlyBubbleParticle

@synthesize f = _f;
@synthesize x = _x;
@synthesize y = _y;
@synthesize r = _r;
@synthesize a = _a;
@synthesize v = _v;

-(instancetype) initWithWidth:(float) width andHeight:(float) height andStartColor:(UIColor*) start andEndColor:(UIColor*) end
{
    self = [super init];
    if(self)
    {
        _x = [YFX Random]*width;
        _y = [YFX Random]*height;
        _r = 4+([YFX Random]*width/25);
        _a = [YFX Random]*M_2_PI;
        _v = 10*[YFX Random];
        [self makeGadientWithStartColor:[CIColor colorWithCGColor:start.CGColor] andEndcolor:[CIColor colorWithCGColor:end.CGColor]];
    }
    return self;
}

-(void) resetWithWidth:(float) width andHeight:(float) height andStartColor:(UIColor*) start andEndColor:(UIColor*) end
{
    _x = [YFX Random]*width;
    _y = [YFX Random]*height;
    _r = 4+([YFX Random]*width/25);
    _a = [YFX Random]*M_2_PI;
    _v = 10*[YFX Random];
    [self makeGadientWithStartColor:[CIColor colorWithCGColor:start.CGColor] andEndcolor:[CIColor colorWithCGColor:end.CGColor]];
}

-(void) makeGadientWithStartColor:(CIColor*) start andEndcolor:(CIColor*) end
{
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    
    CGFloat components[8] = { start.red, start.green, start.blue, [YFX Random],
        end.red, end.green, end.blue, [YFX Random] };
    
    if (@available(iOS 9.0, *)) {
        myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
    } else {
        myColorspace = CGColorSpaceCreateDeviceRGB();
    }
    
    _f = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations);
    
    CGColorSpaceRelease(myColorspace);
}

@end

#pragma mark - 
#pragma mark - Setup For YFXFlyBubble

@implementation YFXFlyBubble

@synthesize bubble_particles = _bubble_particles;

#pragma mark - Public Function

-(instancetype) initWithFrame:(CGRect)frame andMaxItem:(int) max_items
{
    self = [super initWithFrame:frame];
    if(self)
    {
        start_color = [UIColor blueColor];
        end_color = [UIColor purpleColor];
        max_item = max_items;
        interval = 0.03;
        is_animation = NO;
        self.frame = frame;
        width = frame.size.width;
        height = frame.size.height;
        draw_rect = CGRectMake(0, 0, width, height);
        self.backgroundColor = [UIColor clearColor];
        _bubble_particles = [[NSMutableArray alloc] init];
        [self createFlyBubbleParticles];
    }
    return self;
}

-(void) startAnimation
{
    is_animation = YES;
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:self
                                   selector:@selector(FlyBubble)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) stopAnimation
{
    is_animation = NO;
}

-(void) viewChangeToFrame:(CGRect) frame
{
    [self stopAnimation];
    self.frame = frame;
    width = frame.size.width;
    height = frame.size.height;
    draw_rect = CGRectMake(0, 0, width, height);
    [self refreshFlyBubbleParticles];
    [self startAnimation];
}

-(void) setSpeed:(float) speed
{
    [self stopAnimation];
    interval = speed;
    [self startAnimation];
}

-(void) setBeginColor:(UIColor*) beg andEndColor:(UIColor*) end
{
    [self stopAnimation];
    start_color = beg;
    end_color = end;
    [self refreshFlyBubbleParticles];
    [self startAnimation];
}

#pragma mark - Private Function
-(float) randomNum
{
    return [YFX Random];
}

-(void) createFlyBubbleParticles
{
    for (int i=0; i<= max_item; i++)
    {
        YFXFlyBubbleParticle* bubble_item = [[YFXFlyBubbleParticle alloc] initWithWidth:width andHeight:height andStartColor:start_color andEndColor:end_color];
        [_bubble_particles addObject:bubble_item];
    }
}

-(void) refreshFlyBubbleParticles
{
    for (int i=0; i<= max_item; i++)
    {
        YFXFlyBubbleParticle* bubble_item = (YFXFlyBubbleParticle*)[_bubble_particles objectAtIndex:i];
        [bubble_item resetWithWidth:width andHeight:height andStartColor:start_color andEndColor:end_color];
    }
}

-(void) updateFlyBubbleParticles
{
    for (int i =0; i <= max_item; i++)
    {
        YFXFlyBubbleParticle* bubble_item = (YFXFlyBubbleParticle*) [_bubble_particles objectAtIndex:i];
        bubble_item.x += sin(bubble_item.a)*bubble_item.v;
        bubble_item.y += cos(bubble_item.a)*bubble_item.v;
        if(bubble_item.x - bubble_item.r > width) bubble_item.x = -bubble_item.r;
        if(bubble_item.x + bubble_item.r < 0) bubble_item.x = width + bubble_item.r;
        if(bubble_item.y - bubble_item.r > height) bubble_item.y = -bubble_item.r;
        if(bubble_item.y + bubble_item.r < 0) bubble_item.y = height + bubble_item.r;
    }
}

-(void) FlyBubble
{
    if(is_animation == NO) return;
    [self setNeedsDisplay];
}

- (UIBezierPath *) createArcPathWithItem:(YFXFlyBubbleParticle*) item
{
    UIBezierPath *aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(item.x, item.y)
                                                         radius:item.r
                                                     startAngle:0
                                                       endAngle:2*M_PI
                                                      clockwise:YES];
    return aPath;
}

-(void) drawFlyBubbleWithItem:(YFXFlyBubbleParticle*) bubble_item andContext:(CGContextRef) ctx
{
    UIBezierPath* path = [self createArcPathWithItem:bubble_item];
    CGContextSaveGState(ctx);
    path.lineWidth = 1;
    [path closePath];
    [path addClip];
    CGContextDrawLinearGradient(ctx, bubble_item.f, CGPointMake(bubble_item.x-bubble_item.r, bubble_item.y-bubble_item.r), CGPointMake(bubble_item.x+bubble_item.r, bubble_item.y + bubble_item.r), kCGGradientDrawsAfterEndLocation);
    [path stroke];
    CGContextRestoreGState(ctx);
    [path removeAllPoints];
    path = nil;
}

-(void) drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx,[UIColor clearColor].CGColor);
    CGContextClearRect(ctx,draw_rect);
    CGContextSetBlendMode(ctx,kCGBlendModeDestinationOver);
    [end_color setStroke];
    for (int i=0; i <= max_item; i++)
    {
        YFXFlyBubbleParticle* bubble_item = (YFXFlyBubbleParticle*) [_bubble_particles objectAtIndex:i];
        [self drawFlyBubbleWithItem:bubble_item andContext:ctx];
    }
    
    [self updateFlyBubbleParticles];
}

@end
