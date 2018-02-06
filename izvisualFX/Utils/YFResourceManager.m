//
//  YFResourceManager.m
//  izvisualFX
//
//  Created by Le Viet Quang on 2/5/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "YFResourceManager.h"

#define yfx_Ipad_Landcapse                          CGSizeMake(1024, 768)
#define yfx_Ipad_Landcapse_With_StatusBar           CGSizeMake(1024, 748)
#define yfx_Ipad_Portrait                           CGSizeMake(768, 1024)
#define yfx_Ipad_Portrait_With_StatusBar            CGSizeMake(768, 1004)
#define yfx_Iphone_4inch_Portrait                   CGSizeMake(320, 568)
#define yfx_Iphone_47inch_Portrait                  CGSizeMake(375, 667)
#define yfx_Iphone_55inch_Portrait                  CGSizeMake(414, 736)
#define yfx_Iphone_55inch_Landcapse                 CGSizeMake(736, 414)
#define yfx_Iphone_X_Portrait                       CGSizeMake(375, 812)
#define yfx_Iphone_X_Landcapse                      CGSizeMake(812, 375)

#define yfx_Src                                         @"img/"
#define yfx_Ipad_Landcapse_Src                          @"img/ipadland/"
#define yfx_Ipad_Landcapse_With_StatusBar_Src           @"img/ipadland/"
#define yfx_Ipad_Portrait_Src                           @"img/ipadport/"
#define yfx_Ipad_Portrait_With_StatusBar_Src            @"img/ipadport/"
#define yfx_Iphone_4inch_Portrait_Src                   @"img/4inch/"
#define yfx_Iphone_47inch_Portrait_Src                  @"img/47inch/"
#define yfx_Iphone_55inch_Portrait_Src                  @"img/55inchport/"
#define yfx_Iphone_55inch_Landcapse_Src                 @"img/55inchland/"
#define yfx_Iphone_X_Portrait_Src                       @"img/xport/"
#define yfx_Iphone_X_Landcapse_Src                      @"img/xland/"

@implementation YFResourceManager

+(CGSize) getPointSizeTransformWithSize:(CGSize) size
{
    return CGSizeMake(size.height, size.width);
}

+(CGSize) getPointSizeWithType:(YFXScreenType) type {
    CGSize size = CGSizeZero;
    switch (type) {
        case IpadLandcapse:
            size = yfx_Ipad_Landcapse;
            break;
        case IpadLandcapseWithStatusBar:
            size = yfx_Ipad_Landcapse_With_StatusBar;
            break;
        case IpadPortrait:
            size = yfx_Ipad_Portrait;
            break;
        case IpadPortraitWithStatusBar:
            size = yfx_Ipad_Portrait_With_StatusBar;
            break;
        case Iphone4Portrait:
            size = yfx_Iphone_4inch_Portrait;
            break;
        case Iphone47Portrait:
            size = yfx_Iphone_47inch_Portrait;
            break;
        case Iphone55Portrait:
            size = yfx_Iphone_55inch_Portrait;
            break;
        case Iphone55Landcapse:
            size = yfx_Iphone_55inch_Landcapse;
            break;
        case IphoneXPortrait:
            size = yfx_Iphone_X_Portrait;
            break;
        case IphoneXLandcapse:
            size = yfx_Iphone_X_Landcapse;
            break;
        default:
            size = yfx_Ipad_Landcapse;
            break;
    }
    return size;
}

+(NSString*) getSourceNameWithType:(YFXScreenType) type {
    NSString* name = @"";
    switch (type) {
        case IpadLandcapse:
            name = yfx_Ipad_Landcapse_Src;
            break;
        case IpadLandcapseWithStatusBar:
            name = yfx_Ipad_Landcapse_With_StatusBar_Src;
            break;
        case IpadPortrait:
            name = yfx_Ipad_Portrait_Src;
            break;
        case IpadPortraitWithStatusBar:
            name = yfx_Ipad_Portrait_With_StatusBar_Src;
            break;
        case Iphone4Portrait:
            name = yfx_Iphone_4inch_Portrait_Src;
            break;
        case Iphone47Portrait:
            name = yfx_Iphone_47inch_Portrait_Src;
            break;
        case Iphone55Portrait:
            name = yfx_Iphone_55inch_Portrait_Src;
            break;
        case Iphone55Landcapse:
            name = yfx_Iphone_55inch_Landcapse_Src;
            break;
        case IphoneXPortrait:
            name = yfx_Iphone_X_Portrait_Src;
            break;
        case IphoneXLandcapse:
            name = yfx_Iphone_X_Landcapse_Src;
            break;
        default:
            name = yfx_Src;
            break;
    }
    return name;
}

+(YFXScreenType) getCurrentScreenType {
    YFXScreenType type = IpadLandcapse;
    CGSize size = CGSizeZero;
    CGRect screen = [UIScreen mainScreen].bounds;
    float area = screen.size.width*screen.size.height;
    for(int i=0; i < ScreenTypeCount; i++) {
        size = [YFResourceManager getPointSizeWithType:i];
        if(area == size.width*size.height){
            type = i;
            break;
        }
    }
    return type;
}

+(CGSize) getPointScaleWithType:(YFXScreenType) type from:(YFXScreenType) design_type {
    CGSize from = [YFResourceManager getPointSizeWithType:type];
    CGSize to = [YFResourceManager getPointSizeWithType:design_type];
    return CGSizeMake(from.width/to.width, from.height/to.height);
}

+(float) getStatusBarWithType:(YFXScreenType) type
{
    float size = 20;
    switch (type) {
        case IphoneXPortrait:
            size = 44;
            break;
        case IphoneXLandcapse:
            size = 44;
            break;
        default:
            size = 20;
    }
    return size;
}

+(float) getNavigationHeightWithType:(YFXScreenType) type {
    float size = 44;
    switch (type) {
        case IphoneXPortrait:
            size = 97;
            break;
        case IphoneXLandcapse:
            size = 97;
            break;
        default:
            size = 44;
    }
    return size;
}

+(float) getTabBarHeightWithType:(YFXScreenType) type {
    return 49;
}

+(float) getHomeIndicatorHeightWithType:(YFXScreenType) type {
    float size = 0;
    switch (type) {
        case IphoneXPortrait:
        size = 34;
        break;
        case IphoneXLandcapse:
        size = 34;
        break;
        default:
        size = 0;
    }
    return size;
}

@end
