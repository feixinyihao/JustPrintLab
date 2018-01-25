//
//  RefoundViewController.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/9/11.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "RefoundViewController.h"
#import "UniHttpTool.h"
#import "PayRecTableViewCell.h"
#import "MBProgressHUD+MJ.h"
#import <MJRefresh.h>
@interface RefoundViewController ()
@property(nonatomic,strong)NSMutableArray*payRecArr;
@end

@implementation RefoundViewController

-(NSMutableArray *)payRecArr{

    if (_payRecArr==nil) {
        _payRecArr=[NSMutableArray array];
    }
    return _payRecArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"退款记录";
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupRefoundRec];
       
    }];
    [self.tableView.mj_header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupRefoundRec{
    NSString*url=[NSString stringWithFormat:@"%@/ajax/query.aspx?act=get_deposit&start=&kind=2",RootURL];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        DLog(@"%@",json[@"data"]);
        [self.tableView.mj_header endRefreshing];
        if (![json[@"data"] isKindOfClass:[NSNull class]]) {
            NSMutableArray*temp=[NSMutableArray array];
            for (NSDictionary*dict in json[@"data"]) {
                PayRec*payrec=[PayRec PayRecWithDict:dict];
                [temp addObject:payrec];
            }
            self.payRecArr=temp;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.payRecArr.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayRecTableViewCell*paycell=[[PayRecTableViewCell alloc]init];
    paycell.item=self.payRecArr[indexPath.section];
    paycell.selectionStyle=UITableViewCellSelectionStyleNone;
    return paycell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}


@end
