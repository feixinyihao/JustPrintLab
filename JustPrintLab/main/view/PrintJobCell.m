//
//  PrintJobCell.m
//  yinyue
//
//  Created by 陈鑫荣 on 2017/4/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "PrintJobCell.h"
#import "PrintJob.h"
#import "CommonFunc.h"
@interface PrintJobCell()
@property(nonatomic,strong)UIImageView* typeImageView;
@property(nonatomic,strong)UILabel*szDocumentLabel;
@property(nonatomic,strong)UILabel*dwSubmitDateLabel;
@property(nonatomic,strong)UILabel* dwRandomCodeLabel;
@property(nonatomic,strong)UILabel* configure;
@property(nonatomic,strong)UILabel* copies;
@end

@implementation PrintJobCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(PrintJobCell*)initWithTableView:(UITableView*)tableView{
    static NSString* ID=@"cell";
    PrintJobCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[PrintJobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
    
}
-(void)setItem:(PrintJob *)item{
    _item=item;
    
    [self setupView];
    
}

-(UIImageView *)typeImageView{

    if (_typeImageView==nil) {
        _typeImageView=[[UIImageView alloc]init];
    }
    return _typeImageView;
}
-(UILabel *)szDocumentLabel{

    if (_szDocumentLabel==nil) {
        _szDocumentLabel=[[UILabel alloc]init];
    }
    return _szDocumentLabel;
}
-(UILabel *)dwSubmitDateLabel{

    if (_dwSubmitDateLabel==nil) {
        _dwSubmitDateLabel=[[UILabel alloc]init];
    }
    return _dwSubmitDateLabel;
}
-(UILabel *)dwRandomCodeLabel{

    if (_dwRandomCodeLabel==nil) {
        _dwRandomCodeLabel=[[UILabel alloc]init];
    }
    return _dwRandomCodeLabel;
}
-(UILabel *)configure{

    if (_configure==nil) {
        _configure=[[UILabel alloc]init];
    }
    return _configure;
}
-(UILabel *)copies{

    if (_copies==nil) {
        _copies=[[UILabel alloc]init];
    }
    return _copies;
}

-(void)setupView{
    
    self.typeImageView.frame=CGRectMake(5, 15, 50, 50);
    CGFloat docW=kIs_iphone5?ScreenWidth-65:ScreenWidth-120-60;
    self.szDocumentLabel.frame=CGRectMake(60, 15, docW, 15);
    self.configure.frame=CGRectMake(88, 35, 140, 20);
    self.copies.frame=CGRectMake(60, 35, 35, 20);
    NSString*str;
    if (![self.item.printdetail.dwColorPages isKindOfClass:[NSNull class]]) {
        str=@"彩色";

    }else{
        str=@"黑白";
    
    }
    NSString*str1=@"";
    NSString*singleSided=@"单面";
    NSString*sided=@"双面";
    if (![self.item.printdetail.dwPaperNum isKindOfClass:[NSNull class]]&& ![self.item.dwPages isKindOfClass:[NSNull class]]) {
        if ( [self.item.printdetail.dwPaperNum intValue]==[self.item.dwPages intValue]) {
            str1=singleSided;
        }else{
        
            str1=sided;
        }
       
    }
    NSString*lan_copies=@"份";
    NSString*copies=[NSString stringWithFormat:@"%@%@",self.item.dwCopies,lan_copies];
    NSString*paper=@"";
    if ([self.item.dwPaperID integerValue]==9) {
        paper=@"A4";
    }else if ([self.item.dwPaperID integerValue]==8){
        paper=@"A3";
    }else if ([self.item.dwPaperID integerValue]==285){
        paper=@"6寸";
    }else if ([self.item.dwPaperID integerValue]==281){
        paper=@"5寸";
    }else if ([self.item.dwPaperID integerValue]==260){
        paper=@"发票";
    }else{
        paper=@"其他";
    }
    NSString*page=@"页";
    NSString*configure=[NSString stringWithFormat:@"%@%@ | %@ | %@ | %@",self.item.dwPages,page,paper,str,str1];

    self.copies.text=copies;
    self.copies.font=[UIFont systemFontOfSize:14];
    self.copies.textColor=[UIColor orangeColor];
    self.configure.text=configure;
    if ([[self.item.szDocument pathExtension]isEqualToString:@"pdf"]||[[self.item.szDocument pathExtension]isEqualToString:@"PDF"]) {
        self.typeImageView.image=[UIImage imageNamed:@"pdficon"];
    }else if ([[self.item.szDocument pathExtension]isEqualToString:@"doc"]||[[self.item.szDocument pathExtension]isEqualToString:@"docx"]){
        self.typeImageView.image=[UIImage imageNamed:@"wordicon"];
    }else if ([[self.item.szDocument pathExtension]isEqualToString:@"xls"]||[[self.item.szDocument pathExtension]isEqualToString:@"xlsx"]){
        self.typeImageView.image=[UIImage imageNamed:@"exceliocn"];
        
    }else if ([[self.item.szDocument pathExtension]isEqualToString:@"ppt"]||[[self.item.szDocument pathExtension]isEqualToString:@"pptx"]){
        
        self.typeImageView.image=[UIImage imageNamed:@"ppticon"];
    }else if ([[self.item.szDocument pathExtension]isEqualToString:@"jpg"]||[[self.item.szDocument pathExtension]isEqualToString:@"jpeg"]||[[self.item.szDocument pathExtension]isEqualToString:@"png"]||[[self.item.szDocument pathExtension]isEqualToString:@"JPG"]||[[self.item.szDocument pathExtension]isEqualToString:@"JPEG"]){
        
        self.typeImageView.image=[UIImage imageNamed:@"imageicon"];
    }else{
        
        self.typeImageView.image=[UIImage imageNamed:@"imageicon"];
    }

    
    self.configure.font=[UIFont systemFontOfSize:12];
    //取件码
    CGFloat y=kIs_iphone5?55:30;
    [self.dwRandomCodeLabel setFrame:CGRectMake(ScreenWidth-140, y, 120, 20)];
    self.dwRandomCodeLabel.backgroundColor=JpColor(240, 240, 240);
    self.dwRandomCodeLabel.layer.cornerRadius=10;
    self.dwRandomCodeLabel.layer.masksToBounds=YES;
    self.dwRandomCodeLabel.textAlignment=NSTextAlignmentCenter;
    self.dwSubmitDateLabel.frame=CGRectMake(60, 60, 150, 15);
    self.szDocumentLabel.font=[UIFont systemFontOfSize:14];
    self.dwSubmitDateLabel.font=[UIFont systemFontOfSize:11];
    self.dwRandomCodeLabel.font=[UIFont systemFontOfSize:12];
    self.szDocumentLabel.text=self.item.szDocument;
    self.dwRandomCodeLabel.text=[NSString stringWithFormat:@"取件码:%@",self.item.dwRandomCode];
   
    NSString*dwSubmitTime=[NSString stringWithFormat:@"%@",self.item.dwSubmitTime];
    dwSubmitTime=[CommonFunc timeFromString:dwSubmitTime];
    
    NSString*SubmitDate=[NSString stringWithFormat:@"%@",self.item.dwSubmitDate];
    SubmitDate=[CommonFunc dataFromString:SubmitDate];
    self.dwSubmitDateLabel.text=[NSString stringWithFormat:@"%@ %@",SubmitDate,dwSubmitTime];

    
    [self.contentView addSubview:self.dwRandomCodeLabel];
    [self.contentView addSubview:self.typeImageView];
    [self.contentView addSubview:self.szDocumentLabel];
    [self.contentView addSubview:self.dwSubmitDateLabel];
    [self.contentView addSubview:self.configure];
    [self.contentView addSubview:self.copies];

    
}



@end
