//
//  XKSNetworking.m
//  XKSNetworking
//
//  Created by _Finder丶Tiwk on 16/4/11.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSNetworking.h"
#import "XKSCommonTips.h"
#import "XKSCommonErrorCode.h"
#import "XKSRequestParameter.h"
#import "XKSCommonFunction.h"
#import "XKSSystemObj.h"


#pragma mark - 请求失败返回的信息对应的Key值
NSString *const kXKSNetworkingUserInfo_Code = @"code";
NSString *const kXKSNetworkingUserInfo_Msg  = @"message";
NSString *const kXKSNetworkingUserInfo_Type = @"type";

@implementation XKSNetworking

static dispatch_semaphore_t __semaphore;
+ (void)initialize{
    __semaphore = dispatch_semaphore_create(1);
}
#pragma mark - 同步请求

+ (void)syncWithParameter:(XKSRequestParameter *)parameter success:(void (^)(id))successBlock failure:(void (^)(NSDictionary *))failureBlock{
    [self syncWithParameter:parameter start:NULL success:successBlock failure:failureBlock];
}

+ (void)syncWithParameter:(XKSRequestParameter *)parameter
                    start:(void (^)())startBlock
                  success:(void (^)(id))successBlock
                  failure:(void (^)(NSDictionary *))failureBlock{

    [self unitRequestWithParameter:parameter type:1 start:startBlock success:successBlock failure:failureBlock];
}

#pragma mark - 异步请求

+ (void)asyncWithParameter:(XKSRequestParameter *)parameter success:(void (^)(id))successBlock failure:(void (^)(NSDictionary *))failureBlock{
    [self asyncWithParameter:parameter start:NULL success:successBlock failure:failureBlock];
}

+ (void)asyncWithParameter:(XKSRequestParameter *)parameter
                     start:(void (^)())startBlock
                   success:(void (^)(id))successBlock
                   failure:(void (^)(NSDictionary *))failureBlock{
    [self unitRequestWithParameter:parameter type:0 start:startBlock success:successBlock failure:failureBlock];
}


/**
 *  @author _Finder丶Tiwk, 16-05-04 16:05:09
 *
 *  @brief 所有的请求统一从这里发出
 *  @param parameter    请求参数
 *  @param type         请求类型 1--同步 其它——异步
 *  @param startBlock   开始请求回调
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 *  @since v1.0.0
 */
+ (void)unitRequestWithParameter:(XKSRequestParameter *)parameter
                            type:(NSUInteger)type
                     start:(void (^)())startBlock
                   success:(void (^)(id))successBlock
                   failure:(void (^)(NSDictionary *))failureBlock{

    if (startBlock) {
        startBlock();
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = parameter.urlRequest;
    XKSLog(@"%@",parameter);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (type == 1) {
            dispatch_semaphore_signal(__semaphore);
        }
        // 拿到响应头信息
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSDictionary *responseHeader = httpResponse.allHeaderFields;
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        XKSLog(@"响应头：%@\n响应体：%@",responseHeader,jsonString);
        
        BOOL success = YES;
        NSDictionary *failureDic;
        
        if (error) {
            failureDic = @{kXKSNetworkingUserInfo_Code:kXKSCommon_Error_Network,
                           kXKSNetworkingUserInfo_Msg:error.localizedDescription,
                           kXKSNetworkingUserInfo_Type:@"network"};
            success = NO;
        }
        
        NSInteger responseCode = httpResponse.statusCode;
        if (success && responseCode != 200) {
            
            failureDic = @{kXKSNetworkingUserInfo_Code:[NSString stringWithFormat:@"%td",responseCode],
                           kXKSNetworkingUserInfo_Msg:@"服务器异常,请联系开发人员。",
                           kXKSNetworkingUserInfo_Type:@"server"};
            success = NO;
        }
        
        
        if (success && (!data || data.length == 0)) {
            // 服务器返回数据为空
            failureDic = @{kXKSNetworkingUserInfo_Code:kXKSCommon_Error_Server,
                           kXKSNetworkingUserInfo_Msg:@"服务器返回数据为空",
                           kXKSNetworkingUserInfo_Type:@"server"};
            success = NO;
        }
    
        if (success && !responseHeader) {
            // 服务器响应头为空
            failureDic = @{kXKSNetworkingUserInfo_Code:kXKSCommon_Error_Server,
                           kXKSNetworkingUserInfo_Msg:@"服务器响应头为空",
                           kXKSNetworkingUserInfo_Type:@"server"};
            success = NO;
        }
        
        if (success && !isStringWithAnyText(jsonString)) {
            // 服务器返回数据为空
            failureDic = @{kXKSNetworkingUserInfo_Code:kXKSCommon_Error_Server,
                           kXKSNetworkingUserInfo_Msg:@"服务器返回数据格式不正确",
                           kXKSNetworkingUserInfo_Type:@"server"};
            success = NO;
        }
        
        if (success) {
            NSError *validateError;
            [XKSEncryptor validateResponseString:jsonString header:responseHeader error:&validateError];
            if (validateError) {
                failureDic = @{kXKSNetworkingUserInfo_Code:kXKSCommon_Error_Sign,
                               kXKSNetworkingUserInfo_Msg:kXKSCommon_Tip_Hijack,
                               kXKSNetworkingUserInfo_Type:@"sign"};
                success = NO;
            }
        }
        
        if (!success) {
            if (type == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failureBlock(failureDic);
                });
            }else{
                failureBlock(failureDic);
            }
        }else{
            NSDictionary *responseDic = jsonString2Collection(jsonString);
            if (type == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(responseDic);
                });
            }else{
                successBlock(responseDic);
            }
        }
    }];
    
    if (type == 1) {
        dispatch_semaphore_wait(__semaphore, DISPATCH_TIME_FOREVER);
    }
    [task resume];
}

@end
