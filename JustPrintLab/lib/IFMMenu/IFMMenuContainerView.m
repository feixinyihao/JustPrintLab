//
//  IFMMenuContainerView.m
//  IFMMenuDemo
//
//  Created by 陈鑫荣 on 2017/7/26.
//  Copyright © 2017年 陈鑫荣. All rights reserved.
//

#import "IFMMenuContainerView.h"
#import "IFMMenuView.h"

@implementation IFMMenuContainerView

- (void) dealloc {
    //DLog(@"dealloc %@", self);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        UITapGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(singleTap:)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[IFMMenuView class]] && [subview respondsToSelector:@selector(dismissMenu:)]) {
            [subview performSelector:@selector(dismissMenu:) withObject:@(YES)];
        }
    }
}

@end

