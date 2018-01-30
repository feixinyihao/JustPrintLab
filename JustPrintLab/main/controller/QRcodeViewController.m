//
//  QRcodeViewController.m
//  UniVersion
//
//  Created by 陈鑫荣 on 16/7/11.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "QRcodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD+MJ.h"
#import "CoverView.h"
#import "CommonFunc.h"
#import "PushViewController.h"
#import "UniHttpTool.h"
#import "CertificationSccessViewController.h"
@interface QRcodeViewController()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *preview;

@property(nonatomic,strong)UIView* caves;
@end
@implementation QRcodeViewController

-(void)viewDidLoad{
    self.title=@"二维码";
    self.view.backgroundColor=[UIColor blackColor];
    self.caves=[[UIView alloc]init];
    self.caves.frame=[UIScreen mainScreen].bounds;
    //self.caves.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.caves];
    [MBProgressHUD showHUDAddedTo:self.caves animated:YES];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}


-(void)Animate{
    [self deleteScanAnimate];
    [self addscananimate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addscananimate];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.caves removeFromSuperview];
    [MBProgressHUD hideHUDForView:self.caves animated:YES];
    //[self deleteScanAnimate];
    [self setupCamera];
 

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];


}
-(void)deleteScanAnimate{
    for (UIView*view in self.view.subviews) {
        if (view.tag==1001||view.tag==1002||view.tag==1003) {
            [view removeFromSuperview];
        }
    }
}
-(void)addscananimate{
    
    CoverView* cover=[[CoverView alloc]init];
    cover.frame=self.view.bounds;
    cover.tag=1001;
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    UIImageView*scanBox=[[UIImageView alloc]initWithFrame:CGRectMake(w*50/320, (h*180/576)-40, w*220/320, w*220/320)];
    scanBox.image=[UIImage imageNamed:@"qr_border"];
    scanBox.tag=1003;
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(w*60/320, (h*190/576)-40, w*200/320, 4)];
    line.image = [UIImage imageNamed:@"land_scanning_wire"];
    line.tag=1002;

    [self.view addSubview:cover];
    [self.view addSubview:scanBox];
    [self.view addSubview:line ];
    
    
    
    /* 添加动画 */
    
    [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        line.frame = CGRectMake(w*60/320, (h*390/576)-40, w*200/320, 4);
    } completion:nil];

}
- (void)setupCamera{
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (error) {
        [MBProgressHUD showText:@"没有摄像头"];
        CertificationSccessViewController*success=[[CertificationSccessViewController alloc]init];
        [self.navigationController pushViewController:success animated:YES];
        return;

    }else{
    
        self.input =input;

    }
    // Output
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    // 条码类型
//    AVMetadataObjectTypeUPCECode
//    AVMetadataObjectTypeCode39Code
//    AVMetbadataObjectTypeCode39Mod43Code
//    AVMetadataObjectTypeEAN13Code
//    AVMetadataObjectTypeEAN8Code
//    AVMetadataObjectTypeCode93Code
//    AVMetadataObjectTypeCode128Code
//    AVMetadataObjectTypePDF417Code
//    AVMetadataObjectTypeQRCode
//    AVMetadataObjectTypeAztecCode
    self.output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode
                                      ];
    
    // Preview
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
//    self.preview.frame=CGRectMake(self.view.frame.size.width/16,self.view.frame.size.height/4,self.view.frame.size.height/2,self.view.frame.size.height/2);
    self.preview.frame=CGRectMake(0, 0,ScreenWidth, ScreenHeight);
    [self.view.layer addSublayer:self.preview];
    [self Animate];
    UILabel*tipsL=[[UILabel alloc]initWithFrame:CGRectMake(0, (ScreenHeight*180/576)-40+ScreenWidth*220/320+10, ScreenWidth, 20)];
    tipsL.text=@"将二维码放入框内，即可自动扫描";
    tipsL.font=[UIFont systemFontOfSize:12];
    tipsL.textColor=[UIColor whiteColor];
    tipsL.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:tipsL];
    // Start
    [self.session startRunning];
    //扫码范围
    CGRect intertRect = [self.preview metadataOutputRectOfInterestForRect:CGRectMake(ScreenWidth*50/320, (ScreenHeight*180/576)-40, ScreenWidth*220/320, ScreenWidth*220/320)];
    self.output.rectOfInterest = intertRect;
}

//扫码成功调用代理方法
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [_session stopRunning];
    NSString*stringValue=@"";
    if ([metadataObjects count] >0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }

    if ([CommonFunc isincluded:KURL in:stringValue]) {
        if ([CommonFunc isincluded:@"org=web" in:stringValue]) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSArray*temp=[stringValue componentsSeparatedByString:@"&"];
            NSString*code=[temp[1] substringFromIndex:2];
            NSString*state=[code substringFromIndex:7];
            NSDictionary*parm=@{@"state":state,@"code":code,@"pid":[UniHttpTool getLogonName]};
            NSString*url=[NSString stringWithFormat:@"%@/uniwx/appAuth.aspx?org=web",RootURL];
            [UniHttpTool getWithUrl:url parameters:parm progress:^(NSProgress *progress) {
                
            } success:^(id json) {
                DLog(@"%@",json);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([json[@"ret"] integerValue]==1) {
                    CertificationSccessViewController*success=[[CertificationSccessViewController alloc]init];
                    success.showMsg=json[@"msg"];
                    [self.navigationController pushViewController:success animated:YES];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        }

    }else{
        [MBProgressHUD showText:@"无效二维码"];
        [_session startRunning];
    }

    
}

@end
