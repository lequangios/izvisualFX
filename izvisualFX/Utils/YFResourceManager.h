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

@property(nonatomic, retain) NSString* resource_src;
@property(nonatomic, assign) YFXScreenType screen_type;
@property(nonatomic, assign) CGSize screen_size;
@property(nonatomic, assign) CGSize screen_scale;
@property(nonatomic, assign) float status_bar_height;
@property(nonatomic, assign) float navi_height;
@property(nonatomic, assign) float tabbar_height;
@property(nonatomic, assign) float home_indicator_height;
@property(nonatomic, assign) BOOL is_ipad;
@property(nonatomic, assign) BOOL is_landcapse;
@property(nonatomic, assign) UIInterfaceOrientation current_orientation;

+(YFXScreenType) getCurrentScreenType;
+(CGSize) getPointSizeTransformWithSize:(CGSize) size;
+(CGSize) getPointSizeWithType:(YFXScreenType) type;
+(CGSize) getPointScaleWithType:(YFXScreenType) type from:(YFXScreenType) design_type;
+(NSString*) getSourceNameWithType:(YFXScreenType) type;

+(float) getStatusBarWithType:(YFXScreenType) type;
+(float) getNavigationHeightWithType:(YFXScreenType) type;
+(float) getTabBarHeightWithType:(YFXScreenType) type;
+(float) getHomeIndicatorHeightWithType:(YFXScreenType) type;

+(instancetype) shareInstance;
-(void) setResourceWithDesignType:(YFXScreenType) type;
-(void) updateYFResourceManager;
-(UIImage*) imageForResource:(NSString*) name andType:(NSString*) type;
-(UIImage*) imageForResponsiveResource:(NSString*) name andType:(NSString*) type;
-(UIImage*) imageRenderForResource:(NSString*) name andType:(NSString*) type;


@end
