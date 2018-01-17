//
//  UIColor+FX.h
//  VisualizationFX
//
//  Created by Le Viet Quang on 1/6/18.
//

#import <UIKit/UIKit.h>
@interface UIColor (FX)

+(instancetype) UIColorFromHexValue:(NSString*) hexValue;

+(instancetype) UIColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+(instancetype) UIColorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

@end
