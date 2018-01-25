//
//  UploadButton.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/9/8.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "UploadButton.h"

@implementation UploadButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode=  UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont fontWithName:@"GeezaPro" size:13];
        
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 5, contentRect.size.width, contentRect.size.height*0.6);
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, contentRect.size.height*0.55, contentRect.size.width, contentRect.size.height*0.4);
    
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
