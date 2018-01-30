//
//  CustomMAPointAnnotation.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/6/21.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
@class JpDevice;
@interface CustomMAPointAnnotation : MAPointAnnotation
@property(nonatomic,strong)JpDevice* device;
@end
