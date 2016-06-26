//
//  XKSOperator.m
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSOperator.h"

@implementation XKSOperator

singletonImpl(XKSOperator)

- (void)convertFromCollection:(NSDictionary *)collection{
    _name       = collection[@"name"];
    _operatorID = collection[@"operatorID"];
}

@end
