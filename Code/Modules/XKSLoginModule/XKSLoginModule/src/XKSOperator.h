//
//  XKSOperator.h
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XKSCommonSDK/XKSCommonMacro.h>

@interface XKSOperator : NSObject

singleton(XKSOperator)

/*! 姓名*/
@property (nonatomic,readonly) NSString *name;
/*! 操作员编号*/
@property (nonatomic,readonly) NSString *operatorID;


- (void)convertFromCollection:(NSDictionary *)collection;

@end
