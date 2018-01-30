//
//  TradingHour.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/8/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradingHour : NSObject
@property(nonatomic,copy)NSString*dwBeginTime;
@property(nonatomic,copy)NSString*dwEndDay;
@property(nonatomic,copy)NSString*dwEndTime;
@property(nonatomic,copy)NSString*dwOpenFlag;
@property(nonatomic,copy)NSString*dwStartDay;
@property(nonatomic,copy)NSString*szMemo;


+(instancetype)tradingHourWithDict:(NSDictionary* )dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
