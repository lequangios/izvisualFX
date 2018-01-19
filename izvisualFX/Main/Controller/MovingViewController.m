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
        is_auto_complete_start = NO;
        is_auto_complete_end = YES;
        snap_to = 0;
        snap_end = 500;
        snap_start = 80;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.movingBlock = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 100, 100)];
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
    is_touch_down = YES;
    current_point = [touch locationInView:self.view];
}

-(void) touchMove:(UITouch*) touch
{
    if(is_touch_down == YES)
    {
        CGPoint point = [touch locationInView:self.view];
        float dx = point.x - current_point.x;
        float dy = point.y - current_point.y;
        current_point = point;
        self.movingBlock.frame = CGRectMake(self.movingBlock.frame.origin.x+dx, self.movingBlock.frame.origin.y + dy, 100, 100);
    }
}

-(void) touchEnd:(UITouch*) touch
{
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
