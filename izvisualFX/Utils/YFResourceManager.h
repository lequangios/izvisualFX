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
    IpadLandcapse,
    IpadLandcapseWithStatusBar,
    IpadPortrait,
    IpadPortraitWithStatusBar,
    Iphone4Portrait,
    Iphone47Portrait,
    Iphone55Portrait,
    Iphone55Landcapse,
    IphoneXPortrait,
    IphoneXLandcapse
} YFXScreenType;

@interface YFResourceManager : NSObject

+(CGSize) getPointSizeWithType:(YFXScreenType) type;
+(float) getStatusBarWithType:(YFXScreenType) type;
@end
