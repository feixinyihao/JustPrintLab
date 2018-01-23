//
//  PrintJobCell.h
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PrintJob;
@interface PrintJobCell : UITableViewCell
@property(nonatomic,strong)PrintJob*item;
+(PrintJobCell*)initWithTableView:(UITableView*)tableView;
@end
