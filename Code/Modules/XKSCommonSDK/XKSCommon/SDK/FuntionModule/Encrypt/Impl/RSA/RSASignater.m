//
//  RSASignater.m
//  XKSEncryptor
//
//  Created by _Finder丶Tiwk on 15/12/21.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import "RSASignater.h"
#import <openssl/rsa.h>
#import <openssl/sha.h>
#import <openssl/pem.h>

/*! RSA私钥字符串头部格式*/
static NSString *const kRSAPrivateKey_Header    = @"-----BEGIN RSA PRIVATE KEY-----";
/*! RSA私钥字符串尾部格式*/
static NSString *const kRSAPrivateKey_Footer    = @"-----END RSA PRIVATE KEY-----";

@implementation RSASignater{
    NSString *_rsaPrivateKey;        /**< RSA私钥*/
    NSString *_rsaDoucmentPath;      /**< RSA存储位置*/
    NSString *_rsaPrivateKeyPath;    /**< RSA私钥存储位置*/
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSAssert(isStringWithAnyText(_rsaPrivateKey), @"没有设置RSA私钥");
        _rsaPrivateKey = [XKSSystemObj shareXKSSystemObj].rsa_privateKey_C;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentPath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _rsaDoucmentPath = [documentPath stringByAppendingPathComponent:@".openssl_rsa"];
        if (![fileManager fileExistsAtPath:_rsaDoucmentPath]){
            [fileManager createDirectoryAtPath:_rsaDoucmentPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        _rsaPrivateKeyPath =
        [_rsaDoucmentPath stringByAppendingPathComponent:@"xks.private"];
        [self setPrivateKeyWithString:_rsaPrivateKeyPath];
    }
    return self;
}

- (void)setPrivateKeyWithString:(NSString *)aString{
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"%@\n",kRSAPrivateKey_Header];
    const char *pStr = [aString UTF8String];
    int length = (int)aString.length;
    int index  = 0;
    int count  = 0;
    while (index < length) {
        char c  = pStr[index];
        if (c == '\r' || c == '\n') {
            ++ index;
            continue;
        }
        [result appendFormat:@"%c",c];
        if (++count == 79) {
            [result appendString:@"\n"];
            count = 0;
        }
        index++;
    }
    [result appendFormat:@"\n%@",kRSAPrivateKey_Footer];
    
    [result writeToFile:_rsaPrivateKeyPath
             atomically:YES
               encoding:NSASCIIStringEncoding
                  error:NULL];
}

#pragma mark 签名
- (NSString *)signString:(NSString *)aString{
    NSString * signedString = nil;
    const char *message = [aString cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength = (int)strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
    unsigned int sig_len;
    int ret = rsa_sign_with_private_key_pem((char *)message, messageLength, sig, &sig_len, (char *)[_rsaPrivateKeyPath UTF8String]);
    if (ret == 1) {
        signedString = [[NSData dataWithBytes:sig length:sig_len] base64EncodedStringWithOptions:0];
    }else{
        NSAssert(NO, @"rsa_private read error : private key is NULL");
    }
    free(sig);
    return signedString;
}

int rsa_sign_with_private_key_pem(char *message, int message_length
                                  , unsigned char *signature, unsigned int *signature_length
                                  , char *private_key_file_path){
    unsigned char sha1[20];
    SHA1((unsigned char *)message, message_length, sha1);
    int success = 0;
    BIO *bio_private = NULL;
    RSA *rsa_private = NULL;
    bio_private = BIO_new(BIO_s_file());
    BIO_read_filename(bio_private, private_key_file_path);
    rsa_private = PEM_read_bio_RSAPrivateKey(bio_private, NULL, NULL, "");
    if (rsa_private != nil) {
        if (1 == RSA_check_key(rsa_private)){
            int rsa_sign_valid = RSA_sign(NID_sha1
                                          , sha1, 20
                                          , signature, signature_length
                                          , rsa_private);
            if (1 == rsa_sign_valid){
                success = 1;
            }
        }
        BIO_free_all(bio_private);
    }
    return success;
}


@end
