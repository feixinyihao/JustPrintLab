//
//  HomeTableViewController.m
//  IM
//
//  Created by 陈鑫荣 on 2017/12/1.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "HomeTableViewController.h"
#import "ViewController.h"
#import "MapViewController.h"
#import "WalletViewController.h"
#import "MeViewController.h"
#import "BaseNavigationController.h"
@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
/**
 *  初始化一个子控制器
 */
-(void)SetupChildViewConterller:(UIViewController * )childView title:(NSString*)title  imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName{
    self.tabBar.tintColor=[UIColor blackColor];
   // childView.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 2, 0);
    [childView.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    childView.title=title;
    
    childView.tabBarItem.image=[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childView.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController * childViewNav=[[BaseNavigationController alloc]initWithRootViewController:childView];
    [self addChildViewController:childViewNav];
    
}
/**
 *  初始化所有子控制器
 */
-(void)setupAllChildView{
   
    
    ViewController*viewcontrol=[[ViewController alloc]init];
    [self SetupChildViewConterller:viewcontrol title:@"首页" imageName:@"home" selectedImageName:@"homeSelected"];
    
    MapViewController*map=[[MapViewController alloc]init];
    [self SetupChildViewConterller:map title:@"文印点" imageName:@"station" selectedImageName:@"stationSelected"];
    
    WalletViewController*wallet=[[WalletViewController alloc]init];
    [self SetupChildViewConterller:wallet title:@"钱包" imageName:@"home_wallet" selectedImageName:@"home_walletSelected"];
    
    MeViewController*me=[[MeViewController alloc]init];
    [self SetupChildViewConterller:me title:@"我的" imageName:@"me" selectedImageName:@"meSelected"];
    
}



@end
