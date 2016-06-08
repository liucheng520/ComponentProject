//
//  AESCrypt.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh
// 
// 	MIT License
// 
// 	Permission is hereby granted, free of charge, to any person obtaining
// 	a copy of this software and associated documentation files (the
// 	"Software"), to deal in the Software without restriction, including
// 	without limitation the rights to use, copy, modify, merge, publish,
// 	distribute, sublicense, and/or sell copies of the Software, and to
// 	permit persons to whom the Software is furnished to do so, subject to
// 	the following conditions:
// 
// 	The above copyright notice and this permission notice shall be
// 	included in all copies or substantial portions of the Software.
// 
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// 	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// 	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// 	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// 	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "AESCrypt.h"
// AES加密需要
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define gkey @"1234567890123456"    // 16位字符串(可修改)
#define gIv @"1234567890123456"     // 默认的(可修改)

@implementation AESCrypt

+ (NSString *)AES128Encrypt:(NSString *)plainText
{
    /*
     char keyPtr[kCCKeySizeAES128+1];
     memset(keyPtr, 0, sizeof(keyPtr));
     [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
     */
    // 这里使用后台给的秘钥转换后的byte数组，直接写死
    Byte keyPtr [] = {29, -57, 99, -91, -86, -67, 110, -28, 56, -118, -88, 110, 122, -34, -52, -30};
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = diff;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 | kCCOptionECBMode,    // 使用ECB模式
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    
    // 返回加密后的结果
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

+ (NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key
{
    //对key进行64位编码
    NSData *keydata = [[NSData alloc]initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //将编码的data转换为带符号的byte数组
    NSUInteger len = [keydata length];
    SignedByte *signedB = (SignedByte*)malloc(len);
    memcpy(signedB, (SignedByte *)[keydata bytes], len);
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = diff;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 | kCCOptionECBMode,    // 使用ECB模式
                                          signedB,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    
    // 返回加密后的结果
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

+ (NSString *)AES128Decrypt:(NSString *)plainText withKey:(NSString *)key
{
    //对key进行64位编码
    NSData *keydata = [[NSData alloc]initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //将编码的data转换为带符号的byte数组
    NSUInteger len = [keydata length];
    SignedByte *signedB = (SignedByte*)malloc(len);
    memcpy(signedB, (SignedByte *)[keydata bytes], len);
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = diff;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 | kCCOptionECBMode,    // 使用ECB模式
                                          signedB,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    NSData *resultData;
    if (cryptStatus == kCCSuccess)
    {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    
    // 返回加密后的结果
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];

}

+ (NSData *)AES128EncryptData:(NSData *)baseData withKey:(NSString *)key
{
    //对key进行64位编码
    NSData *keydata = [[NSData alloc]initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //将编码的data转换为带符号的byte数组
    NSUInteger len = [keydata length];
    SignedByte *signedB = (SignedByte*)malloc(len);
    memcpy(signedB, (SignedByte *)[keydata bytes], len);
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = baseData;
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = diff;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 | kCCOptionECBMode,    // 使用ECB模式
                                          signedB,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    NSData *resultData;
    if (cryptStatus == kCCSuccess)
    {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);

    // 返回加密后的结果
    return resultData;
}

+ (NSData *)AES128DecryptData:(NSData *)baseData withKey:(NSString *)key
{
    //对key进行64位编码
    NSData *keydata = [[NSData alloc]initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];

    //将编码的data转换为带符号的byte数组
    NSUInteger len = [keydata length];
    SignedByte *signedB = (SignedByte*)malloc(len);
    memcpy(signedB, (SignedByte *)[keydata bytes], len);

    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSData* data = baseData;
    NSUInteger dataLength = [data length];

    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;

    if(diff > 0)
    {
        newSize = dataLength + diff;
    }

    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = diff;
    }

    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);

    size_t numBytesCrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 | kCCOptionECBMode,    // 使用ECB模式
                                          signedB,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    NSData *resultData;
    if (cryptStatus == kCCSuccess)
    {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);

    // 返回加密后的结果
    return resultData;

}
@end
