//
//  PrintUploadView.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/23.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrintUploadViewDelegate <NSObject>

@optional

-(void)PrintUploadViewImageBtnClick:(UIButton*)btn;


@end

@interface PrintUploadView : UIView

@property(nonatomic,strong)id <PrintUploadViewDelegate>delegate;
@end
