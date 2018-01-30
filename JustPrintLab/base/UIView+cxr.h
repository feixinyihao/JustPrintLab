//
//  UIView+cxr.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/26.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CXRLineType) {
    CXRLineVertical,  // 垂直
    CXRLineHorizontal // 水平
};
@interface UIView (cxr)

-(void)addSubviewWithAnimation:(UIView *)view;

-(void)removeFromSuperviewWithAnimation;

/**
 * 创建一个表格
 * line：列数
 * columns：行数
 * data：数据
 */
- (void)CXR_drawListWithRect:(CGRect)rect line:(NSInteger)line columns:(NSInteger)columns datas:(NSArray *)datas;

/**
 * 创建一个表格
 * line：列数
 * columns：行数
 * data：数据
 * lineInfo：行信息，传入格式：@{@"0" : @"3"}意味着第一行创建3个格子
 */
- (void)CXR_drawListWithRect:(CGRect)rect line:(NSInteger)line columns:(NSInteger)columns datas:(NSArray *)datas lineInfo:(NSDictionary *)lineInfo;

/**
 * 创建一个表格
 * line：列数
 * columns：行数
 * data：数据
 * colorInfo：颜色信息，传入格式：@{@"0" : [UIColor redColor]}意味着第一个格子文字将会变成红色
 */
- (void)CXR_drawListWithRect:(CGRect)rect line:(NSInteger)line columns:(NSInteger)columns datas:(NSArray *)datas colorInfo:(NSDictionary *)colorInfo;
/**
 * 创建一个表格
 * line：列数
 * columns：行数
 * data：数据
 * colorInfo：颜色信息，传入格式：@{@"0" : [UIColor redColor]}意味着第一个格子文字将会变成红色
 * lineInfo：行信息，传入格式：@{@"0" : @"3"}意味着第一行创建3个格子
 */
- (void)CXR_drawListWithRect:(CGRect)rect line:(NSInteger)line columns:(NSInteger)columns datas:(NSArray *)datas colorInfo:(NSDictionary *)colorInfo lineInfo:(NSDictionary *)lineInfo;
/**
 * 创建一个表格
 * line：列数
 * columns：行数
 * data：数据
 * colorInfo：颜色信息，传入格式：@{@"0" : [UIColor redColor]}意味着第一个格子文字将会变成红色
 * lineInfo：行信息，传入格式：@{@"0" : @"3"}意味着第一行创建3个格子
 * backgroundColorInfo：行信息，传入格式：@{@"0" : [UIColor redColor]}意味着第一个格子背景颜色变成红色
 */
- (void)CXR_drawListWithRect:(CGRect)rect line:(NSInteger)line columns:(NSInteger)columns datas:(NSArray *)datas colorInfo:(NSDictionary *)colorInfo lineInfo:(NSDictionary *)lineInfo backgroundColorInfo:(NSDictionary *)backgroundColorInfo;
/**
 * 获取第index个格子的label
 */
- (UILabel *)getLabelWithIndex:(NSInteger)index;

/**
 * 画一条线
 * frame: 线的frame
 * color：线的颜色
 * lineWidth：线宽
 */
- (void)CXR_drawLineWithFrame:(CGRect)frame lineType:(CXRLineType)lineType color:(UIColor *)color lineWidth:(CGFloat)lineWidth;


/**
 合并单元格
 */
- (void)CXR2_drawListWithRect:(CGRect)rect line:(NSInteger)line columns:(NSInteger)columns datas:(NSArray *)datas colorInfo:(NSDictionary *)colorInfo lineInfo:(NSDictionary *)lineInfo backgroundColorInfo:(NSDictionary *)backgroundColorInfo;
@end
