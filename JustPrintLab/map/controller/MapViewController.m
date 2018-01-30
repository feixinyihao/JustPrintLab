//
//  MapViewController.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/19.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "MapViewController.h"
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"
#import "UniHttpTool.h"
#import "JpDevice.h"
#import "CommonFunc.h"
#import "CustomMAPointAnnotation.h"
#import "CustomAnnotationView.h"
#import "TradingHour.h"
#import "PrinterInfoView.h"
#import "UIView+cxr.h"
#import "PrinterInfoViewController.h"

@interface MapViewController ()<MAMapViewDelegate,PrinterInfoViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AnimatedAnnotation *animatedCarAnnotation;
@property (nonatomic, strong) AnimatedAnnotation *animatedTrainAnnotation;

@property (nonatomic, strong) NSMutableArray *annotations;

@property(nonatomic,strong)NSArray*device;

@end

@implementation MapViewController

@synthesize animatedCarAnnotation = _animatedCarAnnotation;
@synthesize animatedTrainAnnotation = _animatedTrainAnnotation;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    //定位按钮
    UIButton*locationBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, ScreenHeight-100, 25, 25)];
    [locationBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(getLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    [self servicesEnabled];
    [self initAnnotations];
    
    //自定义背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //消除阴影
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
   // self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)getLocation{
     [self servicesEnabled];
     self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}
//从服务器获取坐标点
- (void)initAnnotations
{
    
    NSString*url=[NSString stringWithFormat:@"%@/ajax/device.aspx?act=get_printer",RootURL];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
       // DLog(@"%@",json[@"data"]);
        if (![json[@"data"] isKindOfClass:[NSNull class]]) {
            NSMutableArray*devArr=[NSMutableArray array];
            for (NSDictionary *devDic in json[@"data"]) {
                JpDevice*dev=[JpDevice JpDeviceWithDict:devDic];
                [devArr addObject:dev];
            }
            self.device=devArr;
            [self addannotation];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
//添加坐标点
-(void)addannotation{
    
    for (int i=0;i<self.device.count;i++) {
        JpDevice* device=self.device[i];
        if (![device.szCoordinate isKindOfClass:[NSNull class]]&&![device.szCoordinate isEqualToString:@""]) {
            NSArray* coordinateArray = [device.szCoordinate  componentsSeparatedByString:@","];
            //DLog(@"经纬度:%@",device.szCoordinate);
            if (coordinateArray.count==2) {
                if ( ![coordinateArray[0] isEqualToString:@""] && ![coordinateArray[1] isEqualToString:@""]) {
                    CLLocationDegrees latitude = [[coordinateArray objectAtIndex:1] doubleValue];
                    CLLocationDegrees longitude = [[coordinateArray objectAtIndex:0] doubleValue];
                    CLLocationCoordinate2D point=CLLocationCoordinate2DMake(latitude, longitude);
                    CustomMAPointAnnotation*a1 = [[CustomMAPointAnnotation alloc] init];
                    //MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
                    a1.coordinate = point;
                    a1.device=device;
                    [self.annotations addObject:a1];
                    
                }
                
            }
        }
        
    }
    [self.mapView addAnnotations:self.annotations];
    
    
}
#pragma mark - MAMapViewDelegate

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[CustomMAPointAnnotation class]])
    {
        CustomMAPointAnnotation* cust=annotation;
        //自定义view
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, 0);
            
        }
        annotationView.device=cust.device;
        if (![cust.device.mfpFullInfo.TradingHourArr isKindOfClass:[NSNull class]]) {
            for (int i=0; i<cust.device.mfpFullInfo.TradingHourArr.count; i++) {
                TradingHour*tradingHour=[TradingHour tradingHourWithDict:cust.device.mfpFullInfo.TradingHourArr[i]];
                // DLog(@"---%ld---%ld-----%@",[self currentWeek],[tradingHour.dwStartDay integerValue],tradingHour.dwEndDay);
                if ([self currentWeek]>=[tradingHour.dwStartDay integerValue]&&[self currentWeek]<=[tradingHour.dwEndDay intValue]&&[tradingHour.dwOpenFlag intValue]==1) {
                    NSString*beginTime=[NSString stringWithFormat:@"%@",tradingHour.dwBeginTime];
                    NSString*endTime=[NSString stringWithFormat:@"%@",tradingHour.dwEndTime];
                    NSDate *date = [NSDate date];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    [formatter setDateFormat:@"HHmm"];
                    
                    NSString *DateTime = [formatter stringFromDate:date];
                    if ([DateTime integerValue]>=[beginTime integerValue]&&[DateTime integerValue]<[endTime integerValue]) {
                        if (([cust.device.dwRole intValue]&8)>0) {
                            
                            annotationView.portrait = [UIImage imageNamed:@"mark_b_open"];
                        }else if ((cust.device.dwCtrlType&65536)>0) {
                            annotationView.portrait = [UIImage imageNamed:@"mark_c_open"];
                        }
                        else{
                            annotationView.portrait = [UIImage imageNamed:@"mark_a_open"];
                        }
                    }else{
                        if (([cust.device.dwRole intValue]&8)>0) {
                            
                            annotationView.portrait = [UIImage imageNamed:@"mark_b_close"];
                        }else if ((cust.device.dwCtrlType&65536 )>0) {
                            annotationView.portrait = [UIImage imageNamed:@"mark_c_close"];
                        }
                        else{
                            annotationView.portrait = [UIImage imageNamed:@"mark_a_close"];
                        }
                        
                    }
                    
                    break;
                    
                }else{
                    if (([cust.device.dwRole intValue]&8)>0) {
                        
                        annotationView.portrait = [UIImage imageNamed:@"mark_b_close"];
                    }else if ((cust.device.dwCtrlType&65536 )>0) {
                        annotationView.portrait = [UIImage imageNamed:@"mark_c_close"];
                    }
                    else{
                        annotationView.portrait = [UIImage imageNamed:@"mark_a_close"];
                    }
                    
                    
                }
                
            }
        }else{
            
            DLog(@"%@",cust.device.szName);
        }
        annotationView.name = cust.device.szName;
        return annotationView;
        
    }
    
    return nil;
}
- (void)modeAction:(UISegmentedControl *)sender
{
    
    // self.mapView.userTrackingMode = sender.selectedSegmentIndex;
    [UIView animateWithDuration:1.0f animations:^{
        self.mapView.userTrackingMode=1;
        
    }];
    DLog(@"%f,%f",self.mapView.userLocation.coordinate.latitude,self.mapView.userLocation.coordinate.longitude);
}
//返回周几数字
-(NSInteger)currentWeek{
    
    NSArray*arr=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSInteger n = 0;
    for (int i=0; i<arr.count; i++) {
        if ([arr[i] isEqualToString:[self currentDateWithFormatter]]) {
            n=i;
            break;
            
        }else{
            
            n=-1;
        }
        
    }
    //DLog(@"--%ld--",n);
    return n;
}
//返回当前周几
- (NSString *)currentDateWithFormatter
{
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *zh_Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    [dateFormat setLocale:zh_Locale];
    [dateFormat setDateFormat:@"EEE"];
    NSString *weekString = [dateFormat stringFromDate:[NSDate date]];
    //DLog(@"--%@--",weekString);
    return weekString;
}
- (void)servicesEnabled
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        // 没有权限，
        
        DLog(@"没有权限");
    }
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
  
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView* custView=(CustomAnnotationView*)view;
        JpDevice*device=custView.device;
        [self setupDevInfo:device];
       // DLog(@"%@",device.szName);
    }
    
}
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {

}
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    UIView*infoview=[self.view viewWithTag:999];
    [infoview removeFromSuperviewWithAnimation];
}

-(void)setupDevInfo:(JpDevice*)device;{

    PrinterInfoView*infoView=[[PrinterInfoView alloc]initWithFrame:CGRectMake(0, ScreenHeight-129, ScreenWidth, 80) device:device];
    infoView.delegate=self;
    infoView.tag=999;
    [self.view addSubviewWithAnimation:infoView];

    
}
#pragma mark getter/setter
-(NSArray *)device{
    if (_device==nil) {
        _device=[NSArray array];
    }
    return _device;
}
-(NSMutableArray *)annotations{
    if (_annotations==nil) {
        _annotations=[NSMutableArray array];
    }
    return _annotations;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark PrintInfoViewDelegate
-(void)PrinterInfoViewClick:(JpDevice *)device{
    PrinterInfoViewController*infoview=[[PrinterInfoViewController alloc]init];
    infoview.device=device;
    infoview.location=self.mapView.userLocation;
    [infoview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoview animated:YES];
}
@end
