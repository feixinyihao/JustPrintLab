//
//  CommonFunc.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/8/28.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonFunc : NSObject

/**
 文本数据转换为base64格式字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text;


/**
 base64格式字符串转换为文本数据
 */
+ (NSString *)textFromBase64String:(NSString *)base64;


/**
 传入字符串，返回MD5加密后结果
 */
+(NSString *)md5:(NSString *)string;

/**
 判断是否是手机号
 */
+(BOOL)isPhoneNum:(NSString*)mobileNum;

/**
 根据字符串的日期格式返回YY-MM-DD
 */
+(NSString*)dataFromString:(NSString*)string;

/**
 根据字符串的时间返回hh:mm:ss
 */
+(NSString*)timeFromString:(NSString*)string;

+(void)backToLogon;
+(UIViewController *)getCurrentVC;

+(void)getBalance:(void (^)(id  json))success;
@end
