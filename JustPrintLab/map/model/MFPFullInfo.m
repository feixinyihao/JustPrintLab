//
//  MFPFullInfo.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/8/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "MFPFullInfo.h"

@implementation MFPFullInfo


+(instancetype)mfpFullInfoWithDict:(NSDictionary* )dict{
    
      return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self=[super init]) {
        self.FeeRateArr=dict[@"FeeRate"];
        self.TonerInfo=dict[@"TonerInfo"];
        self.TradingHourArr=dict[@"TradingHour"];
        self.TrayInfo=dict[@"TrayInfo"];
       
    }
    return self;

}
@end
