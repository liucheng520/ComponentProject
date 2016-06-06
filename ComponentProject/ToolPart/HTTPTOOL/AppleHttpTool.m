//
//  AppleHttpTool.m
//  武汉二部iOS基础框架
//
//  Created by 苏荷 on 15/9/23.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "AppleHttpTool.h"

@interface AppleHttpTool()

//成功返回
@property (strong,nonatomic) ResponseData success;

//失败返回
@property (strong,nonatomic) ResponseData failure;

//返回代码data拼接
@property (nonatomic,strong) NSMutableData *mutableData;

@end

@implementation AppleHttpTool

- (void)GETWithMethod:(NSString *)method param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.0 拼接url
    NSString *urlStr =  [NSString stringWithFormat:@"%@%@",Base_URL,method];
    
    // 2.0 创建request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:0 timeoutInterval:10.0f];
    
    // 3.0 设置request头属性，hearder具体设置，自己添加 － [request setValue:@"" forHTTPHeaderField:@"cookie"];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"" forHTTPHeaderField:@""];
    
    // 4.0 初始化data
    _mutableData = [NSMutableData data];
    
    // 5.0 创建异步链接
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
    //记录代码块，用于数据返回
    self.success = success;
    self.failure = failure;

}

- (void)POSTWithMethod:(NSString *)method param:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.0 拼接url
    NSString *urlStr =  [NSString stringWithFormat:@"%@%@",Base_URL,method];
    
    // 2.0 创建request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:0 timeoutInterval:10.0f];
    
    // 3.0 设置request头属性，hearder具体设置，自己添加 － [request setValue:@"" forHTTPHeaderField:@"cookie"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"" forHTTPHeaderField:@""];

    // 4.0 参数转化包装给httpbody－转化过程待优化
    NSData *data=[NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *bodyString = [NSString stringWithFormat:@"%@",paramString];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    // 4.0 初始化data
    _mutableData = [NSMutableData data];
    
    // 5.0 网络请求，5.1 代理。 5.2 代码块
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 10.0f;
    
    [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // 5.1 创建异步链接
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
    }];
    
    [task resume];
    
    //记录代码块，用于数据返回
    self.success = success;
    self.failure = failure;
}

#pragma mark -- delegate代理方法实现
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //反序列化
    id Json =[NSJSONSerialization JSONObjectWithData:self.mutableData options:NSJSONReadingAllowFragments error:nil];
    self.success(Json);
}

//代码块回传代理方法返回值
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //数据拼接
    [self.mutableData appendData:data];
}

//代码块回传代理方法返回error
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.failure(error);
}

//以下为X509认证代码，需要Https网站证书，cer格式，命名为selfCer
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    //响应服务器证书认证请求和客户端证书认证请求
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    // 获取der格式CA证书路径
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"selfCer" ofType:@"cer"];
    
    // 提取二进制内容
    NSData *derCA = [NSData dataWithContentsOfFile:certPath];
    
    // 根据二进制内容提取证书信息
    SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)derCA);
    
    // 形成钥匙链
    NSArray * chain = [NSArray arrayWithObject:(__bridge id)(caRef)];
    
    CFArrayRef caChainArrayRef = CFBridgingRetain(chain);
    
    //取出服务器证书
    SecTrustRef trust = [[challenge protectionSpace] serverTrust];
    
    SecTrustResultType trustResult = 0;
    
    //    // 设置为我们自有的CA证书钥匙连
    int err = SecTrustSetAnchorCertificates(trust, caChainArrayRef);
    if (err == noErr) {
        //        // 用CA证书验证服务器证书
        err = SecTrustEvaluate(trust, &trustResult);
    }
    
    BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed)||(trustResult == kSecTrustResultConfirm) || (trustResult == kSecTrustResultUnspecified));
    
    if(trusted){
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }else{
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
    //    CFRelease(trust);
}

@end
