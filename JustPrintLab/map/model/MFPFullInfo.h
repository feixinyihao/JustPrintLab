//
//  MFPFullInfo.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/8/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFPFullInfo : NSObject
@property(nonatomic,strong)NSArray*FeeRateArr;
@property(nonatomic,copy)NSString*TonerInfo;
@property(nonatomic,strong)NSArray*TradingHourArr;
@property(nonatomic,copy)NSString*TrayInfo;


+(instancetype)mfpFullInfoWithDict:(NSDictionary* )dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
