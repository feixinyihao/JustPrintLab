//
//  LoginViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/7.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeTableViewController.h"
#import "HyperlinksButton.h"
#import "ProtocolViewController.h"
#import "CommonFunc.h"
#import "UniHttpTool.h"
#import "Account.h"
#import "MBProgressHUD+JP.h"
@interface LoginViewController ()
@property(nonatomic,weak)UIButton*yanBtn;
@property(nonatomic,weak)UITextField*userText;
@property(nonatomic,weak)UITextField*yanText;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setupLabel];
    [self setupTextField];
    [self setupBoom];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:userText];
    self.userText=userText;
    [self.view addSubview:self.userText];
    
    //验证码按钮
    UIButton*yanBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-120, ScreenHeight/3+10, 100, 40)];
    [yanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    yanBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [yanBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    yanBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    yanBtn.enabled=NO;
    [yanBtn addTarget:self action:@selector(getcode) forControlEvents:UIControlEventTouchUpInside];
    self.yanBtn=yanBtn;
    [self.view addSubview:self.yanBtn];
    
    
    UITextField*yanText=[[UITextField alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+80, ScreenWidth-60-100, 60)];
    yanText.placeholder=@"请输入验证码";
    yanText.keyboardType=UIKeyboardTypeNumberPad;
    self.yanText=yanText;
    [self.view addSubview:self.yanText];
    
    UIButton*nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70, ScreenHeight/3+10+80, 40, 40)];
    [nextBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [nextBtn addTarget:self action:@selector(logon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UIView*pswLine=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+80+60, ScreenWidth-60, 1)];
    pswLine.backgroundColor=JpColor(240, 240, 240);
    [self.view addSubview:pswLine];
    
    UILabel*xieyiL=[[UILabel alloc]initWithFrame:CGRectMake(30, ScreenHeight/3+80+60+20, ScreenWidth, 15)];
    xieyiL.text=@"注册，即表示同意";
    xieyiL.font=[UIFont systemFontOfSize:12];
    xieyiL.textColor=[UIColor lightGrayColor];
    [self.view addSubview:xieyiL];
    
    HyperlinksButton*xieyiBtn=[[HyperlinksButton alloc]initWithFrame:CGRectMake(120, ScreenHeight/3+80+60+20, 90, 15)];
    [xieyiBtn setTitle:@"justprint协议" forState:UIControlStateNormal];
    xieyiBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [xieyiBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:xieyiBtn];
    [xieyiBtn addTarget:self action:@selector(protocol) forControlEvents:UIControlEventTouchUpInside];
    
    
   
}
//监听手机输入框改变
- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
    if ([CommonFunc isPhoneNum:textField.text]) {
        [self.yanBtn setTitleColor:mainColor forState:UIControlStateNormal];
        self.yanBtn.enabled=YES;
    }else{
        [self.yanBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.yanBtn.enabled=NO;
    }
    
}

/**
 获取验证码
 */
-(void)getcode{
    
    [self openCountdown];
    NSString*url=[NSString stringWithFormat:@"%@/ajax/util.aspx?act=send_sms&phone=%@",RootURL,self.userText.text];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        DLog(@"%@",json);
    } failure:^(NSError *error) {
        
    }];
}

/**
 登录
 */
-(void)logon{
    
    NSString*url=[NSString stringWithFormat:@"%@/ajax/cac.aspx?act=register",RootURL];
    NSDictionary*parm=@{@"pid":self.userText.text,@"sms":self.yanText.text,@"pwd":self.userText.text};
    
    [UniHttpTool getWithUrl:url parameters:parm progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        DLog(@"%@",json);
        if ([json[@"ret"] integerValue]==1) {
            Account* acc=[[Account alloc]initWithDic:json[@"data"]];
            NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
            [NSKeyedArchiver archiveRootObject:acc toFile:file];
            HomeTableViewController*home=[[HomeTableViewController alloc]init];
            self.view.window.rootViewController=home;
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            if (json[@"msg"]!=[NSNull null]) {
               
                [MBProgressHUD showText:json[@"msg"]];
            }
        }
    } failure:^(NSError *error) {
        
    }];
   
    
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        NSString*title=@"重新发送";
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.yanBtn setTitle:title forState:UIControlStateNormal];
                self.yanBtn.enabled = YES;
                self.yanBtn.userInteractionEnabled=YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.yanBtn setTitle:[NSString stringWithFormat:@"%@(%.2d)",title, seconds] forState:UIControlStateNormal];
                self.yanBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
/**
 注册协议
 */
-(void)protocol{
    ProtocolViewController*protocol=[[ProtocolViewController alloc]init];
    protocol.url=[NSString stringWithFormat:@"%@/reg_protocol.html",RootURL];
    protocol.navTitle=@"justprint注册协议";
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:protocol];
    [self presentViewController:nav animated:YES completion:nil];
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
