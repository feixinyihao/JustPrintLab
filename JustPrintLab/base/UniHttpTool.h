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



+(void)uploadWithparameters:(id)parameters
                     name:(NSString *)name
                 filename:(NSString*)filename
               uploadData:(NSData*)data
                 mineType:(NSString*)mineType
                  success:(void (^)(id  json))success;

+(void)AFNetworkStatus;





+(NSString*)getLogonName;
+(NSString*)getNickName;
+(NSString*)getShowName;
+(BOOL)isWechatOrAlipay;
+(NSString*)getHeadImgUrl;
+(NSInteger)getNativeBalance;
+(NSInteger)getNativeSubsidy;
@end
