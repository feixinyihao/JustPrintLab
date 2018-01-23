//
//  SetupTableViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/20.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "SetupTableViewController.h"
#import "LoginViewController.h"
#import <StoreKit/StoreKit.h>
#import "ProtocolViewController.h"
#import "BaseNavigationController.h"
#import "CommonFunc.h"
@interface SetupTableViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==2) {
        return 1;
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"setup"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setup"];
    }
    switch (indexPath.section) {
           
        case 0:{
            NSArray*titleArr=@[@"去评分",@"充值协议"];
            cell.textLabel.text=titleArr[indexPath.row];
        }
            break;
        case 1:{
            NSArray*titleArr=@[@"清除缓存",@"关于JustPrint"];
            cell.textLabel.text=titleArr[indexPath.row];
        }
            break;
        case 2:{
            cell.textLabel.text=@"退出";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=JpColor(240, 240, 240);
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 2:
            [self alert];
            break;
        case 0:{
            switch (indexPath.row) {
                case 0:
                    [self loadAppStoreController];
                    break;
                case 1:{
                    NSString*url=[NSString stringWithFormat:@"%@/lang/zh-Hans-CN/rech_protocol.html",RootURL];
                    ProtocolViewController *protocol=[[ProtocolViewController alloc]init];
                    protocol.navTitle=@"充值协议";
                    BaseNavigationController*nav=[[BaseNavigationController alloc]initWithRootViewController:protocol];
                    protocol.url=url;
                    [self presentViewController:nav animated:YES completion:nil];
                }break;
                    
                default:
                    break;
            }
        }
            
        default:
            break;
    }
}
-(void)alert{
    
    NSString*logoutMessage=@"确定退出吗？";
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:logoutMessage message:@"" preferredStyle:UIAlertControllerStyleAlert];//创建界面
    NSString*signout=@"确定";
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:signout style:UIAlertActionStyleDefault handler:^(UIAlertAction *acton){
        
        [CommonFunc backToLogon];
    }];
    NSString*cancel=@"取消";
    UIAlertAction *otherAction=[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction *acton){}];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController: alertController animated:YES completion:nil];
}

- (void)loadAppStoreController{

    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    storeProductViewContorller.delegate = self;
    [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:kAppId} completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (error) {
            DLog(@"erroe_%@",[error userInfo]);
        }else{
            [self presentViewController:storeProductViewContorller animated:YES completion:nil];
        }
    }];
   
            
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController

{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end
