//
//  PrintDetail.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/7/25.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrintDetail : NSObject
@property(nonatomic,copy)NSString*dwBWPages;
@property(nonatomic,copy)NSString*dwColorPages;
@property(nonatomic,copy)NSString*dwEstimateFee;
@property(nonatomic,copy)NSString*dwPaperID;
@property(nonatomic,copy)NSString*dwPaperNum;

+(instancetype)printdetailWithdic:(NSDictionary*)dic;
-(instancetype)initWithdic:(NSDictionary*)dic;
@end
