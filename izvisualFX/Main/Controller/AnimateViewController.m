//
//  AnimateViewController.m
//  izvisualFX
//
//  Created by Le Viet Quang on 1/17/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

#import "AnimateViewController.h"


@interface AnimateViewController ()

@end

@implementation AnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingUI];
    [self makeAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) settingUI
{
    top = 44;
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, top+50, 150, 50)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"YFXLinearEase";
    label1.textColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(230, top+50, 150, 50)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"YFXEaseInQuad";
    label2.textColor = [UIColor whiteColor];
    [self.view addSubview:label2];
    
    play = [[UIButton alloc] initWithFrame:CGRectMake(30, self.view.frame.size.height-80, 150, 50)];
    play.backgroundColor = [UIColor purpleColor];
    play.layer.cornerRadius = 5;
    [play setTitle:@"Play" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playAnimate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
    
    change_type = [[UIButton alloc] initWithFrame:CGRectMake(200, self.view.frame.size.height-80, 150, 50)];
    change_type.backgroundColor = [UIColor purpleColor];
    change_type.layer.cornerRadius = 5;
    [change_type setTitle:@"Change Type" forState:UIControlStateNormal];
    [change_type setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [change_type addTarget:self action:@selector(changeType) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:change_type];
    
    pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 100)];
    pick.backgroundColor = [UIColor blueColor];
    pick.delegate = self;
    [self.view addSubview:pick];
    
    typeArr = @[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(14),@(15),@(16),@(17),@(18),@(19),@(20),@(21),@(22),@(23),@(24),@(25),@(26),@(27),@(28),@(29),@(30)];
}

-(void) makeAnimate {
    test1 = [[UIView alloc] initWithFrame:CGRectMake(80, top+100, 50, 50)];
    test1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:test1];
    
    test2 = [[UIView alloc] initWithFrame:CGRectMake(280, top+100, 50, 50)];
    test2.backgroundColor = [UIColor redColor];
    [self.view addSubview:test2];
    
    animator1 = [[YFX alloc] initWithTarget:test1];
    [animator1 doAnimationWithBegin:top+100 withEnd:450 withDuration:1.5 withType:YFXLinearEase withAction:^(__weak id obj, float currentValue) {
        UIView* obj_view = (UIView*) obj;
        obj_view.frame = CGRectMake(80, currentValue, 50, 50);
    } withHandler:^(__weak id obj, BOOL is_complete) {
    }];
    
    animator2 = [[YFX alloc] initWithTarget:test2];
    [animator2 doAnimationWithBegin:top+100 withEnd:450 withDuration:1.5 withType:current_type withAction:^(__weak id obj, float currentValue) {
        UIView* obj_view = (UIView*) obj;
        obj_view.frame = CGRectMake(280, currentValue, 50, 50);
    } withHandler:^(__weak id obj, BOOL is_complete) {
    }];
    
}

-(void) playAnimate
{
//    [animator1 stopAnimation];
//    [animator2 stopAnimation];
    
    [animator1 startAnimation];
    [animator2 startAnimation];
}

-(void) changeType
{
    [UIView animateWithDuration:0.5 animations:^{
        pick.frame = CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100);
    }];
}

#pragma mark - Setup For PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return typeArr.count;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    UIColor* color = [UIColor whiteColor];
    current_type = (int32_t)row-1;
    NSString* title = [NSString stringWithFormat:@"%@",[YFX animationNameByType:current_type]];
    NSAttributedString* att = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],
                                                                                            NSForegroundColorAttributeName: color}];
    return att;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString* title = [NSString stringWithFormat:@"%@",[YFX animationNameByType:current_type]];
    
    label2.text = title;
    
    [animator2 setAnimationType:current_type];
    
    [UIView animateWithDuration:0.5 animations:^{
        pick.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 100);
    }];
    [pick reloadAllComponents];
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
