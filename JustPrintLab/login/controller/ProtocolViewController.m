//
//  ProtocolViewController.m
//  justprint
//
//  Created by 陈鑫荣 on 2018/1/18.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "ProtocolViewController.h"
#import <WebKit/WebKit.h>
#import <MBProgressHUD.h>
#import "UniHttpTool.h"
@interface ProtocolViewController ()<WKNavigationDelegate>

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.navTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
    UIButton*closeBtn=[[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithCustomView:closeBtn];
    self.navigationItem.leftBarButtonItem=left;
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    WKWebView*webview=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webview.navigationDelegate=self;
    webview.multipleTouchEnabled=YES;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Do any additional setup after loading the view.
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
