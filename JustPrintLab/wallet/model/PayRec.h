//
//  PayRec.h
//  justprint
//
//  Created by 陈鑫荣 on 2017/9/11.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayRec : NSObject
@property(nonatomic,copy)NSString*date;
@property(nonatomic,copy)NSString*lsh;
@property(nonatomic,copy)NSString*refund;
@property(nonatomic,copy)NSString*source;
@property(nonatomic,copy)NSString*money;
+(instancetype)PayRecWithDict:(NSDictionary* )dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
