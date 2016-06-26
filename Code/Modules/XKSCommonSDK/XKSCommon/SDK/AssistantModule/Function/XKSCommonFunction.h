//
//  XKSCommonFunction.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/*! 全局资源文件束名称*/
static NSString *const kXKSCommon_ResouceBundleName = @"XKSCommonResource";

//Readme :这里定义全局通用C风格的函数,方便调用

#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *公共方法*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:42
 *
 *  @brief 测试一段代码的执行时间
 *  @param ^block 待测试代码块
 *  @return 代码块运行时长
 *  @since v0.1.0
 */
double measureBlock(void (^block)());


/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:51
 *
 *  @brief 生成UUID
 *  @return 随机生成16位小写的字符串
 *  @since v0.1.0
 */
NSString* getXUUID();

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:24
 *
 *  @brief 格式化金钱字符串(一般用于银行交易)
 *  @param maxLength 格式化后的长度
 *  @param money     金钱字符串
 *  @return 格式化后的金钱字符串
 *  @since v0.1.0
 */
NSString *formatMoneyString(NSUInteger maxLength,NSString *money);

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:14
 *
 *  @brief 验证手机号码的合法性
 *  @param mobileNum 手机号
 *  @return 手机号码是否合法
 *  @since v0.1.0
 */
BOOL validateMobileNumber(NSString *mobileNumber);


/**
 *  @author _Finder丶Tiwk, 16-01-15 15:01:28
 *
 *  @brief 通过MD5加密一个字符串
 *  @param aString 待加密字符串
 *  @return 经过MD5加密后的字符串
 *  @since v0.1.0
 */
NSString *xks_md5(NSString *aString);


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *JSON*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:14
 *
 *  @brief 将集合对象转换成Json字符串
 *  @param collection 集合对象(Array,Dictionary,Set)
 *  @return Json字符串(如果转换失败，则返回nil)
 *  @since v0.1.0
 */
NSString* collection2JsonString(id collection);

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:55
 *
 *  @brief 将标准的Json格式的字符串转换成集合对象
 *  @param jsonString Json字符串
 *  @return 集合(Array,Dictionary,Set中的某一种)(如果转换失败，则返回nil)
 *  @since v0.1.0
 */
id jsonString2Collection(NSString *jsonString);



/**
 *  @author _Finder丶Tiwk, 16-05-24 11:05:33
 *
 *  @brief 将模型对象转化为字典
 *  @param obj 模型对象
 *  @return 字典
 *  @since v1.0.0
 */
NSDictionary *convertObj2Dictionary(id obj);


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *NULL*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:45
 *
 *  @brief 判断一个对象是否是NSArray类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的数组
 *  @since v0.1.0
 */
BOOL isArrayWithAnyItems(id object);
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:31
 *
 *  @brief 判断一个对象是否是NSDictionary类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的字典
 *  @since v0.1.0
 */
BOOL isDictionaryWithAnyItems(id object);

/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:00
 *
 *  @brief 判断一个对象是否是NSString类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的字符串
 *  @since v0.1.0
 */
BOOL isStringWithAnyText(id object);



#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *视图相关*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-01-13 14:01:29
 *
 *  @brief 获取当前显示的视图控制器
 *  @return 当前显示的视图控制器
 *  @since v0.1.0
 */
UIViewController* currentViewController();



#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *文件相关*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *  @author _Finder丶Tiwk, 16-01-14 00:01:37
 *
 *  @brief 返回一个拼接了沙盒Document路径的文件路径
 *  @param filename 文件名
 *  @return 拼接了沙盒Document路径的文件路径
 *  @since v0.1.0
 */
NSString* filePathInDocuments(NSString *filename);

/**
 *  @author _Finder丶Tiwk, 16-01-14 00:01:53
 *
 *  @brief 通过其它bundle的名字来获取一个NSBundle对象
 *  @param bundleName 要获取的NSBundle的文件名字符串
 *  @return NSBundle对象
 *  @since v0.1.0
 */
NSBundle* externBundle(NSString *bundleName);



/**
 *  @author _Finder丶Tiwk, 16-05-04 18:05:48
 *
 *  @brief 从指定bundle中加载一个指定的storyboard
 *  @param bundleName     bundle名称
 *  @param storyBoardName storyboard名称
 *  @return storyboard
 *  @since v1.0.0
 */
UIStoryboard* customStoryBoard(NSString *bundleName,NSString *storyBoardName);

/**
 *  @author _Finder丶Tiwk, 16-05-04 18:05:33
 *
 *  @brief 从指定bundle中加载一个指定的xib组件数组
 *  @param bundleName bundle名称
 *  @param xibName    xib文件名称
 *  @return xib里包含的组件的数组
 *  @since v1.0.0
 */
NSArray* xibArray(NSString *bundleName,NSString *xibName);

