//
//  SelectedButton.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/25.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "SelectedButton.h"


@implementation SelectedButton

-(SelectedButton*)initWithButtonWithTitle1:(NSString*)title1 title2:(NSString*)title2 selected:(BOOL)selected withTag:(NSInteger)tag{
    if (self=[super init]) {
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.frame=[UIScreen mainScreen].bounds;
        UIButton*button1=[[UIButton alloc]initWithFrame:CGRectMake(80, (ScreenHeight-64-180)/2, ScreenWidth-160, 60)];
        UIButton*button2=[[UIButton alloc]initWithFrame:CGRectMake(80, (ScreenHeight-64-180)/2+60, ScreenWidth-160, 60)];
        UIButton*cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(80, (ScreenHeight-64-180)/2+120, ScreenWidth-160, 60)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:JpColor(240, 240, 240)];
        [button1 setTitle:title1 forState:UIControlStateNormal];
        [button2 setTitle:title2 forState:UIControlStateNormal];
        button2.tag=tag;
        button1.tag=tag;
        button1.selected=selected;
        button2.selected=!button1.selected;
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[self imageWithColor:mainColor] forState:UIControlStateSelected];
        [button1 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[self imageWithColor:mainColor] forState:UIControlStateSelected];
        [button2 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[self imageWithColor:mainColor] forState:UIControlStateHighlighted];
        [button1 setBackgroundImage:[self imageWithColor:mainColor] forState:UIControlStateHighlighted];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(SelectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button1 addTarget:self action:@selector(SelectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [self addSubview:button1];
        [self addSubview:button2];
    }
    
    return self;
}
+(SelectedButton*)selectedButtonWithTitle1:(NSString*)title1 title2:(NSString*)title2 selected:(BOOL)selected withTag:(NSInteger)tag{
    
    return [[self alloc]initWithButtonWithTitle1:title1 title2:title2 selected:selected withTag:tag];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)cancel{
    [self removeFromSuperview];
}

-(void)SelectedButtonClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(SelectedButtonClick:)]) {
        [self removeFromSuperview];
        [self.delegate SelectedButtonClick:btn];
    }
}
@end
