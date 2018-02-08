//
//  MenuView.h
//  izvisualFX
//
//  Created by quangle on 2/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFXButton.h"

@protocol MenuViewDelegate <NSObject>
@optional
-(void) moveWithDirection:(float) direction;
-(void) snapToEnd;
-(void) snapToEndComplete;
-(void) snapToStart;
-(void) snapToStartComplete;
@end

@interface MenuView : UIView
{
    BOOL is_touch_down;
    BOOL is_show_menu;
    BOOL is_auto_complete_start;
    BOOL is_auto_complete_end;
    float snap_to;
    float snap_end;
    float snap_start;
    float direction;
    CGPoint current_point;
}

@property(nonatomic, assign) CGSize menu_item_size;
@property(nonatomic, assign) CGPoint menu_padding;
@property(nonatomic, weak) id<MenuViewDelegate> delegate;
@property(nonatomic, retain) UIScrollView* content;
@property(nonatomic, retain) YFXButton* blendmode;

-(void) settingMenuWithFrame:(CGRect) frame;

-(void) touchBegin:(CGPoint) touch;
-(void) touchMove:(CGPoint) touch;
-(void) touchEnd:(CGPoint) touch;

-(void) showHideMenu;

@end
