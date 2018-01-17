//
//  TestViewController.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/14/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "TestViewController.h"
#import "VisualizationFX.h"
#import "YFX.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"Demo";
    [self showDemo];
    UIView* test = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    test.backgroundColor = [UIColor blueColor];
    [self.view addSubview:test];
    YFX* animator = [[YFX alloc] initWithTarget:test];
    [animator doAnimationWithBegin:100 withEnd:500 withDuration:1.5 withType:YFXEaseOutQuad withAction:^(__weak id obj, float currentValue) {
        UIView* obj_view = (UIView*) obj;
        obj_view.frame = CGRectMake(100, currentValue, 50, 50);
        NSLog(@"Value = %f", currentValue);
    } withHandler:^(__weak id obj, BOOL is_complete) {
        NSLog(@"Done");
    }];
    [animator startAnimation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) showDemo
{
    YFXSnow* view = [[YFXSnow alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44) andMaxItem:45];
    [self.view addSubview:view];
    [view startAnimation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
