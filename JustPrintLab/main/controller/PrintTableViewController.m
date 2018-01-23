//
//  PrintTableViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/22.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "PrintTableViewController.h"
#import "PrintJob.h"
#import "PrintJobCell.h"
#import "UniHttpTool.h"
#import <MBProgressHUD.h>
#import <UIScrollView+EmptyDataSet.h>
#import <MJRefresh.h>
@interface PrintTableViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,weak)UIButton*scanBtn;
@end

@implementation PrintTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"打印任务";
    [self setupTableView];
    [self setupData];
   
    
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupData];
        [self.tableView.mj_header endRefreshing];
    }];

}
-(void)setupTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}
-(void)setupButton{
    if (![self.view viewWithTag:1000]) {
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-64-50, ScreenWidth, 50)];
        btn.backgroundColor=mainColor;
        [btn setTitle:@"扫一扫" forState:UIControlStateNormal];
        btn.tag=1000;
        self.scanBtn=btn;
       [self.view addSubview:self.scanBtn];
    }
    
    
}
- (void)dealloc {
    DLog(@"%s",__func__);
}
-(void)setupData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString*url=[NSString stringWithFormat:@"%@/ajax/print.aspx?act=get_print_task",RootURL];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        //DLog(@"%@",json);
        if (![json[@"data"] isKindOfClass:[NSNull class]]) {
            NSMutableArray*dataArr=[NSMutableArray array];
            for (NSDictionary*dataDic in json[@"data"]) {
                
                PrintJob*pringjob=[PrintJob printjobWithdic:dataDic];
                [dataArr addObject:pringjob];
            }
            self.dataArr=dataArr;
            if (self.dataArr.count>0) {
                [self setupButton];
            }else{
                [self.scanBtn removeFromSuperview];
            }
            [self.tableView reloadData];
        }
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrintJobCell*cell=[PrintJobCell initWithTableView:tableView];
    cell.item=self.dataArr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*delete=@"删除";
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:delete handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        PrintJob* printjob=self.dataArr[indexPath.row];
        //从数据源中删除
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        if (self.dataArr.count==0) {
            [self.scanBtn removeFromSuperview];
            [self.tableView reloadData];
        }
       
        NSString*url=[NSString stringWithFormat:@"%@/ajax/print.aspx?act=del_print_task&task_id=%@",RootURL,printjob.dwJobId];
        [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
            
        } success:^(id json) {
            DLog(@"%@",json);
        } failure:^(NSError *error) {
            
        }];
        
    }];
    
  
    return @[deleteAction];
}
#pragma mark getter/setter
-(NSArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark DZNEmptyDataSetSource
/**
 空白也显示提示图片
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty"];
}

/**
 空白也显示文字
 
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"点我打印";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{
    
    DLog(@"开始打印");
}
@end
