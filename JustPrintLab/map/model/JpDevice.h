//
//  JpDevice.h
//  CloudMap
//
//  Created by 陈鑫荣 on 2017/4/5.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFPFullInfo.h"
@interface JpDevice : NSObject
@property(nonatomic,copy)NSString* szName;
@property(nonatomic,copy)NSString*dwOpenTime;
@property(nonatomic,copy)NSString*dwCloseTime;
@property(nonatomic,copy)NSString*szPosi;
@property(nonatomic,copy)NSString*szTel;
@property(nonatomic,copy)NSString*szCoordinate;

/**
 1 打印 2 复印 4 扫描 8 照片 16 发票
 */
@property(nonatomic,assign)NSNumber* dwRole;

/**
 8 支持彩色
 */
@property(nonatomic,assign)NSNumber* dwProperty;

/**
65536 表示人工点
 */
@property(nonatomic,assign)int dwCtrlType;
@property(nonatomic,strong)MFPFullInfo*mfpFullInfo;
@property(nonatomic,copy)NSString*dwStatus;
@property(nonatomic,copy)NSString*szStatInfo;

/**
 403 表示理光内嵌  103 表示施乐内嵌  601 桌面打印机  503 照片打印
 */
@property(nonatomic,copy)NSString* dwModel;

/**
 打印点编号
 */
@property(nonatomic,copy)NSString*dwPrinterSN;
+(instancetype)JpDeviceWithDict:(NSDictionary* )dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
