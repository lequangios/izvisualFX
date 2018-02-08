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

#define yfx_Src                                         @"Resource/img/"
#define yfx_Ipad_Landcapse_Src                          @"Resource/img/ipadland/"
#define yfx_Ipad_Landcapse_With_StatusBar_Src           @"Resource/img/ipadland/"
#define yfx_Ipad_Portrait_Src                           @"Resource/img/ipadport/"
#define yfx_Ipad_Portrait_With_StatusBar_Src            @"Resource/img/ipadport/"
#define yfx_Iphone_4inch_Portrait_Src                   @"Resource/img/4inch/"
#define yfx_Iphone_47inch_Portrait_Src                  @"Resource/img/47inch/"
#define yfx_Iphone_55inch_Portrait_Src                  @"Resource/img/55inchport/"
#define yfx_Iphone_55inch_Landcapse_Src                 @"Resource/img/55inchland/"
#define yfx_Iphone_X_Portrait_Src                       @"Resource/img/xport/"
#define yfx_Iphone_X_Landcapse_Src                      @"Resource/img/xland/"

@implementation YFResourceManager
{
    YFXScreenType design_type;
}

@synthesize resource_src            = _resource_src;
@synthesize screen_type             = _screen_type;
@synthesize screen_size             = _screen_size;
@synthesize screen_scale            = _screen_scale;
@synthesize status_bar_height       = _status_bar_height;
@synthesize navi_height             = _navi_height;
@synthesize tabbar_height           = _tabbar_height;
@synthesize home_indicator_height   = _home_indicator_height;
@synthesize is_ipad                 = _is_ipad;
@synthesize is_landcapse            = _is_landcapse;
@synthesize current_orientation     = _current_orientation;

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
        if(area == size.width*size.height && screen.size.height == size.height){
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

-(instancetype) init
{
    self = [super init];
    if(self){
        _screen_type = Iphone47Portrait;
        _resource_src = [YFResourceManager getSourceNameWithType:_screen_type];
        _screen_size = [YFResourceManager getPointSizeWithType:_screen_type];
        _screen_scale = [YFResourceManager getPointScaleWithType:_screen_type from:Iphone47Portrait];
        _status_bar_height = [YFResourceManager getStatusBarWithType:_screen_type];
        _navi_height = [YFResourceManager getNavigationHeightWithType:_screen_type];
        _tabbar_height = [YFResourceManager getTabBarHeightWithType:_screen_type];
        _home_indicator_height = [YFResourceManager getHomeIndicatorHeightWithType:_screen_type];
        _is_landcapse = NO;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) _is_ipad = YES;
        else _is_ipad = NO;
    }
    return self;
}

+(instancetype) shareInstance
{
    static YFResourceManager* appMethod = Nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appMethod = [[self alloc] init];
    });
    return appMethod;
}

-(void) setResourceWithDesignType:(YFXScreenType)type
{
    design_type = type;
    [self updateYFResourceManager];
}

-(void) updateYFResourceManager
{
    _current_orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(_current_orientation == UIDeviceOrientationLandscapeRight || _current_orientation == UIDeviceOrientationLandscapeLeft) _is_landcapse = YES;
    else _is_landcapse = NO;
    
    [self setupYFResourceManager];
}

-(UIImage*) imageForResource:(NSString*) name andType:(NSString*) type
{
    name = [NSString stringWithFormat:@"%@%@",yfx_Src,name];
    NSString *str = [[NSBundle mainBundle] pathForResource:name ofType:type];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:str];
    return img;
}

-(UIImage*) imageForResponsiveResource:(NSString*) name andType:(NSString*) type
{
    name = [NSString stringWithFormat:@"%@%@",_resource_src,name];
    NSString *str = [[NSBundle mainBundle] pathForResource:name ofType:type];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:str];
    return img;
}

-(UIImage*) imageRenderForResource:(NSString*) name andType:(NSString*) type
{
    name = [NSString stringWithFormat:@"%@%@",yfx_Src,name];
    NSString *str = [[NSBundle mainBundle] pathForResource:name ofType:type];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:str];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

#pragma mark - private method
-(void) setupYFResourceManager
{
    _screen_type = [YFResourceManager getCurrentScreenType];
    _resource_src = [YFResourceManager getSourceNameWithType:_screen_type];
    _screen_size = [YFResourceManager getPointSizeWithType:_screen_type];
    _screen_scale = [YFResourceManager getPointScaleWithType:_screen_type from:design_type];
    _status_bar_height = [YFResourceManager getStatusBarWithType:_screen_type];
    _navi_height = [YFResourceManager getNavigationHeightWithType:_screen_type];
    _tabbar_height = [YFResourceManager getTabBarHeightWithType:_screen_type];
    _home_indicator_height = [YFResourceManager getHomeIndicatorHeightWithType:_screen_type];
}

@end
