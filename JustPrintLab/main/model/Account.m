//
//  Account.m
//  CloudMap
//
//  Created by 陈鑫荣 on 2017/4/6.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "Account.h"

@implementation Account

+(instancetype)accountWithDic:(NSDictionary* )dic{
    
    return [[self alloc]initWithDic:dic];

}
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.accno=dic[@"accno"];
        self.balance=[NSString stringWithFormat:@"%@",(NSNumber*)dic[@"balance"]];
        self.email=dic[@"email"];
        self.name=dic[@"name"];
        self.phone=dic[@"phone"];
        self.pid=dic[@"pid"];
        self.subsidy=[NSString stringWithFormat:@"%@",(NSNumber*)dic[@"subsidy"]];
        self.wechat=dic[@"wechat"];
        self.token=dic[@"token"];
        self.nickname=dic[@"nickname"];
        self.headimgurl=dic[@"headimgurl"];
        
    }
    return self;

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self=[super init]) {
        self.accno=[aDecoder decodeObjectForKey:@"accno"];
        self.balance=[aDecoder decodeObjectForKey:@"balance"];
        self.email=[aDecoder decodeObjectForKey:@"email"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.phone=[aDecoder decodeObjectForKey:@"phone"];
        self.pid=[aDecoder decodeObjectForKey:@"pid"];
        self.subsidy=[aDecoder decodeObjectForKey:@"subsidy"];
        self.wechat=[aDecoder decodeObjectForKey:@"wechat"];
        self.token=[aDecoder decodeObjectForKey:@"token"];
        self.nickname=[aDecoder decodeObjectForKey:@"nickname"];
        self.headimgurl=[aDecoder decodeObjectForKey:@"headimgurl"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accno forKey:@"accno"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.pid forKey:@"pid"];
    [aCoder encodeObject:self.subsidy forKey:@"subsidy"];
    [aCoder encodeObject:self.wechat forKey:@"wechat"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.headimgurl forKey:@"headimgurl"];
}

@end
