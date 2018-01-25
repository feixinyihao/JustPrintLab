//
//  PayRecTableViewCell.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/9/11.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "PayRecTableViewCell.h"
@interface PayRecTableViewCell()

@property(nonatomic,strong)UILabel*dateLabel;
@property(nonatomic,strong)UILabel*lshLabel;
@property(nonatomic,strong)UILabel*moneyLabel;
@property(nonatomic,strong)UILabel*sourceLabel;
@end

@implementation PayRecTableViewCell

-(UILabel *)dateLabel{

    if (_dateLabel==nil) {
        _dateLabel=[[UILabel alloc]init];
    }
    return _dateLabel;
}
-(UILabel *)lshLabel{

    if (_lshLabel==nil) {
        _lshLabel=[[UILabel alloc]init];
    }
    return _lshLabel;
}
-(UILabel *)moneyLabel{

    if (_moneyLabel==nil) {
        _moneyLabel=[[UILabel alloc]init];
    }
    return _moneyLabel;
}
-(UILabel *)sourceLabel{

    if (_sourceLabel==nil) {
        _sourceLabel=[[UILabel alloc]init];
    }
    return _sourceLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(PayRecTableViewCell*)initWithTableView:(UITableView*)tableView{
    static NSString* ID=@"cell";
    PayRecTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[PayRecTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
    
}
-(void)setItem:(PayRec *)item{
    _item=item;
    
    [self setupView];
    
}
-(void)setupView{
    //充值金额
    self.moneyLabel.frame=CGRectMake(10, 10, ScreenWidth-10, 20);
    self.moneyLabel.font=[UIFont systemFontOfSize:15];
    self.moneyLabel.textColor=[UIColor orangeColor];
    NSString*yuan=@"元";
    NSString*Retired=@"已退";
    if ([self.item.refund floatValue]>0) {
         self.moneyLabel.text=[NSString stringWithFormat:@"%.2f%@(%@%.2f%@)",[self.item.money floatValue]/100,yuan,Retired,[self.item.refund floatValue]/100,yuan ];
    }else{
        self.moneyLabel.text=[NSString stringWithFormat:@"%.2f%@",[self.item.money floatValue]/100 ,yuan];
    
    }
    [self.contentView addSubview:self.moneyLabel];
    //充值方式(微信，app等)
    self.sourceLabel.frame=CGRectMake(10, 30, ScreenWidth-10, 20);
    self.sourceLabel.textColor=mainColor;
    self.sourceLabel.font=[UIFont systemFontOfSize:13];
    self.sourceLabel.text=self.item.source;
    [self.contentView addSubview:self.sourceLabel];
    //流水号
    self.lshLabel.frame=CGRectMake(10, 50, ScreenWidth-10, 20);
    self.lshLabel.font=[UIFont systemFontOfSize:13];
    self.lshLabel.textColor=[UIColor lightGrayColor];
    NSString*serNo=@"流水号";
    self.lshLabel.text=[NSString stringWithFormat:@"%@: %@",serNo,self.item.lsh];
    [self.contentView addSubview:self.lshLabel];
    
    //日期
    self.dateLabel.frame=CGRectMake(10, 70, ScreenWidth-10, 20);
    self.dateLabel.font=[UIFont systemFontOfSize:13];
    self.dateLabel.textColor=[UIColor lightGrayColor];
    self.dateLabel.text=self.item.date;
    [self.contentView addSubview:self.dateLabel];
    
   
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
