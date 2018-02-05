//
//  ViewController.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/7/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "TestViewController.h"
#import "AnimateViewController.h"
#import "MovingViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    
    // Button 1
    UIButton* demo = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 200, 50)];
    demo.backgroundColor = [UIColor purpleColor];
    [demo setTitle:@"Draw Board" forState:UIControlStateNormal];
    [self.view addSubview:demo];
    [demo addTarget:self action:@selector(openDemoPage:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button 2
    UIButton* test = [[UIButton alloc] initWithFrame:CGRectMake(20, 170, 200, 50)];
    test.backgroundColor = [UIColor purpleColor];
    [test setTitle:@"Demo" forState:UIControlStateNormal];
    [self.view addSubview:test];
    [test addTarget:self action:@selector(openTetsPage:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button 3
    UIButton* animate = [[UIButton alloc] initWithFrame:CGRectMake(20, 240, 200, 50)];
    animate.backgroundColor = [UIColor purpleColor];
    [animate setTitle:@"Animation" forState:UIControlStateNormal];
    [self.view addSubview:animate];
    [animate addTarget:self action:@selector(openAnimatePage:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button 3
    UIButton* moving = [[UIButton alloc] initWithFrame:CGRectMake(20, 310, 200, 50)];
    moving.backgroundColor = [UIColor purpleColor];
    [moving setTitle:@"Moving" forState:UIControlStateNormal];
    [self.view addSubview:moving];
    [moving addTarget:self action:@selector(openMovingPage:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup UI
-(void) setupUIWithFrame:(CGRect) frame
{
    
}

-(void) openDemoPage:(id) sender
{
    DemoViewController* view = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:view animated:NO];
}

-(void) openTetsPage:(id) sender
{
    TestViewController* view = [[TestViewController alloc] init];
    [self.navigationController pushViewController:view animated:NO];
}

-(void) openAnimatePage:(id) sender
{
    AnimateViewController* view = [[AnimateViewController alloc] init];
    [self.navigationController pushViewController:view animated:NO];
}

-(void) openMovingPage:(id) sender
{
    MovingViewController* view = [[MovingViewController alloc] init];
    [self.navigationController pushViewController:view animated:NO];
}

@end
