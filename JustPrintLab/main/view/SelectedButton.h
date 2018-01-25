//
//  SelectedButton.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/25.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectedButtonDelegate <NSObject>

@optional

-(void)SelectedButtonClick:(UIButton*)btn;

@end

@interface SelectedButton : UIView
@property(nonatomic,copy)NSString*title1;
@property(nonatomic,copy)NSString*title2;
+(SelectedButton*)selectedButtonWithTitle1:(NSString*)title1 title2:(NSString*)title2 selected:(BOOL)selected withTag:(NSInteger)tag;
-(SelectedButton*)initWithButtonWithTitle1:(NSString*)title1 title2:(NSString*)title2 selected:(BOOL)selected withTag:(NSInteger)tag;

@property(nonatomic,strong)id <SelectedButtonDelegate>delegate;
@end
