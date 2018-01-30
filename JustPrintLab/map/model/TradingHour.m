//
//  TradingHour.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/8/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "TradingHour.h"

@implementation TradingHour


+(instancetype)tradingHourWithDict:(NSDictionary* )dict{

      return [[self alloc]initWithDict:dict];

}
-(instancetype)initWithDict:(NSDictionary*)dict{
    
    if (self=[super init]) {
        self.dwBeginTime=dict[@"dwBeginTime"];
        self.dwEndDay=dict[@"dwEndDay"];
        self.dwEndTime=dict[@"dwEndTime"];
        self.dwOpenFlag=dict[@"dwOpenFlag"];
        self.dwStartDay=dict[@"dwStartDay"];
        self.szMemo=dict[@"szMemo"];
    }
    return self;

}
@end
