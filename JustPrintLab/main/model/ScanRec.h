//
//  ScanRec.h
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/16.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanRec : NSObject
@property(nonatomic,copy)NSString* szDisplayName;
@property(nonatomic,copy)NSString* dwSubmitDate;
@property(nonatomic,copy)NSString* dwSubmitTime;
@property(nonatomic,copy)NSString* dwFileSize;
@property(nonatomic,copy)NSString* dwJobId;



+(instancetype)scanrecWith:(NSDictionary*)dic;
-(instancetype)initWithdic:(NSDictionary*)dic;
@end
