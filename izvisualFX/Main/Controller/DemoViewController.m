//
//  DemoViewController.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/14/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "DemoViewController.h"
#import "VisualizationFX.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"Blend Mode in Core Graphic";
    
    // Do any additional setup after loading the view.
    DrawBoard* board = [[DrawBoard alloc] initWithFrame:self.view.frame];
    [self.view addSubview:board];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
