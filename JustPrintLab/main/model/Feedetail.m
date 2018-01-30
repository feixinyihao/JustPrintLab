//
//  Feedetail.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/7/26.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "Feedetail.h"

@implementation Feedetail

+(instancetype)feedetailWithDict:(NSDictionary* )dict{

    return [[self alloc]initWithDict:dict];
    
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self=[super init]) {
        self.dwColorFee=dict[@"dwColorFee"];
        self.dwMaterialFee=dict[@"dwMaterialFee"];
        self.dwMonoFee=dict[@"dwMonoFee"];
        self.dwPaperID=dict[@"dwPaperID"];
        self.dwPrinterSN=dict[@"dwPrinterSN"];
        self.szFeeName=dict[@"szFeeName"];
        self.dwFeeItemSN=dict[@"dwFeeItemSN"];
        self.dwIDFeeRate=dict[@"dwIDFeeRate"];
    }
    return self;

}
@end
