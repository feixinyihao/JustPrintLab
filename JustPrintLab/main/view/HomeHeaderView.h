//
//  HomeHeaderView.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/20.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeHeaderViewDelegate <NSObject>

@optional
-(void)HomeHeaderViewButton:(UIButton*)button;
@end

@interface HomeHeaderView : UIView

@property(nonatomic,strong)id <HomeHeaderViewDelegate>delegate;

@end
