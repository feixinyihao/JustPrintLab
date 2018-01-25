//
//  HomeMidView.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/20.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "HomeMidView.h"

@implementation HomeMidView


-(instancetype)initWithFrame:(CGRect)frame withImageName:(NSString*)imageName withTitleName: (NSString*)titleName withMsgNmae:(NSString*)msgName{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor=[UIColor whiteColor];
            self.layer.cornerRadius=5;
            CGFloat scale=ScreenWidth/375;
            UIImageView*scanImage=[[UIImageView alloc]initWithFrame:CGRectMake(20*scale, 20*scale, (ScreenWidth-10)/4-40*scale, (ScreenWidth-10)/4-40*scale)];
            [scanImage setImage:[UIImage imageNamed:imageName]];
            [self addSubview:scanImage];
            
            UILabel*scanTitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-10)/4-20*scale, 20*scale, 100*scale, 25*scale)];
            [scanTitle setText:titleName];
            scanTitle.font=[UIFont systemFontOfSize:14];
            scanTitle.textColor=[UIColor blackColor];
            [self addSubview:scanTitle];
            
            UILabel*msgTitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-10)/4-20*scale, scale*50, 120*scale, 15*scale)];
            [msgTitle setText:msgName];
            msgTitle.font=[UIFont systemFontOfSize:10];
            msgTitle.textColor=[UIColor blackColor];
            [self addSubview:msgTitle];
        }
    }
    return self;
}
@end
