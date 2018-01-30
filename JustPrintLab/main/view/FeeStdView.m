//
//  ShowFeeStd.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/27.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "FeeStdView.h"
#import "UniHttpTool.h"
#import "UIView+cxr.h"
#import "Feedetail.h"
@implementation FeeStdView

-(instancetype)initWithFrame:(CGRect)frame dev_sn:(NSString*)dev_sn type:(NSString*)type{
    if ([super initWithFrame:frame]) {
        if (self) {
            [self getFeeStd:dev_sn type:type];
            self.backgroundColor=[UIColor whiteColor];
    
            self.layer.shadowColor=[UIColor blackColor].CGColor;
            self.layer.shadowOffset=CGSizeMake(0, 0);
            self.layer.shadowOpacity=0.5;
            self.layer.shadowRadius=5;
        }
    }
    return self;
}
/**
 获取打印点的收费标准

 @param dev_sn 打印点编号
 @param type 获取收费标准类型（0：全部 2：打印 3：复印 4：扫描）
 */
-(void)getFeeStd:(NSString*)dev_sn type:(NSString*)type{
    NSString*url=[NSString stringWithFormat:@"%@/ajax/print.aspx?fee_type=%@&dev_sn=%@&act=get_fee_std",RootURL,type,dev_sn];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        NSArray*dataArr=json[@"data"];
        //DLog(@"%@",dataArr);
        NSMutableArray * tempDataArr = [[NSMutableArray alloc]initWithObjects:@"类型",@"彩色",@"黑白",nil];
        NSString*monoStr=@"";
        NSString*colorStr=@"";
        BOOL isSupportInvoice=NO;
        for (int i=0; i<dataArr.count; i++) {
            Feedetail*feedetail=[Feedetail feedetailWithDict:dataArr[i]];
            [tempDataArr addObject:feedetail.szFeeName];
            [tempDataArr addObject:[NSString stringWithFormat:@"%.2f元/页",[feedetail.dwColorFee integerValue]/100.0]];
            [tempDataArr addObject:[NSString stringWithFormat:@"%.2f元/页",[feedetail.dwMonoFee integerValue]/100.0]];
          
            if ([feedetail.dwFeeItemSN integerValue]==3&&[feedetail.dwPaperID integerValue]==9) {
                monoStr=[NSString stringWithFormat:@"%.2f元/页",[feedetail.dwMonoFee integerValue]*[feedetail.dwIDFeeRate integerValue]/10000.0];
                colorStr=[NSString stringWithFormat:@"%.2f元/页",[feedetail.dwColorFee integerValue]*[feedetail.dwIDFeeRate integerValue]/10000.0];
            }
            if ([feedetail.dwPaperID integerValue]==260) {
                isSupportInvoice=YES;
            }
        }
        NSInteger columns=dataArr.count+1;
        if ([type integerValue]==3&&dataArr.count>0) {
            [tempDataArr addObject:@"证件复印"];
            [tempDataArr addObject:colorStr];
            [tempDataArr addObject:monoStr];
            columns=dataArr.count+2;
            [self CXR_drawListWithRect:self.bounds line:3 columns:columns datas:tempDataArr colorInfo:nil lineInfo:nil backgroundColorInfo:@{@"0":JpColor(240, 240, 240),@"1":JpColor(240, 240, 240),@"2":JpColor(240, 240, 240)}];
        }else if([type integerValue]==2&&isSupportInvoice&&dataArr.count>1){
            [self CXR2_drawListWithRect:self.bounds line:3 columns:columns datas:tempDataArr colorInfo:nil lineInfo:@{@"3":@"2"} backgroundColorInfo:@{@"0":JpColor(240, 240, 240),@"1":JpColor(240, 240, 240),@"2":JpColor(240, 240, 240)}];
        }else if ([type integerValue]==2&&isSupportInvoice&&dataArr.count==1){
             [self CXR2_drawListWithRect:self.bounds line:3 columns:columns datas:tempDataArr colorInfo:nil lineInfo:@{@"1":@"2"} backgroundColorInfo:@{@"0":JpColor(240, 240, 240),@"1":JpColor(240, 240, 240),@"2":JpColor(240, 240, 240)}];
        }
        else if([type integerValue]==4&&dataArr.count>0){
            [self CXR2_drawListWithRect:self.bounds line:3 columns:columns datas:tempDataArr colorInfo:nil lineInfo:@{@"1":@"2"} backgroundColorInfo:@{@"0":JpColor(240, 240, 240),@"1":JpColor(240, 240, 240),@"2":JpColor(240, 240, 240)}];
        }else{
            [self CXR_drawListWithRect:self.bounds line:3 columns:columns datas:tempDataArr colorInfo:nil lineInfo:nil backgroundColorInfo:@{@"0":JpColor(240, 240, 240),@"1":JpColor(240, 240, 240),@"2":JpColor(240, 240, 240)}];
        }
      
    } failure:^(NSError *error) {
        
    }];
}

@end
