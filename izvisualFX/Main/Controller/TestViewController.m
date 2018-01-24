//
//  TestViewController.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/14/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "TestViewController.h"

#import "YFX.h"

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize sphere = _sphere;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"Demo";
    [self showDemo];
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
    _sphere = [[SphereView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_sphere];
    [_sphere initRendered];
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
