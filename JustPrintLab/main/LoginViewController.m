//
//  LoginViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/7.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeTableViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setupLabel];
    [self setupTextField];
    [self setupBoom];
}

-(void)setBackGround{
    UIImageView*backGround=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LoginLayer"]];
    backGround.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:backGround];
    
}

/**
 输入框
 */
-(void)setupTextField{
    UIView*userLine=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+60, ScreenWidth-60, 1)];
    userLine.backgroundColor=JpColor(240, 240, 240);
    [self.view addSubview:userLine];
    UITextField*userText=[[UITextField alloc]initWithFrame:CGRectMake(30, ScreenHeight/3, ScreenWidth-60-100, 60)];
    userText.placeholder=@"请输入手机号";
    userText.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:userText];
    
    //验证码按钮
    UIButton*yanBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-120, ScreenHeight/3+10, 100, 40)];
    [yanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    yanBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [yanBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    yanBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:yanBtn];
    
    
    UITextField*yanText=[[UITextField alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+80, ScreenWidth-60-100, 60)];
    yanText.placeholder=@"请输入验证码";
    yanText.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:yanText];
    
    UIButton*nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70, ScreenHeight/3+10+80, 40, 40)];
    [nextBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [nextBtn addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:nextBtn];
    
    UIView*pswLine=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+80+60, ScreenWidth-60, 1)];
    pswLine.backgroundColor=JpColor(240, 240, 240);
    [self.view addSubview:pswLine];
    
    UILabel*xieyiL=[[UILabel alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+80+60+20, ScreenWidth, 15)];
    xieyiL.text=@"注册，即表示同意";
    xieyiL.font=[UIFont systemFontOfSize:10];
    xieyiL.textColor=[UIColor lightGrayColor];
    [self.view addSubview:xieyiL];
    
    UIButton*xieyiBtn=[[UIButton alloc]initWithFrame:CGRectMake(110, ScreenHeight/3+80+60+20, 68, 15)];
    [xieyiBtn setTitle:@"justprint协议" forState:UIControlStateNormal];
    xieyiBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [xieyiBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:xieyiBtn];
    
    UIView*xieyiLine=[[UIView alloc]initWithFrame:CGRectMake(110, ScreenHeight/3+80+60+20+13, 65, 1)];
    xieyiLine.backgroundColor=JpColor(230, 230, 230);
    [self.view addSubview:xieyiLine];
   
}

/**
 快速登录
 */
-(void)setupBoom{
    UIView*lineleft=[[UIView alloc]init];
    lineleft.backgroundColor=JpColor(220, 220, 220);
    lineleft.frame=CGRectMake(10, ScreenHeight-60-20, ScreenWidth/2-40, 1);
    [self.view addSubview:lineleft];
    UILabel*fastLogin=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-30, ScreenHeight-60-20-10, 60, 20)];
    fastLogin.text=@"快速登录";
    fastLogin.textAlignment=NSTextAlignmentCenter;
    fastLogin.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:fastLogin];
    UIView*lineright=[[UIView alloc]init];
    lineright.backgroundColor=JpColor(220, 220, 220);
    lineright.frame=CGRectMake(ScreenWidth/2+30, ScreenHeight-60-20, ScreenWidth/2-40, 1);
    [self.view addSubview:lineright];
    //微信登录
    CGFloat space=(ScreenWidth-120)/2;
    UIButton *wechatBtn=[[UIButton alloc]initWithFrame:CGRectMake(space, ScreenHeight-60, 40, 40)];
    [wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [wechatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:wechatBtn];
    
    //支付宝登录
    UIButton *alipayBtn=[[UIButton alloc]initWithFrame:CGRectMake(space+80, ScreenHeight-60, 40, 40)];
    [alipayBtn setImage:[UIImage imageNamed:@"alipay"] forState:UIControlStateNormal];
   
    [alipayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alipayBtn];
}
-(void)setupLabel{
    UILabel*titleL=[[UILabel alloc]initWithFrame:CGRectMake(30, 80, ScreenWidth,40)];
    titleL.text=@"登录&注册";
    titleL.font=[UIFont fontWithName:@"ArialMT" size:28];
    [self.view addSubview:titleL];
    
}

/**
 登录认证成功
 */
-(void)loginSuccess{
    
    HomeTableViewController*home=[[HomeTableViewController alloc]init];

    self.view.window.rootViewController=home;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
