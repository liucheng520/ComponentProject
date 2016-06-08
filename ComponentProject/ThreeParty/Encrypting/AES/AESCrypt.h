//
//  AESCrypt.h
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

#import <Foundation/Foundation.h>

@interface AESCrypt : NSObject

//密码写死
+ (NSString *)AES128Encrypt:(NSString *)plainText;

//密码可以修改
+ (NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key;

+ (NSString *)AES128Decrypt:(NSString *)plainText withKey:(NSString *)key;

//加密data，用utf-8转换后传入
+ (NSData *)AES128EncryptData:(NSData *)baseData withKey:(NSString *)key;

+ (NSData *)AES128DecryptData:(NSData *)baseData withKey:(NSString *)key;

@end
