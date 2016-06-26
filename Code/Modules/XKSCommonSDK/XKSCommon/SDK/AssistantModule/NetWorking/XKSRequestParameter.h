//
//  XKSRequestParameter.h
//  XKSNetworking
//
//  Created by _Finder丶Tiwk on 16/4/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSEncryptor.h"
#import "XKSCommonEnumeration.h"

@interface XKSRequestParameter : NSObject

/*! 接口API*/
@property (nonatomic,copy) NSString *apiString;
/*! 请求参数据典集合*/
@property (nonatomic,strong) NSMutableDictionary *parameterDictionary;
/*! HTTP协议的8种请求类型*/
@property (nonatomic,assign) XKSRequestMethod requestMethod;

#pragma mark - ReadOnly Property

/*! HTTP Url请求对象*/ 
@property (nonatomic,readonly) NSURLRequest *urlRequest;

@end
