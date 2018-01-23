//
//  Account.h
//  CloudMap
//
//  Created by 陈鑫荣 on 2017/4/6.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
@property(nonatomic,copy)NSString* accno;
@property(nonatomic,copy)NSString* balance;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* phone;
@property(nonatomic,copy)NSString* pid;
@property(nonatomic,copy)NSString* subsidy;
@property(nonatomic,copy)NSString* wechat;
@property(nonatomic,copy)NSString* token;
@property(nonatomic,copy)NSString*headimgurl;
@property(nonatomic,copy)NSString*nickname;

+(instancetype)accountWithDic:(NSDictionary* )dic;
-(instancetype)initWithDic:(NSDictionary*)dic;


@end
