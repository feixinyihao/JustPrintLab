//
//  HomeHeaderView.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/20.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "HomeHeaderView.h"
#import "CustomButton.h"
@implementation HomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor=[UIColor whiteColor];
            NSArray*imageArr=@[@"photo_btn",@"wait_zj",@"wait_fp",@"wait_zp",@"scan_btn"];
            NSArray*titleArr=@[@"文档打印",@"证件打印",@"电子发票",@"照片打印",@"扫一扫"];
            for (int i=0; i<imageArr.count; i++) {
                
                CustomButton*btn=[[CustomButton alloc]init];
                [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
                [btn setTitle:titleArr[i] forState:UIControlStateNormal];
                btn.frame=CGRectMake(ScreenWidth/12+ScreenWidth*(i%3)/3, 20+(i/3)*2*ScreenWidth/6, ScreenWidth/6, ScreenWidth*1.45/6);
                btn.tag=1000+i;
                [btn addTarget:self action:@selector(HomeHeaderViewButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                
            }
        }
    }
    return self;
}
-(void)HomeHeaderViewButton:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(HomeHeaderViewButton:)]) {
        [self.delegate HomeHeaderViewButton:button];
        
    }
 
}

@end
