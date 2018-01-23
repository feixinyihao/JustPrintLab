//
//  PrintJob.m
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "PrintJob.h"

@implementation PrintJob

+(instancetype)printjobWithdic:(NSDictionary*)dic{
    return [[self alloc]initWithdic:dic];

}
-(instancetype)initWithdic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.szDocument=dic[@"szDocument"];
        self.dwSubmitTime=dic[@"dwSubmitTime"];
        self.dwRandomCode=dic[@"dwRandomCode"];
        self.dwSubmitDate=dic[@"dwSubmitDate"];
        self.dwJobId=dic[@"dwJobId"];
        self.szJobFileName=dic[@"szJobFileName"];
        self.dwCopies=dic[@"dwCopies"];
        self.dwPages=dic[@"dwPages"];
        self.dwPaperID=dic[@"dwPaperID"];
        self.dwStatus=dic[@"dwStatus"];
        self.szMemo=dic[@"szMemo"];
        NSArray*temparr=dic[@"PrintDetail"];
        
        self.printdetail= [PrintDetail printdetailWithdic:temparr.lastObject];
        
    }
    return self;

}

@end
