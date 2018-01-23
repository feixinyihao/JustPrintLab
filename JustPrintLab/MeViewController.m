//
//  MeViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/19.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "MeViewController.h"
#import "SetupTableViewController.h"
#import "UniHttpTool.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JpColor(240, 240, 240);
    self.tableView.tableFooterView = [UIView new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"printer_dft"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 1;
            break;
            
        default:
        
            return 0;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"me"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"me"];
    }
    switch (indexPath.section) {
        case 0:
        {
            UIImageView*headerImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
            headerImage.frame=CGRectMake(20, 10, 60, 60);
            headerImage.layer.cornerRadius=4;
            headerImage.layer.masksToBounds=YES;
            [cell.contentView addSubview:headerImage];
            
            UILabel*nameL=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, ScreenWidth, 20)];
            nameL.text=[UniHttpTool getShowName];
            nameL.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:nameL];
            
            UILabel*numL=[[UILabel alloc]initWithFrame:CGRectMake(100, 20+25, ScreenWidth, 20)];
            numL.text=[NSString stringWithFormat:@"登录号:%@",[UniHttpTool getLogonName]];
            numL.font=[UIFont systemFontOfSize:12];
            [cell.contentView addSubview:numL];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
            cell.accessoryView = imageView;
            
        }
            break;
           
        case 1:
            cell.imageView.image=[UIImage imageNamed:@"zhinan"];
            cell.textLabel.text=@"使用指南";
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            cell.accessoryView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
            break;
        case 2:{
            NSArray*titleArr=@[@"密码管理",@"邮箱管理",@"客服电话",@"开具发票",@"历史记录"];
            NSArray*imageArray = @[@"pswmanager",@"email",@"tel",@"invoice",@"histroy"];
            cell.imageView.image=[UIImage imageNamed:imageArray[indexPath.row]];
           
            if (indexPath.row==2) {
                UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 15)];
                label.text=@"400-905-7333";
                label.textAlignment=NSTextAlignmentRight;
                label.font=[UIFont systemFontOfSize:15];
                label.textColor=[UIColor blackColor];
                cell.accessoryView=label;
            }else{
                cell.accessoryView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
            }
            cell.textLabel.text=titleArr[indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:15];
        }
            
            break;
        case 3:
            cell.imageView.image=[UIImage imageNamed:@"setup"];
            cell.textLabel.text=@"设置";
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            cell.accessoryView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }else{
        return 45;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==3) {
        SetupTableViewController*setup=[[SetupTableViewController alloc]init];
        [self.navigationController pushViewController:setup animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=JpColor(240, 240, 240);
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
