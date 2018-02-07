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
{
    
}

@synthesize bgView      = _bgView;
@synthesize menuBtn     = _menuBtn;
@synthesize menuView    = _menuView;

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self initUI];
    }
    return self;
}

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
    
    [self setupUIWithFrame:self.view.frame];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup UI
-(void) initUI
{
    manager = [YFResourceManager shareInstance];
    style = [[RootStyle alloc] init];
    _bgView = [[UIImageView alloc] init];
    _menuBtn = [[UIButton alloc] init];
    [_menuBtn setBackgroundImage:[manager imageForResource:@"menu" andType:@"png"] forState:UIControlStateNormal];
    [_menuBtn setBackgroundColor:[UIColor clearColor]];
    
    _menuView = [[MenuView alloc] init];
    _menuView.delegate = self;
    
    [self.view addSubview:_bgView];
    [self.view addSubview:_menuBtn];
    [self.view addSubview:_menuView];
}

-(void) setupUIWithFrame:(CGRect) frame
{
    self.view.frame = frame;
    _bgView.frame = frame;
    [manager setResourceWithDesignType:IphoneXPortrait];
    
    UIImage* img = [manager imageForResponsiveResource:@"bg" andType:@"jpg"];
    [_bgView setImage:img];
    
    _menuBtn.frame = CGRectMake(style.menu_btn_point.x, style.menu_btn_point.y, style.menu_btn_size.width, style.menu_btn_size.height);
    
    [_menuView setMenu_item_size:style.menu_item_size];
    [_menuView setMenu_padding:style.page_margin];
    [_menuView settingMenuWithFrame:CGRectMake(style.menu_view_point.x, style.menu_view_point.y, style.menu_view_size.width, style.menu_view_size.height)];
}

#pragma mark - Setup Action
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

#pragma mark - Handler Touch
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [_menuView touchBegin:point];
}


-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [_menuView touchMove:point];
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [_menuView touchEnd:point];
}


#pragma mark - Menu Delegate
-(void) moveWithDirection:(float)direction
{
    float dx = direction + _menuBtn.frame.origin.x;
    if(dx >= style.menu_btn_point.x && dx <= style.menu_btn_point.x + style.menu_view_size.width){
        _menuBtn.frame = CGRectMake(dx, style.menu_btn_point.y, style.menu_btn_size.width, style.menu_btn_size.height);
    }
}

-(void) snapToEnd
{
    _menuBtn.frame = CGRectMake(style.menu_btn_point.x + style.menu_view_size.width, style.menu_btn_point.y, style.menu_btn_size.width, style.menu_btn_size.height);
}

-(void) snapToStart
{
    _menuBtn.frame = CGRectMake(style.menu_btn_point.x, style.menu_btn_point.y, style.menu_btn_size.width, style.menu_btn_size.height);
}

-(void) snapToStartComplete
{
    [_menuBtn setBackgroundImage:[manager imageForResource:@"menu" andType:@"png"] forState:UIControlStateNormal];
}

-(void) snapToEndComplete
{
    [_menuBtn setBackgroundImage:[manager imageForResource:@"go_back_left_arrow" andType:@"png"] forState:UIControlStateNormal];
}

@end
