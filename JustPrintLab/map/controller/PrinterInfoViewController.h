//
//  PrinterInfoViewController.h
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/29.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JpDevice.h"
@class MAUserLocation;
@interface PrinterInfoViewController : UIViewController
@property(nonatomic,strong)JpDevice*device;

@property(nonatomic,strong)MAUserLocation*location;
@end
