//
//  LaunchViewController.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/11/14.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "LaunchViewController.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import "DrawCircleProgressButton.h"
#import "LoginViewController.h"
#import "Account.h"
#import "HomeTableViewController.h"
@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/version.json"];//获取json文件保存的路径
    NSString *imgUrlString =@"http://justprint.com.cn/lang/default/default.png";
    if ([self isFileExist:@"version.json"]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];//获取指定路径的data文件
        id verjson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        imgUrlString=verjson[@"launchImage"];
    }
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
  //  [imageview sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"Launch"]];
    [[SDWebImageManager sharedManager]diskImageExistsForURL:[NSURL URLWithString:imgUrlString] completion:^(BOOL isInCache) {
        if (isInCache) {
            [imageview sd_setImageWithURL:[NSURL URLWithString:imgUrlString]];
        }else{
            [imageview setImage:[UIImage imageNamed:@"Launch"]];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager loadImageWithURL:[NSURL URLWithString:imgUrlString] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            }];
        }
    }];
   
    [self.view addSubview:imageview];
    CGFloat y=kIs_iPhoneX?54:30;
    DrawCircleProgressButton *drawCircleView = [[DrawCircleProgressButton alloc]initWithFrame:CGRectMake(ScreenWidth - 55, y, 40, 40)];
    drawCircleView.lineWidth = 2;
    drawCircleView.progressColor=mainColor;
    NSString*skip=@"跳过";
    [drawCircleView setTitle:skip forState:UIControlStateNormal];
    [drawCircleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    drawCircleView.titleLabel.font = [UIFont systemFontOfSize:14];
    [drawCircleView addTarget:self action:@selector(removeProgress) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *  progress 完成时候的回调
     */
    [drawCircleView startAnimationDuration:2 withBlock:^{
        [self setMainWindow];
    }];
    
    [self.view addSubview:drawCircleView];
    
}
//判断文件是否已经在沙盒中已经存在？
-(BOOL) isFileExist:(NSString *)fileName
{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    return [fileManager fileExistsAtPath:filePath];
    
}
-(void)removeProgress{
    
    [self setMainWindow];
}

-(void)setMainWindow{

    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (acc) {
        if (![acc.token isKindOfClass:[NSNull class]]&&acc.token) {
            HomeTableViewController*home=[[HomeTableViewController alloc]init];
            self.view.window.rootViewController=home;
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            LoginViewController*login=[[LoginViewController alloc]init];
            UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:login];
            self.view.window.rootViewController=nav;
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }else{
        LoginViewController*login=[[LoginViewController alloc]init];
        UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:login];
        self.view.window.rootViewController=nav;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
