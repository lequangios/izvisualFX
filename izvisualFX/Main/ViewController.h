//
//  ViewController.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisualizationFX.h"
#import "MenuView.h"
#import "RootStyle.h"

@interface ViewController : UIViewController<MenuViewDelegate>
{
    YFResourceManager* manager;
    RootStyle* style;
}

@property(nonatomic, retain) UIImageView* bgView;
@property(nonatomic, retain) UIButton* menuBtn;
@property(nonatomic, retain) MenuView* menuView;

@end

