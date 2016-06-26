//
//  NSString+Chinese.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/26.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Chinese)

/*! 中文字符串对应的拼音*/
@property (nonatomic,copy,readonly) NSString *pinYin;

/**
 *  @author _Finder丶Tiwk, 16-01-26 15:01:01
 *
 *  @brief 将字符串数组按首字母排序
 *  @param array     字符串数组
 *  @param ascending 升序(YES)/降序(NO)
 *  @return 排好序后的字符串数组
 *  @since v0.1.0
 */
NSArray<NSString *> * sortByFirstLetter(NSArray<NSString *> * array,BOOL ascending);

@end
