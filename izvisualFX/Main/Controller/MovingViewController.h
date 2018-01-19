//
//  MovingViewController.h
//  izvisualFX
//
//  Created by quangle on 1/19/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface MovingViewController : UIViewController
{
    BOOL is_touch_down;
    BOOL is_auto_complete_start;
    BOOL is_auto_complete_end;
    float snap_to;
    float snap_end;
    float snap_start;
    CGPoint current_point;
}
@property(nonatomic, retain) UIView* movingBlock;

@end
