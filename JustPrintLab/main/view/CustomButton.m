//
//  CustomButton.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/11/27.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        self.imageView.contentMode=  UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*(self.imageScale?self.imageScale:0.7));
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, contentRect.size.height*(self.imageScale?self.imageScale:0.7), contentRect.size.width, contentRect.size.height*(1-(self.imageScale?self.imageScale:0.7)));
    
}

-(void)setHighlighted:(BOOL)highlighted{}
-(void)setItem:(UITabBarItem *)item{
    _item=item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
}
@end
