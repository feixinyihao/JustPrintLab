//
//  CommonFunc.m
//  justprint
//
//  Created by 陈鑫荣 on 2017/8/28.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "CommonFunc.h"
#import <CommonCrypto/CommonCrypto.h>
#import "LoginViewController.h"
#import "UniHttpTool.h"
#import "MBProgressHUD+MJ.h"
#define    LocalStr_None        @""
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation CommonFunc
+ (NSString *)base64StringFromText:(NSString *)text

{
    
    if (text && ![text isEqualToString:LocalStr_None]) {
        
        //取项目的bundleIdentifier作为KEY  改动了此处
        
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        
        //IOS 自带DES加密 Begin  改动了此处
        
        //data = [self DESEncrypt:data WithKey:key];
        
        //IOS 自带DES加密 End
        
        return [self base64EncodedStringFrom:data];
        
    }
    
    else {
        
        return LocalStr_None;
        
    }
    
}

+ (NSString *)textFromBase64String:(NSString *)base64

{
    
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        
        //取项目的bundleIdentifier作为KEY  改动了此处
        
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        
        NSData *data = [self dataWithBase64EncodedString:base64];
        
        //IOS 自带DES解密 Begin    改动了此处
        
        //data = [self DESDecrypt:data WithKey:key];
        
        //IOS 自带DES加密 End
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
    }
    
    else {
        
        return LocalStr_None;
        
    }
    
}

/******************************************************************************
 
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 
 函数描述 : 文本数据进行DES加密
 
 输入参数 : (NSData *)data
 
 (NSString *)key
 
 输出参数 : N/A
 
 返回参数 : (NSData *)
 
 备注信息 : 此函数不可用于过长文本
 
 ******************************************************************************/

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key

{
    
    char keyPtr[kCCKeySizeAES256+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeDES,
                                          
                                          NULL,
                                          
                                          [data bytes], dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}

/******************************************************************************
 
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 
 函数描述 : 文本数据进行DES解密
 
 输入参数 : (NSData *)data
 
 (NSString *)key
 
 输出参数 : N/A
 
 返回参数 : (NSData *)
 
 备注信息 : 此函数不可用于过长文本
 
 ******************************************************************************/

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key

{
    
    char keyPtr[kCCKeySizeAES256+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeDES,
                                          
                                          NULL,
                                          
                                          [data bytes], dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}

/******************************************************************************
 
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 
 函数描述 : base64格式字符串转换为文本数据
 
 输入参数 : (NSString *)string
 
 输出参数 : N/A
 
 返回参数 : (NSData *)
 
 备注信息 :
 
 ******************************************************************************/

+ (NSData *)dataWithBase64EncodedString:(NSString *)string

{
    
    if (string == nil)
        
        [NSException raise:NSInvalidArgumentException format:nil];
    
    if ([string length] == 0)
        
        return [NSData data];
    
    static char *decodingTable = NULL;
    
    if (decodingTable == NULL)
        
    {
        
        decodingTable = malloc(256);
        
        if (decodingTable == NULL)
            
            return nil;
        
        memset(decodingTable, CHAR_MAX, 256);
        
        NSUInteger i;
        
        for (i = 0; i < 64; i++)
            
            decodingTable[(short)encodingTable[i]] = i;
        
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    
    if (characters == NULL)    //  Not an ASCII string!
        
        return nil;
    
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    
    if (bytes == NULL)
        
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    
    while (YES)
        
    {
        
        char buffer[4];
        
        short bufferLength;
        
        for (bufferLength = 0; bufferLength < 4; i++)
            
        {
            
            if (characters[i] == '\0')
                
                break;
            
            if (isspace(characters[i]) || characters[i] == '=')
                
                continue;
            
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
                
            {
                
                free(bytes);
                
                return nil;
                
            }
            
        }
        
        if (bufferLength == 0)
            
            break;
        
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
            
        {
            
            free(bytes);
            
            return nil;
            
        }
        
        //  Decode the characters in the buffer to bytes.
        
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        
        if (bufferLength > 2)
            
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        
        if (bufferLength > 3)
            
            bytes[length++] = (buffer[2] << 6) | buffer[3];
        
    }
    
    bytes = realloc(bytes, length);
    
    return [NSData dataWithBytesNoCopy:bytes length:length];
    
}

/******************************************************************************
 
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 
 函数描述 : 文本数据转换为base64格式字符串
 
 输入参数 : (NSData *)data
 
 输出参数 : N/A
 
 返回参数 : (NSString *)
 
 备注信息 :
 
 ******************************************************************************/

+ (NSString *)base64EncodedStringFrom:(NSData *)data

{
    
    if ([data length] == 0)
        
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    
    if (characters == NULL)
        
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    
    while (i < [data length])
        
    {
        
        char buffer[3] = {0,0,0};
        
        short bufferLength = 0;
        
        while (bufferLength < 3 && i < [data length])
            
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        
        if (bufferLength > 1)
            
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        
        else characters[length++] = '=';
        
        if (bufferLength > 2)
            
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        
        else characters[length++] = '=';
        
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
    
}

+(NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

+(BOOL)isPhoneNum:(NSString*)mobileNum{
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}


+(NSString*)dataFromString:(NSString*)string{
    if (![string isKindOfClass:[NSNull class]]&&string) {
        if (string.length==8) {
            return [NSString stringWithFormat:@"%@-%@-%@",[string substringWithRange:NSMakeRange(0, 4)],[string substringWithRange:NSMakeRange(4, 2)],[string substringWithRange:NSMakeRange(6, 2)]];
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}


+(NSString*)timeFromString:(NSString*)string{
    if (![string isKindOfClass:[NSNull class]]&&string) {
        if (string.length==5) {
            string=[@"0" stringByAppendingString:string];
            return [NSString stringWithFormat:@"%@:%@:%@",[string substringWithRange:NSMakeRange(0, 2)],[string substringWithRange:NSMakeRange(2, 2)],[string substringWithRange:NSMakeRange(4, 2)]];
        }else if (string.length==6){
            return [NSString stringWithFormat:@"%@:%@:%@",[string substringWithRange:NSMakeRange(0, 2)],[string substringWithRange:NSMakeRange(2, 2)],[string substringWithRange:NSMakeRange(4, 2)]];
        }else if (string.length==4){
            return [NSString stringWithFormat:@"%@:%@",[string substringWithRange:NSMakeRange(0, 2)],[string substringWithRange:NSMakeRange(2, 2)]];
        }else if (string.length==3){
            string=[@"0" stringByAppendingString:string];
            return [NSString stringWithFormat:@"%@:%@",[string substringWithRange:NSMakeRange(0, 2)],[string substringWithRange:NSMakeRange(2, 2)]];
        }
        else{
            return @"";
        }
        
    }else{
        return @"";
    }
}

/**
 token过期返回登录页面
 */
+(void)backToLogon{
    [MBProgressHUD showText:@"请重新登录"];
        // 获取要删除的路径
    NSString *deletePath = [DocumentFile stringByAppendingPathComponent:@"/accout.data"];
        // 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
        // 删除
    BOOL isDelete = [manager removeItemAtPath:deletePath error:nil];
    if (isDelete) {
        LoginViewController*login=[[LoginViewController alloc]init];
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController=login;
           
    }
    
    
}

/**
 获取当前的viewcontroller

 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

+(void)getBalance:(void (^)(id  json))success{
    NSString*url=[NSString stringWithFormat:@"%@/ajax/cac.aspx?act=get_balance",RootURL];
    [UniHttpTool getWithUrl:url parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id json) {
        if (success) {
            success(json);
            
        }
        
    } failure:^(NSError *error) {
        
       // [MBProgressHUD showText:@"小J出意外了"];
    }];
}

+(void)alert:(NSString*)title withMessage:(NSString*)message :(void (^)(UIAlertAction *acton))success{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//创建界面
    NSString*signout=@"确定";
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:signout style:UIAlertActionStyleDefault handler:^(UIAlertAction *acton){
        if (success) {
            success(acton);
        }
       
    }];
    NSString*cancel=@"取消";
    UIAlertAction *otherAction=[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction *acton){}];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [[self getCurrentVC] presentViewController: alertController animated:YES completion:nil];
}

+ (void)actionSheet:(NSString*)title1 withTitle2:(NSString*)title2 {
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *pickAction = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:pickAction];
    [actionSheetController addAction:showAllInfoAction];
    
    [[self getCurrentVC] presentViewController:actionSheetController animated:YES completion:nil];
}

+(NSString*)stringByTrim:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(BOOL)isincluded:(NSString*)str in:(NSString*)supStr{
    
    if([supStr rangeOfString:str].location !=NSNotFound){
        return YES;
    }else
        return NO;
}
/**
 403 表示理光内嵌  103 表示施乐内嵌  601 桌面打印机  503 照片打印
 */

+(NSString*)fromModel:(NSInteger)model{
    switch (model) {
        case 403:
            return @"理光内嵌";
            break;
        case 103:
            return @"施乐内嵌";
            break;
        case 601:
            return @"桌面打印机";
            break;
        case 503:
            return @"照片打印";
            break;
        case 0:
            return @"人工";
            break;
        default:
            return @"未知";
            break;
    }
}
+(NSString*)fromStrTime:(NSString*)time{
    time=[NSString stringWithFormat:@"%@",time];
    if ([time integerValue]==0) {
        return @"00:00";
    }else if (time.length==3){
        time=[@"0" stringByAppendingString:time];
        return [NSString stringWithFormat:@"%@:%@",[time substringWithRange:NSMakeRange(0, 2)],[time substringWithRange:NSMakeRange(2, 2)]];
    }else if (time.length==4){
        return [NSString stringWithFormat:@"%@:%@",[time substringWithRange:NSMakeRange(0, 2)],[time substringWithRange:NSMakeRange(2, 2)]];
    }else{
        return @"未知";
    }
}
@end
