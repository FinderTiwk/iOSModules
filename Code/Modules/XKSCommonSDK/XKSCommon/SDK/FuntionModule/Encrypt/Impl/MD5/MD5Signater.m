//
//  MD5Signater.m
//  XKSEncryptor
//
//  Created by _Finder丶Tiwk on 15/12/21.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import "MD5Signater.h"

@implementation MD5Signater

- (NSString *)signString:(NSString *)aString{
    NSString *_secret = [XKSSystemObj shareXKSSystemObj].md5Secret;
    if (!_secret) {
        NSAssert(NO, @"<MD5Validater> -- MD5加密密钥没有设置");
    }
    NSMutableString *str = [NSMutableString stringWithString:aString];
    [str appendFormat:@"&secret=%@",_secret];
    NSString *sign = xks_md5(str);
    return sign;
}

@end
