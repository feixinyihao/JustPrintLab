//
//  UniHttpTool.h
//  
//
//  Created by 陈鑫荣 on 16/7/1.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>



@interface UniHttpTool : NSObject

@property(nonatomic,strong)AFHTTPSessionManager*manager;


+(void)postWithUrl:(NSString *)url
        parameters:(id)parameters
          progress:(void (^)(NSProgress *progress))uploadProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure;

-(void)postWithUrl:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *progress))uploadProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure;
+(void)getWithUrl:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *progress))uploadProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure;

-(void)getWithUrl:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *progress))uploadProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure;

+(void)AFNetworkStatus;


+(void)postWithparameters:(id)parameters
         image:(UIImage*)image
              name:(NSString *)name
          filename:(NSString*)filename
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))FData
          uploadFileProgress:(void (^)(NSProgress *progress))uploadFileProgress
           success:(void (^)(id  json))success
           failure:(void (^)(NSError *error))failure;


+(NSString*)getLogonName;
+(NSString*)getNickName;
+(NSString*)getShowName;
+(BOOL)isWechatOrAlipay;
+(NSString*)getHeadImgUrl;
+(NSInteger)getNativeBalance;
+(NSInteger)getNativeSubsidy;
@end
