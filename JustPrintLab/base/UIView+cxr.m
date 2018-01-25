//
//  UIView+cxr.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/26.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "UIView+cxr.h"

@implementation UIView (cxr)
-(void)addSubviewWithAnimation:(UIView *)view{
    CATransition *transition =[CATransition animation];
    [transition setDuration:0.25];
    [transition setType:kCATransitionFade];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self.layer addAnimation:transition forKey:nil];
    [self addSubview:view];
}

-(void)removeFromSuperviewWithAnimation{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal,
   // transition.subtype = kCATransitionFade;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop,
    [self.layer.superlayer addAnimation:transition forKey:nil];
    [self.layer addAnimation:transition forKey:nil];
    [self removeFromSuperview];
}
@end
