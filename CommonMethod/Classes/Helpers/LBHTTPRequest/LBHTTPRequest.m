//
//  LBHTTPRequest.m
//  CommonMethod
//
//  Created by littleBit on 2016/11/24.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "LBHTTPRequest.h"
#import "AFNetworking.h"
@implementation LBHTTPRequest
SYNTHESIZE_SINGLETON_FOR_CLASS(LBHTTPRequest)

/*json
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        LBLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

/*json
 * @brief 把字典转换成字符串
 * @param jsonString JSON格式的字符串
 * @return 返回字符串
 */
+(NSString*)URLEncryOrDecryString:(NSDictionary *)paramDict IsHead:(BOOL)_type {
    NSArray *keyAry =  [paramDict allKeys];
    NSString *encryString = @"";
    for (NSString *key in keyAry) {
        NSString *keyValue = [paramDict valueForKey:key];
        encryString = [encryString stringByAppendingFormat:@"&"];
        encryString = [encryString stringByAppendingFormat:@"%@",key];
        encryString = [encryString stringByAppendingFormat:@"="];
        encryString = [encryString stringByAppendingFormat:@"%@",keyValue];
    }
    return encryString;
}


//上传文件
+(void)requestAFURL:(NSString *)URLString parameters:(id)parameters fileData:(NSData *)fileData succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure {
    // 0.设置API地址
    URLString = [NSString stringWithFormat:@"%@%@",kMainUrlString,@"parent/home/child.do"];
//    LBLog(@"\n POST上传文件参数列表:%@\n\n%@\n",parameters,[Utilit URLEncryOrDecryString:parameters IsHead:false]);
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",  nil];
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    // 5. POST数据
    [manager POST:URLString  parameters:parameters  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //将得到的二进制数据拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
        [formData appendPartWithFileData :fileData name:@"file" fileName:@"audio.MP3" mimeType:@"audio/MP3"];
    }progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        succeed([LBHTTPRequest dictionaryWithJsonString:responseStr]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
/**
 * 上传单张图片
 */
+(void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
          imageData:(NSData *)imageData
            succeed:(void (^)(id))succeed
            failure:(void (^)(NSError *))failure
{
    // 0.设置API地址
    URLString = [NSString stringWithFormat:@"%@%@",kMainUrlString,@"parent/home/child.do"];
//    DNSLog(@"\n POST上传单张图片参数列表:%@\n\n%@\n",parameters,[AFNManagerRequest URLEncryOrDecryString:parameters IsHead:false]);
    
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    
    // 5. POST数据
    [manager POST:URLString  parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";   // 设置时间格式
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    }progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        succeed([LBHTTPRequest dictionaryWithJsonString:responseStr]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}
/**
 * 上传多张图片
 */
+(void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
     imageDataArray:(NSArray *)imageDataArray
            succeed:(void (^)(id))succeed
            failure:(void (^)(NSError *))failure
{
    // 0.设置API地址
    URLString = [NSString stringWithFormat:@"%@%@",kMainUrlString,@"parent/home/child.do"];
//    DNSLog(@"\n POST上传多张图片参数列表:%@\n\n%@\n",parameters,[AFNManagerRequest URLEncryOrDecryString:parameters IsHead:false]);
    
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",  nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    
    // 5. POST数据
    [manager POST:URLString  parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i<imageDataArray.count; i++){
            NSData *imageData = imageDataArray[i];
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSString *name = [NSString stringWithFormat:@"image_%d.png",i ];
            
            //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
        }
        
    }progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        succeed([LBHTTPRequest dictionaryWithJsonString:responseStr]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}
/**
 * AF网络请求
 */
+(void)requestWithHttpMethod:(NSInteger)method succeedBlock:(successBlock)successBlock failure:(failureBlock)failureBlock{
    [MBProgressHUD showMessage:@"正在加载..."];
    // 0.设置API地址
   NSString * URLString = [NSString stringWithFormat:@"%@%@",kMainUrlString,@"appInfo/checkIosVersion.do"];
    NSDictionary *parameters = @{@"version":[LBMethods getAppVersion],@"versionType":[NSString stringWithFormat:@"%i",1]};
    LBLog(@"\n AF网络请求参数列表:%@\n\n 接口名: %@\n\n",parameters,URLString);
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 30;
    // 5.选择请求方式 GET 或 POST
    switch (method) {
        case GET_REQUEST:
        {
            [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSDictionary *result =[LBHTTPRequest dictionaryWithJsonString:responseStr];
                if ([result[@"result"] intValue] == 200) {
                    successBlock(YES,result);
                }else {
                    NSLog(@"强制升级 error == %@",result[@"message"]);
                    if (result[@"message"]!=nil) {
                    }
                    successBlock(NO,result);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                successBlock(NO,nil);
                failureBlock(error);
                LBLog(@"\n 请求失败:%@\n\n",error);
            }];
        }
            break;
        case POST_REQUEST:
        {
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSDictionary *result =[LBHTTPRequest dictionaryWithJsonString:responseStr];
                if ([result[@"result"] intValue] == 200) {
                    successBlock(YES,result);
                }else {
                    NSLog(@"强制升级 error == %@",result[@"message"]);
                    if (result[@"message"]!=nil) {
                    }
                    successBlock(NO,result);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [MBProgressHUD hideHUD];
                failureBlock(error);
                LBLog(@"\n 请求失败:%@\n\n",error);
            }];
        }
            break;
        default:
            break;
    }
}
@end
