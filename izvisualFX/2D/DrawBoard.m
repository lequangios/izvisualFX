//
//  DrawBoard.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/13/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "DrawBoard.h"

@implementation DrawBoard

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        blend_mode1 = kCGBlendModeNormal;
        blend_mode2 = kCGBlendModeNormal;
        blend_mode3 = kCGBlendModeNormal;
        curent_blend_mode = kCGBlendModeNormal;
        
        self.backgroundColor = [UIColor clearColor];
//        UILabel* lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, frame.size.width-20, 30)];
//        lb.backgroundColor = [UIColor clearColor];
//        lb.font = [UIFont systemFontOfSize:20];
//        lb.textColor = [UIColor whiteColor];
//        lb.textAlignment = NSTextAlignmentCenter;
//        lb.text = @"Blend Mode in Core Graphic";
//        [self addSubview:lb];
//
        listBlendMode = @[@(kCGBlendModeNormal),@(kCGBlendModeMultiply),@(kCGBlendModeScreen),@(kCGBlendModeOverlay),@(kCGBlendModeDarken),@(kCGBlendModeLighten),@(kCGBlendModeColorDodge),@(kCGBlendModeColorBurn),@(kCGBlendModeSoftLight),@(kCGBlendModeHardLight),@(kCGBlendModeDifference),@(kCGBlendModeExclusion),@(kCGBlendModeHue),@(kCGBlendModeSaturation),@(kCGBlendModeColor),@(kCGBlendModeLuminosity),@(kCGBlendModeClear),@(kCGBlendModeCopy),@(kCGBlendModeSourceIn),@(kCGBlendModeSourceOut),@(kCGBlendModeSourceAtop),@(kCGBlendModeDestinationOver),@(kCGBlendModeDestinationIn),@(kCGBlendModeDestinationOut),@(kCGBlendModeDestinationAtop),@(kCGBlendModeXOR),@(kCGBlendModePlusDarker),@(kCGBlendModePlusLighter)];
        
        draw_button = [[UIButton alloc] initWithFrame:CGRectMake(20, frame.size.height-70, 150, 50)];
        draw_button.backgroundColor = [UIColor blueColor];
        draw_button.layer.cornerRadius = 5;
        [draw_button setTitle:@"Draw" forState:UIControlStateNormal];
        [draw_button setTitle:@"Drawing" forState:UIControlStateHighlighted];
        [draw_button setTintColor:[UIColor greenColor]];
        [draw_button addTarget:self action:@selector(drawShape:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:draw_button];
        
        [self setupBlendModeSelectUI];
    }
    return  self;
}

#pragma mark - Setup For UI
-(void) setupBlendModeSelectUI
{
    option1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    option1.backgroundColor = [UIColor redColor];
    option1.tag = 1;
    [option1 setTitle:@"kCGBlendModeNormal" forState:UIControlStateNormal];
    [self addSubview:option1];
    [option1 addTarget:self action:@selector(tapSelectBlendMode:) forControlEvents:UIControlEventTouchUpInside];
    
    option2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
    option2.backgroundColor = [UIColor yellowColor];
    option2.tag = 2;
    [option2 setTitle:@"kCGBlendModeNormal" forState:UIControlStateNormal];
    [option2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:option2];
    [option2 addTarget:self action:@selector(tapSelectBlendMode:) forControlEvents:UIControlEventTouchUpInside];
    
    option3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 170, 300, 40)];
    option3.backgroundColor = [UIColor blueColor];
    option3.tag = 3;
    [option3 setTitle:@"kCGBlendModeNormal" forState:UIControlStateNormal];
    [self addSubview:option3];
    [option3 addTarget:self action:@selector(tapSelectBlendMode:) forControlEvents:UIControlEventTouchUpInside];
    
    pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 100)];
    pick.backgroundColor = [UIColor blueColor];
    pick.delegate = self;
    [self addSubview:pick];
}

-(void) tapSelectBlendMode:(id) sender
{
    current_btn = (UIButton*) sender;
    [UIView animateWithDuration:0.5 animations:^{
        pick.frame = CGRectMake(0, self.frame.size.height-100, self.frame.size.width, 100);
    }];
}

#pragma mark - Setup For PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return listBlendMode.count;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    UIColor* color = [UIColor whiteColor];
    curent_blend_mode = (int32_t)row;
    NSString* title = [NSString stringWithFormat:@"%@",[self getStringFromBlendMode:curent_blend_mode]];
    NSAttributedString* att = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],
                                                                                            NSForegroundColorAttributeName: color}];
    return att;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString* title = [NSString stringWithFormat:@"%@",[self getStringFromBlendMode:curent_blend_mode]];
    if (current_btn.tag == 1)
    {
        blend_mode1 = curent_blend_mode;
        [option1 setTitle:title forState:UIControlStateNormal];
    }
    else if (current_btn.tag == 2)
    {
        blend_mode2 = curent_blend_mode;
        [option2 setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        blend_mode3 = curent_blend_mode;
        [option3 setTitle:title forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        pick.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 100);
    }];
    [pick reloadAllComponents];
}

#pragma mark - Setup For CGBlendMode

-(void) drawShape:(id) sender
{
    [self setNeedsDisplay];
}

-(NSString*) getStringFromBlendMode:(CGBlendMode) blend_mode
{
    NSString* blend_mode_str = @"kCGBlendModeNormal";
    
    switch (blend_mode) {
        case kCGBlendModeNormal:
            blend_mode_str = @"kCGBlendModeNormal";
            break;
        case kCGBlendModeMultiply:
            blend_mode_str = @"kCGBlendModeMultiply";
            break;
        case kCGBlendModeScreen:
            blend_mode_str = @"kCGBlendModeScreen";
            break;
        case kCGBlendModeOverlay:
            blend_mode_str = @"kCGBlendModeOverlay";
            break;
        case kCGBlendModeDarken:
            blend_mode_str = @"kCGBlendModeDarken";
            break;
        case kCGBlendModeLighten:
            blend_mode_str = @"kCGBlendModeLighten";
            break;
        case kCGBlendModeColorDodge:
            blend_mode_str = @"kCGBlendModeColorDodge";
            break;
        case kCGBlendModeColorBurn:
            blend_mode_str = @"kCGBlendModeColorBurn";
            break;
        case kCGBlendModeSoftLight:
            blend_mode_str = @"kCGBlendModeSoftLight";
            break;
        case kCGBlendModeHardLight:
            blend_mode_str = @"kCGBlendModeHardLight";
            break;
        case kCGBlendModeDifference:
            blend_mode_str = @"kCGBlendModeDifference";
            break;
        case kCGBlendModeExclusion:
            blend_mode_str = @"kCGBlendModeExclusion";
            break;
        case kCGBlendModeHue:
            blend_mode_str = @"kCGBlendModeHue";
            break;
        case kCGBlendModeSaturation:
            blend_mode_str = @"kCGBlendModeSaturation";
            break;
        case kCGBlendModeColor:
            blend_mode_str = @"kCGBlendModeColor";
            break;
        case kCGBlendModeLuminosity:
            blend_mode_str = @"kCGBlendModeLuminosity";
            break;
        case kCGBlendModeClear:
            blend_mode_str = @"kCGBlendModeClear";
            break;
        case kCGBlendModeCopy:
            blend_mode_str = @"kCGBlendModeCopy";
            break;
        case kCGBlendModeSourceIn:
            blend_mode_str = @"kCGBlendModeSourceIn";
            break;
        case kCGBlendModeSourceOut:
            blend_mode_str = @"kCGBlendModeSourceOut";
            break;
        case kCGBlendModeSourceAtop:
            blend_mode_str = @"kCGBlendModeSourceAtop";
            break;
        case kCGBlendModeDestinationOver:
            blend_mode_str = @"kCGBlendModeDestinationOver";
            break;
        case kCGBlendModeDestinationIn:
            blend_mode_str = @"kCGBlendModeDestinationIn";
            break;
        case kCGBlendModeDestinationOut:
            blend_mode_str = @"kCGBlendModeDestinationOut";
            break;
        case kCGBlendModeDestinationAtop:
            blend_mode_str = @"kCGBlendModeDestinationAtop";
            break;
        case kCGBlendModeXOR:
            blend_mode_str = @"kCGBlendModeXOR";
            break;
        case kCGBlendModePlusDarker:
            blend_mode_str = @"kCGBlendModePlusDarker";
            break;
        case kCGBlendModePlusLighter:
            blend_mode_str = @"kCGBlendModePlusLighter";
            break;
        default:
            break;
    }
    return blend_mode_str;
}

-(void) DrawBoardWithBlendMode:(CGBlendMode) blend_mode
{
    [self checkDrawBoardWithBlendMode:kCGBlendModeNormal :blend_mode :kCGBlendModeNormal];
}

-(void) checkDrawBoardWithBlendMode:(CGBlendMode) blend_mode1 :(CGBlendMode) blend_mode2 : (CGBlendMode) blend_mode3
{
    CGRect rect = self.frame;
    
    float x = 80;
    float y = 230;
    float radius = 70;
    float margin = 40;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx,[UIColor clearColor].CGColor);
    CGContextClearRect(ctx,rect);
    
    // First Arc
    CGContextSaveGState(ctx);
    CGContextSetBlendMode(ctx,blend_mode1);
    CGContextSetFillColorWithColor(ctx,[UIColor redColor].CGColor);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, x, y+radius, radius, 0, 2*M_PI, 1);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    
    // Text 1
    CGContextSaveGState(ctx);
    NSString *str= [NSString stringWithFormat:@"----> %@",[self getStringFromBlendMode:blend_mode1]] ;
    CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
    [str drawAtPoint:CGPointMake(x + radius + 10 , y+radius) withAttributes:@{
                                                                              NSForegroundColorAttributeName: [UIColor whiteColor]}];
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    
    // Second Arc
    y += (radius + margin);
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx,[UIColor yellowColor].CGColor);
    CGContextSetBlendMode(ctx,blend_mode2);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, x, y+radius, radius, 0, 2*M_PI, 1);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    
    // Text 2
    CGContextSaveGState(ctx);
    str= [NSString stringWithFormat:@"----> %@",[self getStringFromBlendMode:blend_mode2]] ;
    CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
    [str drawAtPoint:CGPointMake(x + radius + 10 , y+radius) withAttributes:@{
                                                                              NSForegroundColorAttributeName: [UIColor whiteColor]}];
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    
    // Third Arc
    y += (radius + margin);
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx,[UIColor blueColor].CGColor);
    CGContextSetBlendMode(ctx,blend_mode3);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, x, y+radius, radius, 0, 2*M_PI, 1);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    
    // Text 3
    CGContextSaveGState(ctx);
    str= [NSString stringWithFormat:@"----> %@",[self getStringFromBlendMode:blend_mode3]] ;
    CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
    [str drawAtPoint:CGPointMake(x + radius + 10 , y+radius) withAttributes:@{
                                                                              NSForegroundColorAttributeName: [UIColor whiteColor]}];
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
}

- (void)drawRect:(CGRect)rect
{
    [self checkDrawBoardWithBlendMode:blend_mode1 :blend_mode2 :blend_mode3];
}


@end
