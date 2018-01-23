//
//  PrintDetail.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/7/25.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "PrintDetail.h"

@implementation PrintDetail



+(instancetype)printdetailWithdic:(NSDictionary*)dic{

    return [[self alloc]initWithdic:dic];
}
-(instancetype)initWithdic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.dwBWPages=dic[@"dwBWPages"];
        self.dwColorPages=dic[@"dwColorPages"];
        self.dwEstimateFee=dic[@"dwEstimateFee"];
        self.dwPaperID=dic[@"dwPaperID"];
        self.dwPaperNum=dic[@"dwPaperNum"];

    }
    return self;


}
@end
