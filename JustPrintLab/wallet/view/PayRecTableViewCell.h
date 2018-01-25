//
//  PayRecTableViewCell.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/9/11.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayRec.h"
@interface PayRecTableViewCell : UITableViewCell
@property(nonatomic,strong)PayRec* item;
+(PayRecTableViewCell*)initWithTableView:(UITableView*)tableView;
@end
