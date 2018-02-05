//
//  YFResourceManager.m
//  izvisualFX
//
//  Created by Le Viet Quang on 2/5/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "YFResourceManager.h"

@implementation YFResourceManager

+(CGSize) getPointSizeWithType:(YFXScreenType) type {
    CGSize size = CGSizeZero;
    switch (type) {
        case IpadLandcapse:
            size = CGSizeMake(1024, 768);
            break;
        case IpadLandcapseWithStatusBar:
            size = CGSizeMake(1024, 748);
            break;
        case IpadPortrait:
            size = CGSizeMake(768, 1024);
            break;
        case IpadPortraitWithStatusBar:
            size = CGSizeMake(768, 1004);
            break;
        case Iphone4Portrait:
            size = CGSizeMake(320, 568);
            break;
        case Iphone47Portrait:
            size = CGSizeMake(375, 667);
            break;
        case Iphone55Portrait:
            size = CGSizeMake(414, 736);
            break;
        case Iphone55Landcapse:
            size = CGSizeMake(736, 414);
            break;
        case IphoneXPortrait:
            size = CGSizeMake(375, 812);
            break;
        case IphoneXLandcapse:
            size = CGSizeMake(812, 375);
            break;
    }
    return size;
}

+(float) getStatusBarWithType:(YFXScreenType) type
{
    float size = 0;
    switch (type) {
        case IpadLandcapse:
            size = 0;
            break;
        case IpadLandcapseWithStatusBar:
            size = 0;
            break;
        case IpadPortrait:
            size = 0;
            break;
        case IpadPortraitWithStatusBar:
            size = 0;
            break;
        case Iphone4Portrait:
            size = 0;
            break;
        case Iphone47Portrait:
            size = 0;
            break;
        case Iphone55Portrait:
            size = 0;
            break;
        case Iphone55Landcapse:
            size = 0;
            break;
        case IphoneXPortrait:
            size = 0;
            break;
        case IphoneXLandcapse:
            size = 0;
            break;
    }
    return size;
}
@end
