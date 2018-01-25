//
//  LeftViewController.m
//  ViewControllerTransition
//
//  Created by 陈旺 on 2017/7/10.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "LeftViewController.h"
#import "PushViewController.h"
#import "SetupTableViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "UniHttpTool.h"
#import <UIImageView+WebCache.h>
#import "CommonFunc.h"
#import "MBProgressHUD+MJ.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSArray *titleArray;

@property(nonatomic,weak)UILabel*balanceL;
@end

@implementation LeftViewController



- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"pswmanager",@"email",@"wallet",@"tel",@"invoice",@"histroy"];
    }
    return _imageArray;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        if (_drawerType == DrawerDefaultRight || _drawerType == DrawerTypeMaskRight) {
            _titleArray = @[];
        }else {
            _titleArray = @[@"密码管理",@"邮箱管理",@"钱包管理",@"客服电话",@"开具发票",@"历史记录"];
        }
    }
    return _titleArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView*backgroudImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    backgroudImage.frame=CGRectMake(0, 0, ScreenWidth*0.75, ScreenHeight);
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, backgroudImage.frame.size.width, backgroudImage.frame.size.height);
    [backgroudImage addSubview:effectView];
  //  [self.view addSubview:backgroudImage];
    
    
    
    [self setupHeader];
    
    [self setupTableView];
    [self setupBoom];
   
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect rect = self.view.frame;
    
    switch (_drawerType) {
        case DrawerDefaultLeft:
            [self.view.superview sendSubviewToBack:self.view];
            
            break;
        case DrawerTypeMaskLeft:
            rect.size.width = CGRectGetWidth(self.view.frame) * 0.75;
            break;
        default:
            break;
    }

    self.view.frame = rect;
    [self get_balance];
}




- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,ScreenWidth*0.75*4/7+20, ScreenWidth * 0.75, ScreenHeight-250) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView setBackgroundColor:[UIColor clearColor]];
    _tableView = tableView;
  
}

/**
 初始化头部
 */
- (void)setupHeader {
    UIImageView*headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.75, ScreenWidth*0.75*4/7)];
    [headerView setImage:[UIImage imageNamed:@"printer_dft"]];
    [self.view addSubview:headerView];
    UIImageView*header=[[UIImageView alloc]initWithFrame:CGRectMake(20, ScreenWidth*0.75*4/7-80, 40, 40)];
    if ([UniHttpTool isWechatOrAlipay]) {
        [header sd_setImageWithURL:[NSURL URLWithString:[UniHttpTool getHeadImgUrl]] placeholderImage:[UIImage imageNamed:@"icon"]];
    }else{
        [header setImage:[UIImage imageNamed:@"icon"]];
    }
    
    header.layer.masksToBounds=YES;
    header.layer.cornerRadius=20;
    header.layer.borderColor=[UIColor whiteColor].CGColor;
    header.layer.borderWidth=2;
    [headerView addSubview:header];
    
    UILabel*trueNameL=[[UILabel alloc]initWithFrame:CGRectMake(70, ScreenWidth*0.75*4/7-80, 200, 20)];
    trueNameL.text=[UniHttpTool getShowName];
    trueNameL.font=[UIFont systemFontOfSize:14];
    trueNameL.textColor=[UIColor whiteColor];
    [headerView addSubview:trueNameL];
    
    UILabel*balanceL=[[UILabel alloc]initWithFrame:CGRectMake(70, ScreenWidth*0.75*4/7-60, 200, 20)];
    balanceL.text=[NSString stringWithFormat:@"余额:%.2f",([UniHttpTool getNativeBalance]+[UniHttpTool getNativeSubsidy])/100.0];
    self.balanceL=balanceL;
    balanceL.font=[UIFont systemFontOfSize:13];
    balanceL.textColor=[UIColor whiteColor];
    [headerView addSubview:self.balanceL];


}
-(void)get_balance{
 
    [CommonFunc getBalance:^(id json) {
        if ([json[@"ret"] integerValue]==1) {
            NSDictionary*dataDic=json[@"data"];
            NSInteger balance=[dataDic[@"dwBalance"] integerValue]+[dataDic[@"dwSubsidy"]integerValue];
            self.balanceL.text=[NSString stringWithFormat:@"余额:%.2f",balance/100.0];
        }
    }];
   
}

/**
 初始化底部
 */
-(void)setupBoom{
    UIButton*setupBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, ScreenHeight-40,60,40)];
    [setupBtn setImage:[UIImage imageNamed:@"setup"] forState:UIControlStateNormal];
    [setupBtn setTitle:@"设置" forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(setup) forControlEvents:UIControlEventTouchUpInside];
    [setupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    setupBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:setupBtn];
    
    UIButton*aboutBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.75-80, ScreenHeight-40,60,40)];
    [aboutBtn setImage:[UIImage imageNamed:@"about"] forState:UIControlStateNormal];
    [aboutBtn setTitle:@"关于" forState:UIControlStateNormal];
    [aboutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    aboutBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:aboutBtn];
}
-(void)setup{
    SetupTableViewController*setup=[[SetupTableViewController alloc]init];
    [self cw_pushViewController:setup];
}
- (void)dealloc {
    DLog(@"%s",__func__);
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"leftcell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    }
    
    cell.imageView.image=[UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text=self.titleArray[indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.textColor=[UIColor blackColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PushViewController*push=[[PushViewController alloc]init];
    [push setHidesBottomBarWhenPushed:YES];
    [self cw_pushViewController:push];
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



@end
