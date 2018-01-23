//
//  ScanRecCell.h
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/16.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScanRec;
@interface ScanRecCell : UITableViewCell
@property(nonatomic,strong)ScanRec*item;
+(ScanRecCell*)initWithTableView:(UITableView*)tableView;
@end
