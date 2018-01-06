//
//  ViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/6.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "LeftViewController.h"
#import "PushViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupSlideMenu];
    [self setupUI];

}
-(void)setupUI{
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 60)];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton*push=[[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 60)];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push setBackgroundColor:[UIColor greenColor]];
    [push addTarget:self action:@selector(mypush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
}
-(void)setupSlideMenu{
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        //NSLog(@"direction = %ld", direction);
        if (direction == CWDrawerTransitionDirectionLeft) { // 左侧滑出
            [weakSelf leftClick];
        } else if (direction == CWDrawerTransitionDirectionRight) { // 右侧滑出
            NSLog(@"-----");
        }
    }];
   

}
// 导航栏左边按钮的点击事件
- (void)leftClick {

    LeftViewController *vc = [[LeftViewController alloc] init];
    vc.drawerType = DrawerDefaultLeft;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:kCWSCREENWIDTH*0.75 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionDirectionLeft backImage:nil];
    // 调用这个方法
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:conf];
    
}


-(void)mypush{
    PushViewController*push=[[PushViewController alloc]init];
    [self.navigationController pushViewController:push animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
