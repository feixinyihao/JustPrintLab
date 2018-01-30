//
//  Feedetail.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/7/26.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feedetail : NSObject

/**
 彩色费
 */
@property(nonatomic,copy)NSString*dwColorFee;

/**
 材料费（纸张费）
 */
@property(nonatomic,copy)NSString*dwMaterialFee;

/**
 黑白费
 */
@property(nonatomic,copy)NSString*dwMonoFee;

/**
 纸张大小：8表示A3，9表示A4，260表示发票纸，0表示扫描
 */
@property(nonatomic,copy)NSString*dwPaperID;

/**
 打印站点
 */
@property(nonatomic,copy)NSString*dwPrinterSN;

/**
 收费名称
 */
@property(nonatomic,copy)NSString*szFeeName;

/**
 收费类型（打印，复印，扫描）
 */

/**
 证件复印费率
 */
@property(nonatomic,copy)NSString*dwIDFeeRate;
@property(nonatomic,copy)NSString*dwFeeItemSN;
+(instancetype)feedetailWithDict:(NSDictionary* )dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
