//
//  ScanTableViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/22.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "ScanTableViewController.h"
#import "UniHttpTool.h"
#import "ScanRecCell.h"
#import "ScanRec.h"
#import <MJRefresh.h>
#import <MBProgressHUD.h>
#import "CommonFunc.h"
@interface ScanTableViewController ()

@property(nonatomic,strong)NSArray*dataArr;
@end

@implementation ScanTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"扫描文件";
    [self setupData];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupData];
        [self.tableView.mj_header endRefreshing];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{
    DLog(@"不要点我");
}
- (void)dealloc {
    DLog(@"%s",__func__);
}
-(void)setupData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString*url=[NSString stringWithFormat:@"%@/ajax/scan.aspx?act=get_scan_rec&start=&end=",RootURL];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (![json[@"data"] isKindOfClass:[NSNull class]]) {
            NSMutableArray*dataArr=[NSMutableArray array];
            for (NSDictionary*dataDic in json[@"data"]) {
                ScanRec*scanrec=[ScanRec scanrecWith:dataDic];
                [dataArr addObject:scanrec];
            }
            self.dataArr=dataArr;
            [self.tableView reloadData];
        }else{
            [CommonFunc backToLogon];
        }
       
       
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScanRecCell*cell=[ScanRecCell initWithTableView:tableView];
    cell.item=self.dataArr[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

}

#pragma mark getter/setter
-(NSArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSArray array];
    }
    return _dataArr;
}
@end
