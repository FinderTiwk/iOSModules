//
//  XKSCommonFunction.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import <mach/mach_time.h>
#import <objc/runtime.h>
#import "XKSCommonFunction.h"

#pragma mark - *公共方法*
/////////////////////////////////////////////////////////////////////////////////////////////////
double measureBlock(void (^block)()){
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (double)nanos / NSEC_PER_SEC;
}

NSString *getXUUID(){
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result = (__bridge_transfer NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return [[result stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

NSString *formatMoneyString(NSUInteger maxLength,NSString *money){
    NSDecimalNumber *moneyNumber = [NSDecimalNumber decimalNumberWithString:money];
    NSDecimalNumber *geneNumber  = [NSDecimalNumber decimalNumberWithString:@"100.00"];
    NSString *moneyString = [[moneyNumber decimalNumberByMultiplyingBy:geneNumber] stringValue];
    NSUInteger leftLength = maxLength - moneyString.length;
    NSMutableString *formatMoney = [NSMutableString string];
    while (formatMoney.length < leftLength) {
        [formatMoney appendString:@"0"];
    }
    [formatMoney appendString:moneyString];
    return formatMoney;
}



BOOL validateMobileNumber(NSString *mobileNumber){
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    
    //NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES)){
        return YES;
    }else{
        return NO;
    }
}


NSString *xks_md5(NSString *aString){
    const char *utf8InitialString = [aString UTF8String];
    unsigned char md5ResultString[16];
    CC_MD5(utf8InitialString, (CC_LONG)strlen(utf8InitialString), md5ResultString);
    NSString *md5String = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           md5ResultString[0],md5ResultString[1],md5ResultString[2],md5ResultString[3],
                           md5ResultString[4],md5ResultString[5],md5ResultString[6],md5ResultString[7],
                           md5ResultString[8],md5ResultString[9],md5ResultString[10],md5ResultString[11],
                           md5ResultString[12],md5ResultString[13],md5ResultString[14],md5ResultString[15]
                           ];
    return md5String;
}

#pragma mark - *JSON*
///////////////////////////////////////////////////////////////////////////////////////////////////
NSString *collection2JsonString(id collection){
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:collection
                                                       options:0
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"[XKSCommonSDK.framework] collection2JsonString 转换失败: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
id jsonString2Collection(NSString *jsonString){
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonRet = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
    if(err) {
        NSLog(@"[XKSCommonSDK.framework] json字符串解析失败,请校验Json格式：%@",err);
        return nil;
    }
    return jsonRet;
}

NSDictionary *convertObj2Dictionary(id obj){
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];

    unsigned int propertyCount, index;
    objc_property_t *properties = class_copyPropertyList([obj class], &propertyCount);
    for (index = 0 ; index < propertyCount; index++) {
        objc_property_t property = properties[index];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id properyValue = [obj valueForKey:(NSString *)propertyName];
        if (properyValue) {
            [resultDic setValue:properyValue forKey:propertyName];
        }else{
            [resultDic setValue:@"" forKey:propertyName];
        }
    }
    free(properties);
    
    return resultDic;
}



#pragma mark - *NULL*
///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isArrayWithAnyItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isDictionaryWithAnyItems(id object) {
    return [object isKindOfClass:[NSDictionary class]] && [(NSDictionary*)object count] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}




#pragma mark - *视图相关*
/**
 *  @author _Finder丶Tiwk, 16-01-13 14:01:02
 *
 *  @brief 从RootViewController开始递归查询当前显示的控制器
 *  @since v0.1.0
 */
UIViewController *xks_findBestViewController(UIViewController *controller){
    //1.如果控制器是被present出来的
    if (controller.presentedViewController) {
        return xks_findBestViewController(controller.presentedViewController);
    }
    //2.如果控制器是UISplitViewController
    else if ([controller isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *splitViewController = (UISplitViewController *) controller;
        if (splitViewController.viewControllers.count > 0){
            return xks_findBestViewController(splitViewController.viewControllers.lastObject);
        }else{
            return controller;
        }
    }
    //3.如果控制器是一个导航控制器
    else if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *) controller;
        if (navController.viewControllers.count > 0){
            return xks_findBestViewController(navController.topViewController);
        }else{
            return controller;
        }
    }
    //4.如果控制器是一个标签栏控制器
    else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *) controller;
        if (tabBarController.viewControllers.count > 0){
            return xks_findBestViewController(tabBarController.selectedViewController);
        }else{
            return controller;
        }
    }
    //5.最根源的控制器
    else {
        return controller;
    }
}

UIViewController* currentViewController(){
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    return xks_findBestViewController(root);
}


#pragma mark - *文件相关*
///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* filePathInDocuments(NSString *filename){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
}

NSBundle* externBundle(NSString *bundleName){
    assert(isStringWithAnyText(bundleName));
    NSString *bundeFullName;
    if ([bundleName rangeOfString:@".bundle"].location == NSNotFound) {
        bundeFullName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    }else{
        bundeFullName = bundleName;
    }
    NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bundeFullName];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}


UIStoryboard* customStoryBoard(NSString *bundleName,NSString *storyBoardName){
    NSCParameterAssert(bundleName);
    NSCParameterAssert(storyBoardName);
    NSBundle *bundle = externBundle(bundleName);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:bundle];
    return storyboard;
}

NSArray* xibArray(NSString *bundleName,NSString *xibName){
    NSCParameterAssert(xibName);
    NSBundle *bundle = externBundle(bundleName);
    NSArray *array   = [bundle loadNibNamed:xibName owner:nil options:nil];;
    if (!array) {
        array = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    }    
    return array;
}

