//
//  MD5Validater.m
//  XKSEncryptor
//
//  Created by _Finder丶Tiwk on 15/12/21.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import "MD5Validater.h"

@implementation MD5Validater

- (BOOL)validateString:(NSString *)aString sign:(NSString *)sign{
    NSString *_secret = [XKSSystemObj shareXKSSystemObj].md5Secret;
    NSMutableString *str = [NSMutableString stringWithString:aString];
    if (!_secret) {
        NSAssert(NO, @"<MD5Validater> -- MD5加密密钥没有设置");
    }
    [str appendFormat:@"&secret=%@",_secret];
    NSString *tmpSign = xks_md5(str);
    
    return ([tmpSign caseInsensitiveCompare:sign] == NSOrderedSame);
}

@end
