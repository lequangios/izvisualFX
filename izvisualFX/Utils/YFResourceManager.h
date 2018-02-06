//
//  YFResourceManager.h
//  izvisualFX
//
//  Created by Le Viet Quang on 2/5/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : int{
    IpadLandcapse = 0,
    IpadLandcapseWithStatusBar,
    IpadPortrait,
    IpadPortraitWithStatusBar,
    Iphone4Portrait,
    Iphone47Portrait,
    Iphone55Portrait,
    Iphone55Landcapse,
    IphoneXPortrait,
    IphoneXLandcapse,
    ScreenTypeCount
} YFXScreenType;

@interface YFResourceManager : NSObject

+(YFXScreenType) getCurrentScreenType;
+(CGSize) getPointSizeTransformWithSize:(CGSize) size;
+(CGSize) getPointSizeWithType:(YFXScreenType) type;
+(CGSize) getPointScaleWithType:(YFXScreenType) type from:(YFXScreenType) design_type;
+(NSString*) getSourceNameWithType:(YFXScreenType) type;

+(float) getStatusBarWithType:(YFXScreenType) type;
+(float) getNavigationHeightWithType:(YFXScreenType) type;
+(float) getTabBarHeightWithType:(YFXScreenType) type;
+(float) getHomeIndicatorHeightWithType:(YFXScreenType) type;

@end
