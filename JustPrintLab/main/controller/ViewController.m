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
#import <MBProgressHUD.h>
#import "HomeHeaderView.h"
#import "HomeMidView.h"
#import "ScanTableViewController.h"
#import "PrintTableViewController.h"
#import "CommonFunc.h"
@interface ViewController ()<HomeHeaderViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupSlideMenu];
    [self setupUI];
    UIImage *image=[[UIImage imageNamed:@"header"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];


    //更改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

   

}
- (void)dealloc {
    DLog(@"home:%s",__func__);
}
-(void)setupUI{
    //添加ScrollView
    UIScrollView*scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scroll.contentSize=CGSizeMake(ScreenWidth, ScreenHeight-44);
    [self.view addSubview:scroll];
    scroll.backgroundColor=JpColor(245, 245, 245);
    scroll.showsVerticalScrollIndicator = NO;
    //初始化头部UI
   
    HomeHeaderView *headerView=[[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*2/3)];
    headerView.delegate=self;
    [scroll addSubview:headerView];
    
  
    
   //左view
    HomeMidView*midView=[[HomeMidView alloc]initWithFrame:CGRectMake(0,  ScreenWidth*2/3+20, (ScreenWidth-10)/2, (ScreenWidth-10)/4) withImageName:@"scanRec" withTitleName:@"扫描管理" withMsgNmae:@"所有扫描件都在这里"];
    [scroll addSubview:midView];
    
   
    
    //右view
    HomeMidView*midView1=[[HomeMidView alloc]initWithFrame:CGRectMake((ScreenWidth-10)/2+10, ScreenWidth*2/3+20, (ScreenWidth-10)/2, (ScreenWidth-10)/4) withImageName:@"printRec" withTitleName:@"打印任务" withMsgNmae:@"未输出的任务都在这"];
    [scroll addSubview:midView1];
    
    //添加点击事件
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftMidViewAction:)];
     UITapGestureRecognizer *tapGesturRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightMidViewAction:)];
    [midView addGestureRecognizer:tapGesturRecognizer];
    [midView1 addGestureRecognizer:tapGesturRecognizer1];
                             
    
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

-(void)leftMidViewAction:(id)sender{

    [CommonFunc backToLogon];
    /*
    ScanTableViewController*scan=[[ScanTableViewController alloc]init];
    [self.navigationController pushViewController:scan animated:YES];
     */
}
-(void)rightMidViewAction:(id)sender{
    PrintTableViewController*print=[[PrintTableViewController alloc]init];
    [self.navigationController pushViewController:print animated:YES];
}
#pragma mark HomeHeaderViewDelegate
-(void)HomeHeaderViewButton:(UIButton *)button{
    NSArray*titleArr=@[@"图片打印",@"证件打印",@"发票打印",@"照片打印",@"扫一扫"];
    DLog(@"%@",titleArr[button.tag-1000]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
