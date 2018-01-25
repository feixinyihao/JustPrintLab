//
//  PrintConfigViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/24.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "PrintConfigViewController.h"
#import "UniHttpTool.h"
#import "HQStepper.h"
#import "MBProgressHUD+MJ.h"
#import "CommonFunc.h"
#import "SelectedButton.h"
@interface PrintConfigViewController ()<UITableViewDelegate,UITableViewDataSource,SelectedButtonDelegate>
@property(nonatomic,weak)UITableView*tableView;
@property(nonatomic,assign)NSInteger copies;
@property (nonatomic, strong) HQStepper *stepper;

/**
 单双面
 */
@property(nonatomic,copy)NSString*dbl;

/**
 颜色
 */
@property(nonatomic,copy)NSString*color;

/**
 纸张
 */
@property(nonatomic,copy)NSString*paper;
@end

@implementation PrintConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"打印配置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    UIButton*closeBtn=[[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"close_light"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithCustomView:closeBtn];
    self.navigationItem.leftBarButtonItem=left;
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=JpColor(240, 240, 240);
    [self setupTableView];
    
    UIButton*boomBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, ScreenHeight-64-50, ScreenWidth-20, 44)];
    [boomBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    boomBtn.layer.cornerRadius=5;
    [boomBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    boomBtn.layer.masksToBounds=YES;
    boomBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [boomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [boomBtn setBackgroundColor:mainColor];
    [self.view addSubview:boomBtn];
    
    
}
-(void)setupTableView{
    UIScrollView*scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight-64-60)];
    scroll.backgroundColor=JpColor(240, 240, 240);
    scroll.showsVerticalScrollIndicator=NO;
    scroll.contentSize=CGSizeMake(ScreenWidth, ScreenHeight-64-60+10);
    [self.view addSubview:scroll];
    UITableView*tableview=[[UITableView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 300)];
    tableview.layer.cornerRadius=5;
    tableview.scrollEnabled=NO;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView=tableview;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [scroll addSubview:self.tableView];
    
    UILabel*tipsL=[[UILabel alloc]initWithFrame:CGRectMake(20, 320, ScreenWidth-40, 30)];
    tipsL.textColor=[UIColor lightGrayColor];
    tipsL.text=@"确认提交不收取费用，每个打印点收费标准有差异，提交成功后，请扫描打印机屏幕上二维码输出";
    tipsL.numberOfLines=0;
    tipsL.font=[UIFont systemFontOfSize:11];
    [scroll addSubview:tipsL];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"config"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"config"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor=[UIColor blackColor];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text=@"文件名";
             cell.detailTextLabel.textColor=[UIColor lightGrayColor];
            cell.detailTextLabel.text=self.fileName;
            
        }
            
            break;
        case 1:
            cell.textLabel.text=@"单双面";
            cell.detailTextLabel.text=self.dbl?self.dbl:@"单面";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
          
            break;
        case 2:
            cell.textLabel.text=@"颜色";
            cell.detailTextLabel.text=self.color?self.color:@"黑白";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        case 3:
            cell.textLabel.text=@"纸张";
            cell.detailTextLabel.text=self.paper?self.paper:@"A4";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 4:
            cell.textLabel.text=@"份数";
            cell.accessoryView=self.stepper;
            break;
            
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:{
   
            SelectedButton*selectBtn=[SelectedButton selectedButtonWithTitle1:@"单面" title2:@"双面" selected:![self.dbl isEqualToString:@"双面"] withTag:1100];
            selectBtn.delegate=self;
            [self.navigationController.view addSubview:selectBtn];
        }
            break;
        case 2:{
            SelectedButton*selectBtn=[SelectedButton selectedButtonWithTitle1:@"黑白" title2:@"彩色" selected:![self.color isEqualToString:@"彩色"] withTag:1200];
            selectBtn.delegate=self;
            [self.navigationController.view addSubview:selectBtn];
            
        }break;
        case 3:{
            SelectedButton*selectBtn=[SelectedButton selectedButtonWithTitle1:@"A4" title2:@"A3" selected:![self.paper isEqualToString:@"A3"] withTag:1300];
            selectBtn.delegate=self;
            [self.navigationController.view addSubview:selectBtn];
        }break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)submit{
    NSDictionary*parms=@{@"file":self.filePath,@"fileName":self.fileName,@"paper_id":[self.paper isEqualToString:@"A3"]?@"8":@"9",@"color":[self.color isEqualToString:@"彩色"]?@"1":@"0",@"copies":[NSString stringWithFormat:@"%ld",self.copies],  @"double":[self.dbl isEqualToString:@"双面"]?@"default":@""};
    NSString*url=[NSString stringWithFormat:@"%@/ajax/print.aspx?act=new_print_task",RootURL];
    [UniHttpTool postWithUrl:url parameters:parms progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        DLog(@"%@",json);
        if ([json[@"ret"] integerValue]==1) {
            [self dismissViewControllerAnimated:YES completion:^{
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"refresh" object:nil userInfo:nil];
            }];
            [MBProgressHUD showText:@"提交成功!"];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(HQStepper *)stepper{
    if (_stepper==nil) {
        self.copies=1;
        CGFloat controlWidth = 80.0f;
        CGFloat controlHeight = 24.0f;
        CGRect frame = CGRectMake(0, 0, controlWidth, controlHeight);
        _stepper = [HQStepper stepperWithFrame:frame min:1.0f max:99.0f step:1.0f value:1.0f];
        _stepper.wraps = NO; //循环，到最大值后返回到最小值
        [_stepper setAccessibilityTag:@"Blue"];
        [_stepper setTintColor:mainColor];
        [_stepper setFont:@"ArialMT" size:15];
        [_stepper setCornerRadius:10.0f];
        [_stepper addTarget:self action:@selector(stepperChanged:)forControlEvents:UIControlEventValueChanged];
    }
    return _stepper;
}


- (void)stepperChanged:(id)sender
{
    if (![sender isMemberOfClass:[HQStepper class]]) {
        return;
    }
    
    HQStepper *stepper = (HQStepper *)sender;
    NSInteger value =(NSInteger) [stepper value];
    self.copies=value;
}

-(void)SelectedButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1100:
            self.dbl=btn.titleLabel.text;
            [self.tableView reloadData];
            break;
        case 1200:
            self.color=btn.titleLabel.text;
            [self.tableView reloadData];
            break;
        case 1300:
            self.paper=btn.titleLabel.text;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}
@end
