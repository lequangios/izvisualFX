//
//  RootStyle.m
//  izvisualFX
//
//  Created by quangle on 2/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "RootStyle.h"
#import "YFResourceManager.h"

@implementation RootStyle
{
    YFResourceManager* manager;
}

@synthesize page_margin         = _page_margin;
@synthesize menu_btn_size       = _menu_btn_size;
@synthesize menu_btn_point      = _menu_btn_point;
@synthesize menu_view_size      = _menu_view_size;
@synthesize menu_view_point     = _menu_view_point;
@synthesize menu_item_size      = _menu_item_size;

-(instancetype) init
{
    self = [super init];
    if(self)
    {
        manager = [YFResourceManager shareInstance];
        
        _page_margin = CGPointMake(16, manager.status_bar_height);
        _menu_btn_size = CGSizeMake(32, 32);
        _menu_btn_point = CGPointMake(16, 44);
        
        _menu_view_size = CGSizeMake(manager.screen_size.width-100, manager.screen_size.height-2*_page_margin.y);
        _menu_view_point = CGPointMake(-_menu_view_size.width, _page_margin.y);
        _menu_item_size = CGSizeMake(_menu_view_size.width-2*_page_margin.x, 40);
    }
    return self;
}

@end
