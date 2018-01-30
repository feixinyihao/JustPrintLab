//
//  WithImageLabel.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/30.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "WithImageLabel.h"

@implementation WithImageLabel

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image text:(NSString*)text{
    if ([super initWithFrame:frame]) {
        if (self) {

            // 1.创建一个富文本
            NSMutableAttributedString *attri =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",text]];
            // 修改富文本中的不同文字的样式
            [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attri.length)];
            [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, attri.length)];
            // 2.添加图片
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = image;
            // 设置图片大小
            attch.bounds = CGRectMake(0, 0, frame.size.height, frame.size.height);
            // 创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri insertAttributedString:string atIndex:0];// 插入某个位置
            // 用label的attributedText属性来使用富文本
            [attri addAttribute:NSBaselineOffsetAttributeName value:@(0.5 * (frame.size.height - 12)) range:NSMakeRange(1, attri.length - 1)];
            self.attributedText = attri;
            
        }
    }
    return self;
}

@end
