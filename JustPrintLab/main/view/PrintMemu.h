//
//  PrintMemu.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/24.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PrintMemuDelegate <NSObject>

@optional

-(void)PrintMemuBtnClick:(id)item;

@end
@interface PrintMemu : UIView

@property(nonatomic,strong)id <PrintMemuDelegate>delegate;
@end
