//
//  PayRec.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/9/11.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "PayRec.h"

@implementation PayRec
+(instancetype)PayRecWithDict:(NSDictionary* )dict{
    
    return [[self alloc]initWithDict:dict];
    
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    
    if (self=[super init]) {
        
        self.date=dict[@"date"];
        self.lsh=dict[@"lsh"];
        self.refund=dict[@"refund"];
        self.source=dict[@"source"];
        self.money=dict[@"money"];
    }
    return self;
}

@end
