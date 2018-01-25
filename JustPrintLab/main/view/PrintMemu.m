//
//  PrintMemu.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/24.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "PrintMemu.h"
#import "IFMMenu.h"
#import "CommonFunc.h"
@implementation PrintMemu

-(instancetype)init{
    if ([super init]) {
        if (self) {
            
            NSMutableArray *menuItems = [[NSMutableArray alloc] initWithObjects:
                                         
                [IFMMenuItem itemWithImage:[UIImage imageNamed:@"pc_upload_sm"]title:@"PC端上传"
                                    action:^(IFMMenuItem *item) {[self PrintMemuBtnClick:item];}],
                [IFMMenuItem itemWithImage:[UIImage imageNamed:@"cloud_upload_sm"]title:@"云端上传"
                                    action:^(IFMMenuItem *item) {[self PrintMemuBtnClick:item];}],
                [IFMMenuItem itemWithImage:[UIImage imageNamed:@"wechat_upload_sm"]title:@"微信上传"
                                    action:^(IFMMenuItem *item) {[self PrintMemuBtnClick:item];}],
                [IFMMenuItem itemWithImage:[UIImage imageNamed:@"qq_upload_sm"]title:@" QQ上传"
                                    action:^(IFMMenuItem *item) {[self PrintMemuBtnClick:item];}],
                [IFMMenuItem itemWithImage:[UIImage imageNamed:@"image_upload_sm"]title:@"图片上传"
                                    action:^(IFMMenuItem *item) {[self PrintMemuBtnClick:item];}],
                [IFMMenuItem itemWithImage:[UIImage imageNamed:@"cert_upload_sm"]title:@"证件上传"
                                    action:^(IFMMenuItem *item) {[self PrintMemuBtnClick:item];}],nil
                                         ];
            IFMMenu *menu = [[IFMMenu alloc] initWithItems:menuItems];
            menu.minMenuItemHeight = 42;
            menu.menuBackGroundColor=JpColor(254, 255, 255);
            menu.titleColor=[UIColor blackColor];
            menu.menuCornerRadiu = 4;
            menu.segmenteLineColor = [UIColor lightGrayColor];
            menu.titleFont=[UIFont systemFontOfSize:15];
            CGRect rect=kIs_iPhoneX?CGRectMake(ScreenWidth-60, 24, 60, 60):CGRectMake(ScreenWidth-60, 0, 60, 60);
            [menu showFromRect:rect inView:[CommonFunc getCurrentVC].view];
        }
    }
    return self;
}

-(void)PrintMemuBtnClick:(id)item;{
    if ([self.delegate respondsToSelector:@selector(PrintMemuBtnClick:)]) {
        [self.delegate PrintMemuBtnClick:item];
    }
   
}
@end
