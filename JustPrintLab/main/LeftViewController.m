//
//  LeftViewController.m
//  ViewControllerTransition
//
//  Created by 陈旺 on 2017/7/10.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "LeftViewController.h"
#import "PushViewController.h"

#import "UIViewController+CWLateralSlide.h"



@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation LeftViewController



- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"password",@"email",@"wallet",@"tel",@"invoice",@"logout"];
    }
    return _imageArray;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        if (_drawerType == DrawerDefaultRight || _drawerType == DrawerTypeMaskRight) {
            _titleArray = @[@"Push下一个界面",@"Push下一个界面",@"Push下一个界面",@"Push下一个界面",@"Push下一个界面",@"Push下一个界面"];
        }else {
            _titleArray = @[@"密码管理",@"邮箱管理",@"钱包管理",@"客服电话",@"开具发票",@"退出",@"关于我们"];
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
    
    UIImageView*backgroudImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    backgroudImage.frame=CGRectMake(0, 0, kCWSCREENWIDTH*0.75, kCWSCREENHEIGHT);
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, backgroudImage.frame.size.width, backgroudImage.frame.size.height);
    [backgroudImage addSubview:effectView];
    [self.view addSubview:backgroudImage];
    
    
    
    [self setupHeader];
    
    [self setupTableView];
    
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
}




- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(40,250, kCWSCREENWIDTH * 0.75, CGRectGetHeight(self.view.bounds)-250) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView setBackgroundColor:[UIColor clearColor]];
    _tableView = tableView;
  
}

- (void)setupHeader {
    UIImageView*header=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    header.frame=CGRectMake((kCWSCREENWIDTH*0.75-80)/2, 50, 80, 80);
    header.layer.masksToBounds=YES;
    header.layer.cornerRadius=40;
    header.layer.borderColor=[UIColor lightGrayColor].CGColor;
    header.layer.borderWidth=2;
    [self.view addSubview:header];
    
    UILabel*accL=[[UILabel alloc]initWithFrame:CGRectMake((kCWSCREENWIDTH*0.75-150)/2, 135, 150, 20)];
    accL.textAlignment=NSTextAlignmentCenter;
    accL.text=@"15158114882";
    accL.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:accL];
}


- (void)dealloc {
    NSLog(@"%s",__func__);
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
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PushViewController*push=[[PushViewController alloc]init];
    [self cw_pushViewController:push];
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



@end
