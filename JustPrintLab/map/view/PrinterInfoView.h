//
//  PrinterInfoView.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/29.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JpDevice;

@protocol PrinterInfoViewDelegate <NSObject>

@optional
-(void)PrinterInfoViewClick:(JpDevice*)device;
@end

@interface PrinterInfoView : UIView
-(instancetype)initWithFrame:(CGRect)frame device:(JpDevice*)device;

@property(nonatomic,strong)id <PrinterInfoViewDelegate>delegate;
@end
