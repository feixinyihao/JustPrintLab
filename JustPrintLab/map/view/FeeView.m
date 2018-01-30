//
//  FeeView.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/30.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "FeeView.h"
#import "FeeStdView.h"
@interface FeeView()
@property(nonatomic,weak)UIView*line;
@property(nonatomic,weak)FeeStdView*feestdview;
@property(nonatomic,copy)NSString*dev_sn;
@end
@implementation FeeView

-(instancetype)initWithFrame:(CGRect)frame dev_sn:(NSString*)dev_sn{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.dev_sn=dev_sn;
            for (int i=0; i<3; i++) {
                UIButton*printFee=[[UIButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/3, 0, ScreenWidth/3, 40)];
                switch (i) {
                    case 0:
                        [printFee setTitle:@"打印价格" forState:UIControlStateNormal];
                        printFee.selected=YES;
                        break;
                    case 1:
                        [printFee setTitle:@"复印价格" forState:UIControlStateNormal];
                        break;
                    case 2:
                        [printFee setTitle:@"扫描价格" forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                printFee.tag=800+i;
                printFee.titleLabel.font=[UIFont systemFontOfSize:13];
                [printFee setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [printFee setTitleColor:jpBlue forState:UIControlStateSelected];
                [printFee addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:printFee];
            }
            
            FeeStdView*feeview=[[FeeStdView alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 180) dev_sn:dev_sn type:@"2"];
            self.feestdview=feeview;
            [self addSubview:self.feestdview];
            
            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth/3, 2)];
            line.backgroundColor=jpBlue;
            self.line=line;
            [self addSubview:self.line];
            
        }
    }
    return self;
}

-(void)buttonClick:(UIButton*)sender{
    switch (sender.tag) {
        case 800:{
            if (!sender.selected) {
                [UIView animateWithDuration:0.25 animations:^{
                    [self.line setFrame:CGRectMake(0, 40, ScreenWidth/3, 2)];
                }];
                
                [self.feestdview removeFromSuperview];
                FeeStdView*feeview=[[FeeStdView alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 180) dev_sn:self.dev_sn type:@"2"];
                self.feestdview=feeview;
                [self addSubview:self.feestdview];
                sender.selected=YES;
                UIButton*btn=[self viewWithTag:801];
                btn.selected=NO;
                UIButton*btn2=[self viewWithTag:802];
                btn2.selected=NO;
            }
           
            
        }
            break;
        case 801:{
            if (!sender.selected) {
                [UIView animateWithDuration:0.25 animations:^{
                    [self.line setFrame:CGRectMake(ScreenWidth/3, 40, ScreenWidth/3, 2)];
                }];
                [self.feestdview removeFromSuperview];
                FeeStdView*feeview=[[FeeStdView alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 180) dev_sn:self.dev_sn type:@"3"];
                self.feestdview=feeview;
                [self addSubview:self.feestdview];
                sender.selected=YES;
                UIButton*btn=[self viewWithTag:800];
                btn.selected=NO;
                UIButton*btn2=[self viewWithTag:802];
                btn2.selected=NO;
            }
            
        }break;
        case 802:{
            if (!sender.selected) {
                [UIView animateWithDuration:0.25 animations:^{
                    [self.line setFrame:CGRectMake(ScreenWidth*2/3, 40, ScreenWidth/3, 2)];
                }];
                [self.feestdview removeFromSuperview];
                FeeStdView*feeview=[[FeeStdView alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 180) dev_sn:self.dev_sn type:@"4"];
                self.feestdview=feeview;
                [self addSubview:self.feestdview];
                sender.selected=YES;
                UIButton*btn=[self viewWithTag:800];
                btn.selected=NO;
                UIButton*btn2=[self viewWithTag:801];
                btn2.selected=NO;
            }
           
        }break;
        default:
            break;
    }
}
@end
