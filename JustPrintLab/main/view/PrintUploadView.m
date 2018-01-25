//
//  PrintUploadView.m
//  JustPrintLab
//
//  Created by 陈鑫荣 on 2018/1/23.
//  Copyright © 2018年 justprint. All rights reserved.
//

#import "PrintUploadView.h"
#import "UploadButton.h"

@implementation PrintUploadView

-(instancetype)init{
    if ([super init]) {
        if (self) {
            self.frame=[UIScreen mainScreen].bounds;
            UIView*shadowView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            shadowView.backgroundColor = [UIColor blackColor];
            shadowView.alpha = 0.2;
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PrintUploadViewClick:)];
            [shadowView addGestureRecognizer:tapGesturRecognizer];
            [self addSubview:shadowView];
            
            UIView *btnbackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 160*ScreenHeight/568)];
            btnbackView.backgroundColor=[UIColor whiteColor];
            [self addSubview:btnbackView];
            for (int i=0; i<6; i++) {
                UIView*line=[[UIView alloc]init];
                UploadButton*uploadBtn=[[UploadButton alloc]initWithFrame:CGRectMake(ScreenWidth*(i%3)/3, 80*ScreenHeight*(i/3)/568, ScreenWidth/3, 80*ScreenHeight/568)];
                uploadBtn.tag=900+i;
                [uploadBtn addTarget:self action:@selector(PrintUploadViewImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btnbackView addSubview:uploadBtn];
                switch (i) {
                    case 0:
                        [uploadBtn setImage:[UIImage imageNamed:@"upload_pc"] forState:UIControlStateNormal];
                        [uploadBtn setTitle:@"PC端上传" forState:UIControlStateNormal];
                        line.frame=CGRectMake(10, 80*ScreenHeight/568, ScreenWidth-20, 1);
                        break;
                    case 1:
                        [uploadBtn setImage:[UIImage imageNamed:@"upload_cloud"] forState:UIControlStateNormal];
                        [uploadBtn setTitle:@"云端上传" forState:UIControlStateNormal];
                        line.frame=CGRectMake(ScreenWidth/3, 10, 1, 80*ScreenHeight/568-20);
                        break;
                    case 2:
                        [uploadBtn setImage:[UIImage imageNamed:@"upload_image"] forState:UIControlStateNormal];
                        [uploadBtn setTitle:@"图片上传" forState:UIControlStateNormal];
                        line.frame=CGRectMake(2*ScreenWidth/3, 10, 1, 80*ScreenHeight/568-20);
                        break;
                    case 3:
                        [uploadBtn setImage:[UIImage imageNamed:@"upload_wechat"] forState:UIControlStateNormal];
                        [uploadBtn setTitle:@"微信上传" forState:UIControlStateNormal];
                        line.frame=CGRectMake(ScreenWidth/3,  80*ScreenHeight/568+10, 1, 80*ScreenHeight/568-20);
                        break;
                    case 4:
                        [uploadBtn setImage:[UIImage imageNamed:@"upload_qq"] forState:UIControlStateNormal];
                        [uploadBtn setTitle:@"QQ上传" forState:UIControlStateNormal];
                        line.frame=CGRectMake(2* ScreenWidth/3,  80*ScreenHeight/568+10, 1, 80*ScreenHeight/568-20);
                        break;
                    case 5:
                        [uploadBtn setImage:[UIImage imageNamed:@"upload_cert"] forState:UIControlStateNormal];
                        [uploadBtn setTitle:@"证件上传" forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                line.backgroundColor=JpColor(210, 210, 210);
               
                [btnbackView addSubview:line];
            }
            
        }
    }
    return self;
}


-(void)PrintUploadViewClick:(UIView*)view{
    [self removeFromSuperview];
   
}
-(void)PrintUploadViewImageBtnClick:(UIButton*)btn{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(PrintUploadViewImageBtnClick:)]) {
        [self.delegate PrintUploadViewImageBtnClick:btn];
    }
    
}

@end
