//
//  JpDevice.m
//  CloudMap
//
//  Created by 陈鑫荣 on 2017/4/5.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "JpDevice.h"
@interface JpDevice()

@end


@implementation JpDevice
+(instancetype)JpDeviceWithDict:(NSDictionary* )dict{
    
    return [[self alloc]initWithDict:dict];

}
-(instancetype)initWithDict:(NSDictionary*)dict{

    if (self=[super init]) {
        self.szName=dict[@"szName"];
        self.szTel=dict[@"szTel"];
        self.szPosi=dict[@"szPosi"];
        self.szCoordinate=dict[@"szCoordinate"];
        self.dwOpenTime=dict[@"dwOpenTime"];
        self.dwCloseTime=dict[@"dwCloseTime"];
        self.dwRole=(NSNumber*)dict[@"dwRole"] ;
        self.dwProperty=(NSNumber*)dict[@"dwProperty"];
        self.dwCtrlType=(int)dict[@"dwCtrlType"];
        self.mfpFullInfo=[MFPFullInfo mfpFullInfoWithDict:dict[@"MFPFullInfo"]];
        self.dwStatus=dict[@"dwStatus"];
        self.szStatInfo=dict[@"szStatInfo"];
        self.dwModel=dict[@"dwModel"];
        self.dwPrinterSN=dict[@"dwPrinterSN"];     
    }
    return self;
}
@end
