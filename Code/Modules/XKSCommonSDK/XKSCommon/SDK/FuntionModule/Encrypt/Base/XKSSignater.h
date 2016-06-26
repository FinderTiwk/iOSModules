//
//  XKSSignater.h
//  XKSEncryptor
//
//  Created by _Finder丶Tiwk on 15/12/21.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XKSSignater <NSObject>

- (NSString *)signString:(NSString *)aString;

@end
