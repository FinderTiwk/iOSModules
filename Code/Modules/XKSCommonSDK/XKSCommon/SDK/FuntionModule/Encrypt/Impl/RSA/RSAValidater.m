//
//  RSAValidater.m
//  XKSEncryptor
//
//  Created by _Finder丶Tiwk on 15/12/21.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import "RSAValidater.h"
#import <openssl/rsa.h>
#import <openssl/pem.h>
#import <openssl/sha.h>

/*! RSA公钥字符串头部格式*/
static NSString *const kRSAPublicKey_Header     = @"-----BEGIN PUBLIC KEY-----";
/*! RSA公钥字符串尾部格式*/
static NSString *const kRSAPublicKey_Footer     = @"-----END PUBLIC KEY-----";

@implementation RSAValidater{
    NSString *_rsaPublicKey;        /**< RSA服务器公钥*/
    NSString *_rsaDoucmentPath;     /**< RSA存储位置*/
    NSString *_rsaPublicKeyPath;    /**< RSA公钥存储位置*/
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _rsaPublicKey = [XKSSystemObj shareXKSSystemObj].rsa_publicKey_S;
        NSAssert(isStringWithAnyText(_rsaPublicKey), @"请设置服务器公钥");
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentPath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _rsaDoucmentPath = [documentPath stringByAppendingPathComponent:@".openssl_rsa"];
        if (![fileManager fileExistsAtPath:_rsaDoucmentPath]){
            [fileManager createDirectoryAtPath:_rsaDoucmentPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        _rsaPublicKeyPath =
        [_rsaDoucmentPath stringByAppendingPathComponent:@"xks.public"];
        [self setPublicKeyString:_rsaPublicKey];
    }
    return self;
}

- (void)setPublicKeyString:(NSString *)aString{
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"%@\n",kRSAPublicKey_Header];
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
    [result appendFormat:@"\n%@",kRSAPublicKey_Footer];
    
    [result writeToFile:_rsaPublicKeyPath
             atomically:YES
               encoding:NSASCIIStringEncoding
                  error:NULL];
}

#pragma mark 验签
- (BOOL)validateString:(NSString *)aString sign:(NSString *)sign{
    BOOL ret;
    rsaVerifyString(aString, sign, _rsaPublicKeyPath, &ret);
    return  ret;
}

void rsaVerifyString(NSString *stringToVerify, NSString *signature, NSString *publicKeyFilePath, BOOL *verifySuccess){
    const char *message     = [stringToVerify cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength       = (int)[stringToVerify lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSData *signatureData   = [[NSData alloc] initWithBase64EncodedString:signature options:0];
    unsigned char *sig      = (unsigned char *)[signatureData bytes];
    unsigned int sig_len    = (int)[signatureData length];
    
    char *filePath = (char *)[publicKeyFilePath cStringUsingEncoding:NSUTF8StringEncoding];
    int verify_ok  = rsa_verify_with_public_key_pem((char *)message, messageLength
                                                   , sig, sig_len
                                                   , filePath);
    *verifySuccess = (1 == verify_ok);
}

int rsa_verify_with_public_key_pem(char *message, int message_length
                                   , unsigned char *signature, unsigned int signature_length
                                   , char *public_key_file_path){
    unsigned char sha1[20];
    SHA1((unsigned char *)message, message_length, sha1);
    BIO *bio_public = NULL;
    RSA *rsa_public = NULL;
    bio_public = BIO_new(BIO_s_file());
    BIO_read_filename(bio_public, public_key_file_path);
    rsa_public = PEM_read_bio_RSA_PUBKEY(bio_public, NULL, NULL, "");
    RSA_verify(NID_sha1, sha1, 20, signature, signature_length, rsa_public);
    
    int rsa_verify_valid = RSA_verify(NID_sha1
                                      , sha1, 20
                                      , signature, signature_length
                                      , rsa_public);
    BIO_free_all(bio_public);
    if (1 == rsa_verify_valid){
        return 1;
    }
    return 0;
}
@end
