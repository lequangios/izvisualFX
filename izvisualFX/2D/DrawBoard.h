//
//  DrawBoard.h
//  izvisualFX
//
//  Created by Le Viet Quang on 1/13/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBoard : UIView <UIPickerViewDelegate>
{
    CGBlendMode blend_mode1;
    CGBlendMode blend_mode2;
    CGBlendMode blend_mode3;
    CGBlendMode curent_blend_mode;
    
    UIPickerView* pick;
    
    NSArray* listBlendMode;
    
    UIButton* draw_button;
    UIButton* option1;
    UIButton* option2;
    UIButton* option3;
    UIButton* current_btn;
}
-(void) DrawBoardWithBlendMode:(CGBlendMode) blend_mode;
-(void) checkDrawBoardWithBlendMode:(CGBlendMode) blend_mode1 :(CGBlendMode) blend_mode2 : (CGBlendMode) blend_mode3;

@end
