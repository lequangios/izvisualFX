//
//  AnimateViewController.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/17/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFX.h"

@interface AnimateViewController : UIViewController<UIPickerViewDelegate>
{
    float top;
    UIView* test1;
    UIView* test2;
    
    UILabel* label1;
    UILabel* label2;
    
    UIButton* play;
    UIButton* change_type;
    
    YFX* animator1;
    YFX* animator2;
    NSArray* typeArr;
    UIPickerView* pick;
    
    int current_type;
}
@end
