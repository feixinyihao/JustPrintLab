//
//  PrintJob.h
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrintDetail.h"
@interface PrintJob : NSObject
@property(nonatomic,copy)NSString*dwSubmitDate;
@property(nonatomic,copy)NSString*dwSubmitTime;
@property(nonatomic,copy)NSString*szDocument;
@property(nonatomic,copy)NSString*dwRandomCode;
@property(nonatomic,copy)NSString*dwJobId;
@property(nonatomic,copy)NSString*szJobFileName;
@property(nonatomic,copy)NSString*dwStatus;
@property(nonatomic,copy)NSString*szMemo;

/**
 份数
 */
@property(nonatomic,copy)NSString*dwCopies;

/**
 页数
 */
@property(nonatomic,copy)NSString*dwPages;
/**
 纸张大小，9表示A4，8表示A3
 */
@property(nonatomic,copy)NSString*dwPaperID;

@property(nonatomic,strong)PrintDetail*printdetail;



+(instancetype)printjobWithdic:(NSDictionary*)dic;
-(instancetype)initWithdic:(NSDictionary*)dic;
@end
