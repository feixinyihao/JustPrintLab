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
#import <MBProgressHUD.h>
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
    //添加ScrollView
    UIScrollView*scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scroll.contentSize=CGSizeMake(ScreenWidth, ScreenHeight-64);
    [self.view addSubview:scroll];
    scroll.backgroundColor=JpColor(245, 245, 245);
    scroll.showsVerticalScrollIndicator = NO;
    //初始化头部UI
    UIView*headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*2/3)];
    headView.backgroundColor=[UIColor whiteColor];
    [scroll addSubview:headView];
    
    UIView*midView=[[UIView alloc]initWithFrame:CGRectMake(0,  ScreenWidth*2/3+20, (ScreenWidth-10)/2, (ScreenWidth-10)/4)];
    midView.backgroundColor=[UIColor whiteColor];
    
    CGFloat scale=ScreenWidth/375;
    UIImageView*scanImage=[[UIImageView alloc]initWithFrame:CGRectMake(20*scale, 20*scale, (ScreenWidth-10)/4-40*scale, (ScreenWidth-10)/4-40*scale)];
    [scanImage setImage:[UIImage imageNamed:@"scanRec"]];
    [midView addSubview:scanImage];
    
    UILabel*scanTitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-10)/4-20*scale, 20*scale, 100*scale, 25*scale)];
    [scanTitle setText:@"扫描管理"];
    scanTitle.font=[UIFont systemFontOfSize:14];
    scanTitle.textColor=[UIColor blackColor];
    [midView addSubview:scanTitle];
    
    UILabel*msgTitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-10)/4-20*scale, scale*50, 120*scale, 15*scale)];
    [msgTitle setText:@"所有扫描件都在这里"];
    msgTitle.font=[UIFont systemFontOfSize:10];
    msgTitle.textColor=[UIColor blackColor];
    [midView addSubview:msgTitle];
    
    [scroll addSubview:midView];
    
    UIView*midView1=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-10)/2+10, ScreenWidth*2/3+20, (ScreenWidth-10)/2, (ScreenWidth-10)/4)];
    midView1.backgroundColor=[UIColor whiteColor];
    
    
    UIImageView*printImage=[[UIImageView alloc]initWithFrame:CGRectMake(20*scale, 20*scale, (ScreenWidth-10)/4-40*scale, (ScreenWidth-10)/4-40*scale)];
    [printImage setImage:[UIImage imageNamed:@"printRec"]];
    [midView1 addSubview:printImage];
    
    UILabel*printTitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-10)/4-20*scale, 20*scale, 100*scale, 25*scale)];
    [printTitle setText:@"打印任务"];
    printTitle.font=[UIFont systemFontOfSize:14];
    printTitle.textColor=[UIColor blackColor];
    [midView1 addSubview:printTitle];
    
    UILabel*printMsg=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-10)/4-20*scale, 50*scale, 120*scale, 15*scale)];
    [printMsg setText:@"未输出的任务都在这"];
    printMsg.font=[UIFont systemFontOfSize:10];
    printMsg.textColor=[UIColor blackColor];
    [midView1 addSubview:printMsg];
    [scroll addSubview:midView1];
                             
    
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text =@"成功了成功";
    hud.margin=10;
    hud.center=self.view.center;
   // hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:2.f];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
