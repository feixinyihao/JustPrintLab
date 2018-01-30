//
//  PrinterInfoViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/29.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "PrinterInfoViewController.h"
#import "PrinterInfoView.h"
#import "UIScrollView+PullScale.h"
#import "WithImageLabel.h"
#import "CommonFunc.h"
#import "FeeView.h"
#import <MapKit/MapKit.h>
#import <MAMapKit/MAMapKit.h>
@interface PrinterInfoViewController ()
@property(nonatomic,weak)UIScrollView*scrollview;
@end

@implementation PrinterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"打印点信息";
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor=JpColor(240, 240, 240);
    
    UIScrollView*scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -64, ScreenWidth, 600+200)];
    CGFloat H=scrollview.frame.size.height-140;
    if (ScreenWidth==320) {
        H=scrollview.frame.size.height-80;
    }
   
    scrollview.contentSize=CGSizeMake(ScreenWidth, H);
    scrollview.showsVerticalScrollIndicator=NO;
    self.scrollview=scrollview;
    [self.view addSubview:self.scrollview];
    [scrollview addPullScaleFuncInVC:self originalHeight:ScreenWidth/2 hasNavBar:YES];
    scrollview.imageV.image=[UIImage imageNamed:@"headerimage"];
    
    UIButton*goBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70, -25, 50, 50)];
    [goBtn setBackgroundColor:jpBlue];
    goBtn.layer.masksToBounds=YES;
    goBtn.layer.cornerRadius=25;
    goBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [goBtn addTarget:self action:@selector(selectMap) forControlEvents:UIControlEventTouchUpInside];
    [goBtn setTitle:@"去这里" forState:UIControlStateNormal];
  
    
    [self setupTitle];
    [scrollview addSubview:goBtn];

    [self setupDetaile];
    
    [self setupFee];
}
-(void)setupFee{
    UIView*feeView=[[UIView alloc]initWithFrame:CGRectMake(0, 300, ScreenWidth, 400)];
    feeView.backgroundColor=[UIColor whiteColor];
    [self.scrollview addSubview:feeView];
    
    FeeView*fee=[[FeeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200) dev_sn:self.device.dwPrinterSN];
    [feeView addSubview:fee];
}
-(void)setupDetaile{
    UIView*detaileView=[[UIView alloc]initWithFrame:CGRectMake(0, 110, ScreenWidth, 180)];
    detaileView.backgroundColor=[UIColor whiteColor];
    [self.scrollview addSubview:detaileView];
    
    WithImageLabel*imageLabel=[[WithImageLabel alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 20) image:[UIImage imageNamed:@"address"] text:self.device.szPosi];
    [detaileView addSubview:imageLabel];
    

    WithImageLabel*typeLabel=[[WithImageLabel alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-20, 20) image:[UIImage imageNamed:@"type"] text:[NSString stringWithFormat:@"机器类型: %@",[CommonFunc fromModel:[self.device.dwModel integerValue]]]];
    [detaileView addSubview:typeLabel];
    
    WithImageLabel*openLabel=[[WithImageLabel alloc]initWithFrame:CGRectMake(10, 100, ScreenWidth-20, 20) image:[UIImage imageNamed:@"opentime"] text:[NSString stringWithFormat:@"开放时间: %@-%@",[CommonFunc fromStrTime:self.device.dwOpenTime],[CommonFunc fromStrTime:self.device.dwCloseTime]]];
    [detaileView addSubview:openLabel];
    
    WithImageLabel*phoneLabel=[[WithImageLabel alloc]initWithFrame:CGRectMake(10, 140, ScreenWidth-20, 20) image:[UIImage imageNamed:@"phone"] text:[NSString stringWithFormat:@"联系电话: 暂无"]];
    [detaileView addSubview:phoneLabel];

    
}


-(void)setupTitle{
    
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    titleView.backgroundColor=[UIColor whiteColor];
    [self.scrollview addSubview:titleView];
    
    UILabel*titleL=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 30)];
    titleL.text=self.device.szName;
    titleL.textColor=[UIColor blackColor];
    titleL.font=[UIFont systemFontOfSize:20];
    [titleView addSubview:titleL];
    
    [self setupFunctionView:titleView device:self.device];
    
}

-(void)setupFunctionView:(UIView*)view device:(JpDevice*)device{
    NSMutableArray*roleArr=[NSMutableArray array];
    if ((1&[device.dwRole integerValue])==1) {
        [roleArr addObject:@"打印"];
    }
    if((2&[device.dwRole integerValue])==2){
        [roleArr addObject:@"复印"];
    }
    if ((4&[device.dwRole integerValue])==4){
        [roleArr addObject:@"扫描"];
    }
    if((8&[device.dwRole integerValue])==8){
        [roleArr addObject:@"照片"];
    }
    if ((16&[device.dwRole integerValue])==16){
        [roleArr addObject:@"发票"];
    }
    if ((8&[device.dwProperty integerValue])==8){
        [roleArr addObject:@"支持彩色"];
    }
    if((65536&device.dwCtrlType)==65536){
        [roleArr addObject:@"人工点"];
    }
    CGRect rect=CGRectMake(0, 0, 0, 0);
    for (int i=0; i<roleArr.count; i++) {
        UILabel*roleL=[[UILabel alloc]init];
        roleL.text=roleArr[i];
        roleL.font=[UIFont systemFontOfSize:11];
        roleL.backgroundColor=[jpBlue colorWithAlphaComponent:0.2];
        roleL.textColor=jpBlue;
        roleL.textAlignment=NSTextAlignmentCenter;
        roleL.layer.cornerRadius=3;
        roleL.layer.masksToBounds=YES;
        CGSize size=[roleL.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}];
        roleL.frame=CGRectMake(rect.size.width+rect.origin.x+10, 60, size.width+10, 20);
        if ([roleArr[i] isEqualToString:@"支持彩色"]) {
            roleL.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.2];
            roleL.textColor=[UIColor redColor];
        }
        if ([roleArr[i] isEqualToString:@"人工点"]) {
            roleL.backgroundColor=[[UIColor orangeColor] colorWithAlphaComponent:0.2];
            roleL.textColor=[UIColor orangeColor];
        }
        rect=roleL.frame;
        [view addSubview:roleL];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectMap{
    NSString*choosemap=@"选择地图导航";
    NSString*cancelstr=@"取消";
    NSString*amap=@"高德地图";
    NSString*baiduMap=@"百度地图";
    NSString*appleMapstr=@"苹果地图";
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:choosemap message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelstr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
        UIAlertAction *PhotoAlbum = [UIAlertAction actionWithTitle:amap style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //    m 驾车：0：速度最快，1：费用最少，2：距离最短，3：不走高速，4：躲避拥堵，5：不走高速且避免收费，6：不走高速且躲避拥堵，7：躲避收费和拥堵，8：不走高速躲避收费和拥堵 公交：0：最快捷，2：最少换乘，3：最少步行，5：不乘地铁 ，7：只坐地铁 ，8：时间短  是
            //    t = 0：驾车 =1：公交 =2：步行
            NSArray* temp=[self.device.szCoordinate componentsSeparatedByString:@","];
            CLLocationDegrees latitude = [[temp objectAtIndex:1] doubleValue];
            CLLocationDegrees longitude = [[temp objectAtIndex:0] doubleValue];
            NSString *urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%lf&slon=%lf&sname=我的位置&did=BGVIS2&dlat=%lf&dlon=%lf&dname=%@&dev=0&m=0&t=0",
                                   self.location.coordinate.latitude, self.location.coordinate.longitude,latitude, longitude,self.device.szName];
            urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{}completionHandler:^(BOOL success) {
                if (!success) {
                    
                    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"不能完成跳转" message:@"请确认App已经安装" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
                    
                    [aler addAction:cancelAction];
                    
                    [self  presentViewController:aler animated:YES completion:nil];
                    
                }
                
                
            }];
        }];
        [actionSheet addAction:PhotoAlbum];
        
        
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
        UIAlertAction *camera = [UIAlertAction actionWithTitle:baiduMap style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray* temp=[self.device.szCoordinate componentsSeparatedByString:@","];
            CLLocationDegrees latitude = [[temp objectAtIndex:1] doubleValue];
            CLLocationDegrees longitude = [[temp objectAtIndex:0] doubleValue];
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving&coord_type=gcj02",latitude,longitude,self.device.szName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
            
            
            
        }];
        [actionSheet addAction:camera];
        
        
    }
    UIAlertAction *appleMap = [UIAlertAction actionWithTitle:appleMapstr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray* temp=[self.device.szCoordinate componentsSeparatedByString:@","];
        CLLocationDegrees latitude = [[temp objectAtIndex:1] doubleValue];
        CLLocationDegrees longitude = [[temp objectAtIndex:0] doubleValue];
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(latitude,longitude );
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
        toLocation.name=self.device.szName;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    [actionSheet addAction:appleMap];
    [actionSheet addAction:cancel];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


@end
