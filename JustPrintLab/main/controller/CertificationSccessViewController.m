//
//  CertificationSccessViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/26.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "CertificationSccessViewController.h"
#import "QRcodeViewController.h"
#import "FeeStdView.h"
#import "UIView+cxr.h"

@interface CertificationSccessViewController ()
@property(nonatomic,strong)FeeStdView*feeview;

@property(nonatomic,assign)BOOL isShow;
@end

@implementation CertificationSccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self delQrCodeVC];
    self.title=@"自助文印认证";
    self.showMsg=@"认证成功";
    [self setupShadowView];
    self.feeview.hidden=!self.isShow;
   
  
}
-(FeeStdView *)feeview{
    if (_feeview==nil) {
         CGRect feeFrame=CGRectMake(ScreenWidth/7, 80+ScreenWidth/8+ScreenWidth*4/7+20, ScreenWidth*5/7, ScreenWidth*0.5) ;
        _feeview=[[FeeStdView alloc]initWithFrame:feeFrame dev_sn:@"1007" type:@"2"];
        [self.view addSubview:_feeview];

    }
    return _feeview;
}
-(void)showFee{
    self.isShow=!self.isShow;

    self.feeview.hidden=!self.isShow;
    
    
}
-(void)setupShadowView{
    UILabel*msgL=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, 30)];
    msgL.text=self.showMsg;
    msgL.font=[UIFont systemFontOfSize:18];
    msgL.textAlignment=NSTextAlignmentCenter;
    msgL.textColor=[UIColor blackColor];
    [self.view addSubview:msgL];
    //阴影框
    UIView*shadowView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/7, 80+ScreenWidth/8, ScreenWidth*5/7, ScreenWidth*4/7)];
    shadowView.backgroundColor=[UIColor whiteColor];
    shadowView.layer.cornerRadius=10;
    shadowView.layer.shadowColor=[UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset=CGSizeMake(0, 0);
    shadowView.layer.shadowOpacity=0.5;
    shadowView.layer.shadowRadius=5;
    [self.view addSubview:shadowView];
    
    //头像
    UIImageView*headerImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    headerImage.frame=CGRectMake(ScreenWidth*0.375, 80, ScreenWidth/4, ScreenWidth/4);
    headerImage.layer.cornerRadius=ScreenWidth/8;
    headerImage.layer.masksToBounds=YES;
    headerImage.layer.borderColor=JpColor(240, 240, 240).CGColor;
    headerImage.layer.borderWidth=4;
    [self.view addSubview:headerImage];
    
    UIButton*showFeeBtn=[[UIButton alloc]init];
    [showFeeBtn setTitle:@"查看收费标准" forState:UIControlStateNormal];
    [showFeeBtn setTitleColor:jpBlue forState:UIControlStateNormal];
    showFeeBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    showFeeBtn.frame=CGRectMake(5, ScreenWidth*4/7-45, ScreenWidth*5/14, 40);
    [showFeeBtn addTarget:self action:@selector(showFee) forControlEvents:UIControlEventTouchUpInside];
    [shadowView addSubview:showFeeBtn];
    
    [shadowView CXR_drawLineWithFrame:CGRectMake(0, ScreenWidth*4/7-50, ScreenWidth*5/7, 1) lineType:CXRLineHorizontal color:JpColor(240, 240, 240) lineWidth:1];

    [shadowView CXR_drawLineWithFrame:CGRectMake(ScreenWidth*5/14, ScreenWidth*4/7-50, 1, 50) lineType:CXRLineVertical color:JpColor(240, 240, 240) lineWidth:1];
   
    
    UIButton*payBtn=[[UIButton alloc]init];
    [payBtn setTitle:@"去充值" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    payBtn.frame=CGRectMake(ScreenWidth*5/14, ScreenWidth*4/7-45, ScreenWidth*5/14, 40);
    [shadowView addSubview:payBtn];
}
-(void)delQrCodeVC{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[QRcodeViewController class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
