//
//  UIColor+FX.m
//  VisualizationFX
//
//  Created by Le Viet Quang on 1/6/18.
//

#import "UIColor+FX.h"

@implementation UIColor (FX)

+(instancetype) UIColorFromHexValue:(NSString*) hexValue
{
    if(hexValue == nil || [hexValue isEqualToString:@""]) return [UIColor clearColor];
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexValue];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

+(instancetype) UIColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:alpha];
}

+(instancetype) UIColorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
    //    if(hue>360) hue = 360;
    return [UIColor colorWithRed:hue/360.0f green:saturation blue:lightness alpha:alpha];
}

@end
