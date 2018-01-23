//
//  ScanRec.m
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/16.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "ScanRec.h"

@implementation ScanRec
+(instancetype)scanrecWith:(NSDictionary*)dic{
    
    return [[self alloc]initWithdic:dic];
}
-(instancetype)initWithdic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.szDisplayName=dic[@"szDisplayName"];
        self.dwSubmitDate=dic[@"dwSubmitDate"];
        self.dwSubmitTime=dic[@"dwSubmitTime"];
        self.dwFileSize=dic[@"dwFileSize"];
        self.dwJobId=dic[@"dwJobId"];
    }
    return self;
    
}

@end
