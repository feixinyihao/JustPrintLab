//
//  ScanRecCell.m
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/16.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "ScanRecCell.h"
#import "ScanRec.h"
#import "CommonFunc.h"
@interface ScanRecCell()
@property(nonatomic,strong)UIImageView*icon;
@property(nonatomic,strong)UILabel*nameLabel;
@property(nonatomic,strong)UILabel*dataLabel;
@property(nonatomic,strong)UILabel*sizeLabel;



@end
@implementation ScanRecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(ScanRecCell*)initWithTableView:(UITableView*)tableView{

    static NSString* ID=@"cell";
    ScanRecCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ScanRecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
-(void)setItem:(ScanRec *)item{

    _item=item;
    [self setupdata];
    
}

-(UILabel *)nameLabel{

    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];

    }
    return _nameLabel;
}
-(UIImageView *)icon{
    if (_icon==nil) {
        _icon=[[UIImageView alloc]init];
    }
    return _icon;
}
-(UILabel *)dataLabel{

    if (_dataLabel==nil) {
        _dataLabel=[[UILabel alloc]init];

    }
    return _dataLabel;
}
-(UILabel *)sizeLabel{

    if (_sizeLabel==nil) {
        _sizeLabel=[[UILabel alloc]init];
    }
    return _sizeLabel;
}
-(void)setupdata{
    if ([[self.item.szDisplayName pathExtension] isEqualToString:@"pdf"]) {
        self.icon.image=[UIImage imageNamed:@"pdficon"];
    }else if ([[self.item.szDisplayName pathExtension] isEqualToString:@"jpeg"]||[[self.item.szDisplayName pathExtension] isEqualToString:@"jpg"]){
       self.icon.image=[UIImage imageNamed:@"imageicon"];
    }else if ([[self.item.szDisplayName pathExtension] isEqualToString:@"zip"]){
        self.icon.image=[UIImage imageNamed:@"zipicon"];
    }
    else{
        self.icon.image=[UIImage imageNamed:@"imageicon"];
    }
   
    self.icon.frame=CGRectMake(5, 15, 50, 50);
    self.nameLabel.frame=CGRectMake(60, 15, 280, 18);
    self.dataLabel.frame=CGRectMake(60, 60, 150, 15);
    self.sizeLabel.frame=CGRectMake(60, 30, 100, 30);
    self.sizeLabel.textColor=[UIColor orangeColor];
    self.sizeLabel.text=[NSString stringWithFormat:@"%.2fKB",[self.item.dwFileSize floatValue]/1000];
    self.sizeLabel.font=[UIFont systemFontOfSize:15];
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    self.dataLabel.font=[UIFont systemFontOfSize:12];
    self.nameLabel.text=self.item.szDisplayName;
    NSString*dwSubmitTime=[NSString stringWithFormat:@"%@",self.item.dwSubmitTime];

    NSString*submitDate=[NSString stringWithFormat:@"%@",self.item.dwSubmitDate];
    submitDate=[CommonFunc dataFromString:submitDate];
    dwSubmitTime=[CommonFunc timeFromString:dwSubmitTime];
    self.dataLabel.text=[NSString stringWithFormat:@"%@ %@",submitDate,dwSubmitTime];
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dataLabel];
    [self.contentView addSubview:self.sizeLabel];



}

@end
