//
//  MBProgressHUD+JP.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/22.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "MBProgressHUD+JP.h"
#import "CommonFunc.h"
@implementation MBProgressHUD (JP)

+(void)showText:(NSString*)text{
    UIWindow*window=[[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[CommonFunc getCurrentVC].view animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.margin=10;
    hud.label.text=text;
    [hud hideAnimated:YES afterDelay:3.f];
}
@end
