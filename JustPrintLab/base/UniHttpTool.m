//
//  UniHttpTool.m
//  
//
//  Created by 陈鑫荣 on 16/7/1.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "UniHttpTool.h"
#import<CommonCrypto/CommonDigest.h>
#import "Account.h"
#import "CommonFunc.h"
#import "MBProgressHUD+MJ.h"
@interface UniHttpTool()

@property(nonatomic,strong)MBProgressHUD*HUD;
@end
@implementation UniHttpTool





+(void)postWithUrl:(NSString *)url
        parameters:(id)parameters
          progress:(void (^)(NSProgress *progress))uploadProgress
           success:(void (^)(id json))success
           failure:(void (^)(NSError *error ))failure{

    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    NSString*afnURL=[NSString stringWithFormat:@"%@%@",url,[self getCommonParams]];
    afnURL= [afnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:afnURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [MBProgressHUD showText:@"网络已断开"];
        }else if (error.code == -1005){
            [MBProgressHUD showText:@"网络连接已中断"];
        }else if(error.code == -1001){
            [MBProgressHUD showText:@"请求超时"];
        }else if (error.code == -1003){
            [MBProgressHUD showText:@"未能找到使用指定主机名的服务器"];
        }else{
            [MBProgressHUD showText:@"小J出意外了"];
        }
        if (failure) {
            failure(error);
        }
    }];
        
}

-(void)postWithUrl:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *progress))uploadProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    NSString*afnURL=[NSString stringWithFormat:@"%@%@",url,[self getCommonParams]];
    afnURL= [afnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:afnURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [MBProgressHUD showText:@"网络已断开"];
        }else if (error.code == -1005){
            [MBProgressHUD showText:@"网络连接已中断"];
        }else if(error.code == -1001){
            [MBProgressHUD showText:@"请求超时"];
        }else if (error.code == -1003){
            [MBProgressHUD showText:@"未能找到使用指定主机名的服务器"];
        }else{
            [MBProgressHUD showText:@"小J出意外了"];
        }
        if (failure) {
            failure(error);
        }
    }];

}

+(void)getWithUrl:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *progress))uploadProgress
          success:(void (^)(id  json))success
          failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];

     NSString*afnURL=[NSString stringWithFormat:@"%@%@",url,[self getCommonParams]];
     afnURL= [afnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:afnURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [MBProgressHUD showText:@"网络已断开"];
        }else if (error.code == -1005){
            [MBProgressHUD showText:@"网络连接已中断"];
        }else if(error.code == -1001){
            [MBProgressHUD showText:@"请求超时"];
        }else if (error.code == -1003){
            [MBProgressHUD showText:@"未能找到使用指定主机名的服务器"];
        }else{
            [MBProgressHUD showText:@"小J出意外了"];
        }
        if (failure) {
            failure(error);
        }
    }];


}

-(void)getWithUrl:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *progress))uploadProgress
          success:(void (^)(id  json))success
          failure:(void (^)(NSError *error))failure{

    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
     NSString*afnURL=[NSString stringWithFormat:@"%@%@",url,[self getCommonParams]];
     afnURL= [afnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:afnURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [MBProgressHUD showText:@"网络已断开"];
        }else if (error.code == -1005){
            [MBProgressHUD showText:@"网络连接已中断"];
        }else if(error.code == -1001){
            [MBProgressHUD showText:@"请求超时"];
        }else if (error.code == -1003){
            [MBProgressHUD showText:@"未能找到使用指定主机名的服务器"];
        }else{
            [MBProgressHUD showText:@"小J出意外了"];
        }
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)AFNetworkStatus
{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DLog(@"无网络");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DLog(@"蜂窝数据网");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
    [manager startMonitoring];
}


+(void)postWithparameters:(id)parameters
             image:(UIImage*)image
              name:(NSString *)name
          filename:(NSString*)filename
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))FData
          uploadFileProgress:(void (^)(NSProgress *progress))uploadFileProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure{
    NSString* URL=[NSString stringWithFormat:@"%@/ajax/file.aspx?act=upload",RootURL];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           
        if (formData) {
            FData(formData);
        }

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (uploadProgress) { //上传进度
            uploadFileProgress (uploadProgress);
        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            
           
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [MBProgressHUD showError:@"网络已断开"];
        }else if (error.code == -1005){
            [MBProgressHUD showError:@"网络连接已中断"];
        }else if(error.code == -1001){
            [MBProgressHUD showError:@"请求超时"];
        }else if (error.code == -1003){
            [MBProgressHUD showError:@"未能找到使用指定主机名的服务器"];
        }else{
            [MBProgressHUD showError:@"上传失败"];
        }
        
        if (failure!=nil) {
            failure(error);
        }

    }];

}


/**
 返回url的公共参数
 */
+(NSString*)getCommonParams{

    return [[[self alloc]init] getCommonParams];
}
-(NSString*)getCommonParams{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSString*uid=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString*version=@"101280001";
    NSString*params=@"";
    if (acc) {
        params=[NSString stringWithFormat:@"&_from=app&token=%@&uid=%@&i_version=%@&_=1497593264486",acc.token,uid,version];
    }else{
        params=[NSString stringWithFormat:@"&_from=app&uid=%@&i_version=%@",uid,version];
    }
    
    return params;
}
+(NSString*)getNickName{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (acc.nickname&&![acc.nickname isKindOfClass:[NSNull class]]) {
        return acc.nickname;
    }else{
        return @"";
    }
}
+(NSString*)getLogonName{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    return acc.pid;
}
+(NSString*)getShowName{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (acc.nickname&&![acc.nickname isKindOfClass:[NSNull class]]) {
        return acc.nickname;
    }else{
        return acc.pid;
    }
}

+(BOOL)isWechatOrAlipay{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (acc.nickname&&![acc.nickname isKindOfClass:[NSNull class]]) {
        return YES;
    }else{
        return NO;
    }
}
+(NSString*)getHeadImgUrl{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (acc.nickname&&![acc.nickname isKindOfClass:[NSNull class]]) {
        return acc.headimgurl;
    }else{
        return @"";
    }
}
+(NSInteger)getNativeBalance{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSInteger balance=[acc.balance integerValue];
    return balance;
}
+(NSInteger)getNativeSubsidy{
    NSString* file=[DocumentFile stringByAppendingString:@"/accout.data"];
    Account * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSInteger subsidy=[acc.subsidy integerValue];
    return subsidy;
    
}

-(void)uploadWithparameters:(id)parameters
                     name:(NSString *)name
                 filename:(NSString*)filename
               uploadData:(NSData*)data
                 mineType:(NSString*)mineType
                  success:(void (^)(id  json))success{
    NSString* URL=[NSString stringWithFormat:@"%@/ajax/file.aspx?act=upload",RootURL];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [self hudTipWillShow:YES];
        [formData appendPartWithFileData:data name:name fileName:filename  mimeType:mineType];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        self.HUD.progress=uploadProgress.fractionCompleted;
    
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hudTipWillShow:NO];
        if (success) {
            success(responseObject);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hudTipWillShow:NO];
        if (error.code == -1009) {
            [MBProgressHUD showError:@"网络已断开"];
        }else if (error.code == -1005){
            [MBProgressHUD showError:@"网络连接已中断"];
        }else if(error.code == -1001){
            [MBProgressHUD showError:@"请求超时"];
        }else if (error.code == -1003){
            [MBProgressHUD showError:@"未能找到使用指定主机名的服务器"];
        }else{
            [MBProgressHUD showError:@"上传失败"];
        }
        
    }];
    
}
+(void)uploadWithparameters:(id)parameters
                     name:(NSString *)name
                 filename:(NSString*)filename
               uploadData:(NSData*)data
                 mineType:(NSString*)mineType
                  success:(void (^)(id  json))success{
    [[[self alloc]init] uploadWithparameters:parameters name:name filename:filename uploadData:data mineType:mineType success:^(id json) {
        if (success) {
             success(json);
        }
       
    }];
}
#pragma mark -- init MBProgressHUD
-(void)hudTipWillShow:(BOOL)willShow{
    if (willShow) {
        [[CommonFunc getCurrentVC] resignFirstResponder];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!_HUD) {
            _HUD = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
            _HUD.mode = MBProgressHUDModeDeterminate;
            _HUD.progress = 0;
            _HUD.labelText = @"上传中";
            _HUD.removeFromSuperViewOnHide = YES;
        }else{
            _HUD.progress = 0;
            _HUD.labelText = @"上传中";
            [keyWindow addSubview:_HUD];
            [_HUD show:YES];
        }
    }else{
        [_HUD hide:YES];
    }
}
@end
