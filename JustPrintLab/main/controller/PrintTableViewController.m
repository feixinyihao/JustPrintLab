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
#import <UIScrollView+EmptyDataSet.h>
#import <MJRefresh.h>
#import "PrintUploadView.h"
#import <TZImagePickerController.h>
#import <TZImageManager.h>
#import "MBProgressHUD+MJ.h"
#import "PrintConfigViewController.h"
#import "BaseNavigationController.h"
#import "PrintMemu.h"
#import "IFMMenuItem.h"
#import "CommonFunc.h"
@interface PrintTableViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,PrintUploadViewDelegate,TZImagePickerControllerDelegate,PrintMemuDelegate>
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
       
    }];
    
    //通知中心是个单例
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(setupData) name:@"refresh" object:nil];

}
-(void)setupRightItem{
    UIButton*rightBtn=[[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=item;
}
-(void)setupTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, ScreenHeight-64-50-20) style:UITableViewStylePlain];
    self.tableView.layer.cornerRadius=5;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}
-(void)setupButton{
    if (![self.view viewWithTag:1000]) {
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(10, ScreenHeight-64-50, ScreenWidth-20, 44)];
        btn.backgroundColor=mainColor;
        btn.layer.cornerRadius=5;
        [btn setTitle:@"扫码取件" forState:UIControlStateNormal];
        btn.tag=1000;
        self.scanBtn=btn;
       [self.view addSubview:self.scanBtn];
    }
    
    
}
- (void)dealloc {
    DLog(@"%s",__func__);
}
-(void)setupData{

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
                [self setupRightItem];
                self.view.backgroundColor=JpColor(240, 240, 240);
            }else{
                [self.scanBtn removeFromSuperview];
                self.view.backgroundColor=[UIColor whiteColor];
            }
            [self.tableView reloadData];
           
        }else{
            [CommonFunc backToLogon];
        }
       [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrintJobCell*cell=[PrintJobCell initWithTableView:tableView];
    cell.item=self.dataArr[indexPath.section];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     PrintJob* printjob=self.dataArr[indexPath.section];
    DLog(@"%@---%@",printjob.szJobFileName,printjob.dwJobId);
    NSString*url=[NSString stringWithFormat:@"%@/ajax/print.aspx?file=%@&task_id=%@&page_num=1&act=prepare_print_view",RootURL, printjob.szJobFileName,printjob.dwJobId];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        DLog(@"%@",json[@"msg"]);
        if ([json[@"ret"] integerValue]==1) {
            NSString*viewUrl=[NSString stringWithFormat:@"%@/ajax/print.aspx?file=%@&task_id=%@&page_num=1&act=get_print_view",RootURL, printjob.szJobFileName,printjob.dwJobId];
            [UniHttpTool getWithUrl:viewUrl parameters:nil progress:^(NSProgress *progress) {
                
            } success:^(id json) {
                DLog(@"二:%@",json);
            } failure:^(NSError *error) {
                
            }];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=JpColor(240, 240, 240);
    return view;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*delete=@"删除";
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:delete handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        PrintJob* printjob=self.dataArr[indexPath.section];
        //从数据源中删除
        [self.dataArr removeObjectAtIndex:indexPath.section];
        NSIndexSet*indexset=[[NSIndexSet alloc]initWithIndex:indexPath.section];
        [tableView deleteSections:indexset withRowAnimation:UITableViewRowAnimationBottom];
        if (self.dataArr.count==0) {
            [self.scanBtn removeFromSuperview];
            self.view.backgroundColor=[UIColor whiteColor];
            self.navigationItem.rightBarButtonItem=nil;
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

/**
 点击空白图片
 */
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{
    
    PrintUploadView*uploadView=[[PrintUploadView alloc]init];
    uploadView.delegate=self;
    [self.view addSubview:uploadView];
}


-(void)PrintUploadViewImageBtnClick:(UIButton *)btn{
    if (btn.tag==902) {
        [self openImagePicker];
    }
}
-(void)openImagePicker{
    TZImagePickerController*imagepick=[[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    imagepick.allowPickingGif=NO;
    imagepick.allowPickingVideo=NO;
    [self presentViewController:imagepick animated:YES completion:nil];
    [imagepick.navigationBar setBackgroundImage:[UIImage imageNamed:@"printer_dft"] forBarMetrics:UIBarMetricsDefault];
    imagepick.isStatusBarDefault = NO;
    imagepick.allowPickingOriginalPhoto=NO;
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    for (PHAsset* asset in assets) {
        
        TZImageManager*manager=[TZImageManager manager];
        [manager getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
            NSString*imageName=@"public.jpg";
            if (![info[@"PHImageFileURLKey"] isKindOfClass:[NSNull class]]) {
                imageName=[NSString stringWithFormat:@"%@",info[@"PHImageFileURLKey"]];
                NSArray*tempArr=[imageName componentsSeparatedByString:@"/"];
                imageName=[tempArr lastObject];
            }
            NSData * data=UIImageJPEGRepresentation(photo, 0.5f);
            
            [UniHttpTool uploadWithparameters:nil name:imageName filename:imageName uploadData:data mineType:@"image/jpeg" success:^(id json) {
                if (![json[@"data"] isKindOfClass:[NSNull class]]) {
                    DLog(@"%@",json);
                    NSDictionary*dataDic=json[@"data"];
                    PrintConfigViewController*config=[[PrintConfigViewController alloc]init];
                    config.fileName=dataDic[@"fileName"];
                    config.filePath=dataDic[@"file"];
                    BaseNavigationController*nav=[[BaseNavigationController alloc]initWithRootViewController:config];
                    [self presentViewController:nav animated:YES completion:nil];
                }
               
            }];
        }];
    }
    
}
//菜单栏
-(void)upload{
    
    PrintMemu*memu=[[PrintMemu alloc]init];
    memu.delegate=self;
}
#pragma mark PrintMemuDelegate
-(void)PrintMemuBtnClick:(id)item{
    IFMMenuItem*ifitem=item;
    NSString*title=[ifitem.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray*titleArr=@[@"PC端上传",@"云端上传",@"微信上传",@"QQ上传",@"图片上传",@"证件上传"];
    for (int i=0; i<titleArr.count; i++) {
        if ([title isEqualToString:titleArr[i]]) {
            switch (i) {
                case 0:
                    break;
                case 1:
                   
                    break;
                case 2:
                    break;
                case 3:
                    break;
                case 4:
                    [self openImagePicker];
                    break;
                case 5:
        
                    break;
                default:
                    break;
            }
            return;
        }
    }
    
}
@end
