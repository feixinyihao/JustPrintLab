//
//  WalletViewController.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/7/12.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "WalletViewController.h"
#import "CustomButton.h"
#import "UniHttpTool.h"
#import "CommonFunc.h"
@interface WalletViewController ()
@property(nonatomic,weak)UILabel *balanceL;
@property(nonatomic,weak)UILabel *subL;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JpColor(240, 240, 240);
    //没有数据时不显示分割线
    self.tableView.tableFooterView=[[UIView alloc]init];;
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self get_balance];
    
}
-(void)get_balance{
    [CommonFunc getBalance:^(id json) {
        if ([json[@"ret"] integerValue]==1) {
            NSDictionary*dataDic=json[@"data"];
            NSInteger balance=[dataDic[@"dwBalance"] integerValue];
            NSInteger sub=[dataDic[@"dwSubsidy"]integerValue];
            self.balanceL.text=[NSString stringWithFormat:@"%.2f元",balance/100.0];
            self.subL.text=[NSString stringWithFormat:@"%.2f元",sub/100.0];
        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"wallet"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wallet"];
    }
    switch (indexPath.section) {
        case 0:{
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView*headerImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
            headerImage.frame=CGRectMake(30, 25, 60, 60);
            headerImage.layer.cornerRadius=30;
            headerImage.layer.masksToBounds=YES;
            [cell.contentView addSubview:headerImage];
            
            UILabel*nameL=[[UILabel alloc]initWithFrame:CGRectMake(120, 30, ScreenWidth, 20)];
            if ([UniHttpTool isWechatOrAlipay]) {
                nameL.text=[NSString stringWithFormat:@"%@(%@)",[UniHttpTool getLogonName],[UniHttpTool getNickName]];
            }else{
                nameL.text=[UniHttpTool getLogonName];
            }
            nameL.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameL];
            //余额
            UILabel*balanceL=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, (ScreenWidth-90)/2, 15)];
            balanceL.text=[NSString stringWithFormat:@"%.2f元",[UniHttpTool getNativeBalance]/100.0];
            balanceL.textColor=mainColor;
            balanceL.textAlignment=NSTextAlignmentCenter;
            balanceL.font=[UIFont systemFontOfSize:12];
            self.balanceL=balanceL;
            [cell.contentView addSubview:self.balanceL];
            
            UILabel*balanceTextL=[[UILabel alloc]initWithFrame:CGRectMake(90, 75, (ScreenWidth-90)/2, 15)];
            balanceTextL.text=@"充值余额";
            balanceTextL.textAlignment=NSTextAlignmentCenter;
            balanceTextL.font=[UIFont systemFontOfSize:12];
            [cell.contentView addSubview:balanceTextL];
            
            UILabel*subL=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-90)/2+90, 60, (ScreenWidth-90)/2, 15)];
            subL.text=[NSString stringWithFormat:@"%.2f元",[UniHttpTool getNativeSubsidy]/100.0];
            subL.textColor=mainColor;
            subL.textAlignment=NSTextAlignmentCenter;
            subL.font=[UIFont systemFontOfSize:12];
            [cell.contentView addSubview:subL];
            
            UILabel*subTextL=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-90)/2+90, 75, (ScreenWidth-90)/2, 15)];
            subTextL.text=@"抵用金";
            subTextL.textAlignment=NSTextAlignmentCenter;
            subTextL.font=[UIFont systemFontOfSize:12];
            [cell.contentView addSubview:subTextL];
        }
            break;
        case 1:{
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            CustomButton*payBtn=[[CustomButton alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth/2, 60)];
            [payBtn setTitle:@"充值" forState:UIControlStateNormal];
            [payBtn setImageScale:0.8];
            [payBtn setImage:[UIImage imageNamed:@"pay"] forState:UIControlStateNormal];
            [cell.contentView addSubview:payBtn];
            
            CustomButton*refoundBtn=[[CustomButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, 5, ScreenWidth/2, 60)];
            [refoundBtn setTitle:@"退款" forState:UIControlStateNormal];
            [refoundBtn setImageScale:0.8];
            [refoundBtn setImage:[UIImage imageNamed:@"refound"] forState:UIControlStateNormal];
            [cell.contentView addSubview:refoundBtn];
            
            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-1, 20, 2, 40)];
            line.backgroundColor=JpColor(240, 240, 240);
            [cell.contentView addSubview:line];
        }
            break;
        case 2:
            cell.textLabel.text=@"充值记录";
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
            break;
        case 3:
            cell.textLabel.text=@"退款记录";
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
            break;
            
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 110;
            break;
        case 1:
            return 80;
            break;
        default:
            return 50;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 20;
    }else{
        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=JpColor(240, 240, 240);
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
