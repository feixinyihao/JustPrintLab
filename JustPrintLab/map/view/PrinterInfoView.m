//
//  PrinterInfoView.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/29.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "PrinterInfoView.h"
#import "JpDevice.h"
@interface PrinterInfoView()

@property(nonatomic,strong)JpDevice*device;
@end

@implementation PrinterInfoView


-(instancetype)initWithFrame:(CGRect)frame device:(JpDevice*)device{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.device=device;
            self.backgroundColor=[UIColor whiteColor];
            self.alpha=0.9;
            self.layer.cornerRadius=5;
            self.layer.masksToBounds=YES;
            
            UILabel*titleL=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, ScreenWidth-20, 20)];
            titleL.text=device.szName;
            titleL.font=[UIFont systemFontOfSize:17];
            [self addSubview:titleL];
            
            UILabel*datialTitleL=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, ScreenWidth-50, 20)];
            datialTitleL.text=device.szPosi;
            datialTitleL.textColor=[UIColor grayColor];
            datialTitleL.font=[UIFont systemFontOfSize:12];
            [self addSubview:datialTitleL];
            
            
            UIButton*detailBtn=[[UIButton alloc]init];
            detailBtn.frame=CGRectMake(ScreenWidth-30, 30, 30, 20);
            [detailBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
            [self addSubview:detailBtn];
            [self setupFunctionView:device];
            
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PrinterInfoViewClick:)];
            [self addGestureRecognizer:tapGesturRecognizer];
        }
    }
    return self;
}

-(void)setupFunctionView:(JpDevice*)device{
    NSMutableArray*roleArr=[NSMutableArray array];
    if ((1&[device.dwRole integerValue])==1) {
        [roleArr addObject:@"打印"];
    }
    if((2&[device.dwRole integerValue])==2){
        [roleArr addObject:@"复印"];
    }
    if ((4&[device.dwRole integerValue])==4){
        [roleArr addObject:@"扫描"];
    }
    if((8&[device.dwRole integerValue])==8){
        [roleArr addObject:@"照片"];
    }
    if ((16&[device.dwRole integerValue])==16){
        [roleArr addObject:@"发票"];
    }
    if ((8&[device.dwProperty integerValue])==8){
        [roleArr addObject:@"支持彩色"];
    }
    if((65536&device.dwCtrlType)==65536){
         [roleArr addObject:@"人工点"];
    }
    CGRect rect=CGRectMake(0, 0, 0, 0);
    for (int i=0; i<roleArr.count; i++) {
        UILabel*roleL=[[UILabel alloc]init];
        roleL.text=roleArr[i];
        roleL.font=[UIFont systemFontOfSize:12];
        roleL.backgroundColor=[jpBlue colorWithAlphaComponent:0.2];
        roleL.textColor=jpBlue;
        roleL.textAlignment=NSTextAlignmentCenter;
        roleL.layer.cornerRadius=3;
        roleL.layer.masksToBounds=YES;
        CGSize size=[roleL.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
        roleL.frame=CGRectMake(rect.size.width+rect.origin.x+10, 52, size.width+10, 20);
        if ([roleArr[i] isEqualToString:@"支持彩色"]) {
            roleL.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.2];
            roleL.textColor=[UIColor redColor];
        }
        if ([roleArr[i] isEqualToString:@"人工点"]) {
            roleL.backgroundColor=[[UIColor orangeColor] colorWithAlphaComponent:0.2];
            roleL.textColor=[UIColor orangeColor];
        }
        rect=roleL.frame;
        [self addSubview:roleL];
    }
}

-(void)PrinterInfoViewClick:(JpDevice*)device{
    if ([self.delegate respondsToSelector:@selector(PrinterInfoViewClick:)]) {
        [self.delegate PrinterInfoViewClick:self.device];
    }
}
-(JpDevice *)device{
    if (_device==nil) {
        _device=[[JpDevice alloc]init];
    }
    return _device;
}
@end
