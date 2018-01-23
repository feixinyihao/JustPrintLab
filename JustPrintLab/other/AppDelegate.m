//
//  AppDelegate.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/6.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setMainInterface];
    return YES;
}
-(void)setMainInterface{
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    LaunchViewController*launch=[[LaunchViewController alloc]init];
    self.window.rootViewController=launch;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
