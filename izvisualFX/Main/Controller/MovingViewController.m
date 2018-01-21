//
//  MovingViewController.m
//  izvisualFX
//
//  Created by quangle on 1/19/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "MovingViewController.h"

@interface MovingViewController ()

@end

@implementation MovingViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        is_touch_down = NO;
        is_show_menu = NO;
        is_auto_complete_start = NO;
        is_auto_complete_end = YES;
        snap_to = 0;
        snap_end = 250;
        snap_start = 10;
        direction = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.movingBlock = [[UIView alloc] initWithFrame:CGRectMake(-snap_end, 64, snap_end, self.view.frame.size.height-64)];
    self.movingBlock.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.movingBlock];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: Private Handler Touch
-(void) touchBegin:(UITouch*) touch
{
    current_point = [touch locationInView:self.view];
    if(is_show_menu == YES)
    {
        if (current_point.x > snap_end) {
            is_touch_down = YES;
        }
    }
    else is_touch_down = YES;
    
}

-(void) touchMove:(UITouch*) touch
{
    if(is_touch_down == YES && is_auto_complete_start == NO)
    {
        CGPoint point = [touch locationInView:self.view];
        direction = point.x - current_point.x;
        float dx = direction + self.movingBlock.frame.origin.x;
        current_point = point;
        if (dx <= 0) {
            self.movingBlock.frame = CGRectMake(dx, self.movingBlock.frame.origin.y, snap_end, self.view.frame.size.height-64);
        }
        else {
            is_show_menu = YES;
        }
    }
}

-(void) touchEnd:(UITouch*) touch
{
    // Hide it
    if(direction < -snap_start) {
        is_auto_complete_start = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.movingBlock.frame = CGRectMake(-snap_end, self.movingBlock.frame.origin.y, snap_end, self.view.frame.size.height-64);
        } completion:^(BOOL finished) {
            is_auto_complete_start = NO;
            is_show_menu = NO;
        }];
    }
    else if(direction > snap_start) {
        is_auto_complete_start = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.movingBlock.frame = CGRectMake(0, self.movingBlock.frame.origin.y, snap_end, self.view.frame.size.height-64);
        } completion:^(BOOL finished) {
            is_auto_complete_start = NO;
            is_show_menu = YES;
        }];
    }
    
    is_touch_down = NO;
}

//MARK: Handler Touch
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    [self touchBegin:touch];
}


-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    [self touchMove:touch];
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    [self touchEnd:touch];
}

@end
