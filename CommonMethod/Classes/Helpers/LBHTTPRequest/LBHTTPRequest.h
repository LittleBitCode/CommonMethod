//
//  LBHTTPRequest.h
//  CommonMethod
//
//  Created by littleBit on 2016/11/24.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBHTTPRequest : NSObject
typedef void (^successBlock)(BOOL isSuccess,NSDictionary *resultDic);
typedef void (^failureBlock)(NSError *error);


+(instancetype )sharedLBHTTPRequest;
/*json
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*json
 * @brief 把字典转换成字符串
 * @param jsonString JSON格式的字符串
 * @return 返回字符串
 */
+(NSString*)URLEncryOrDecryString:(NSDictionary *)paramDict IsHead:(BOOL)_type;

/**
 * 上传单张图片
 */
+(void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
          imageData:(NSData *)imageData
            succeed:(void (^)(id))succeed
            failure:(void (^)(NSError *))failure;
/**
 * 上传多张图片
 */
+(void)requestAFURL:(NSString *)URLString
         parameters:(id)parameters
     imageDataArray:(NSArray *)imageDataArray
            succeed:(void (^)(id))succeed
            failure:(void (^)(NSError *))failure;

+(void)requestWithHttpMethod:(NSInteger)method succeedBlock:(successBlock)successBlock failure:(failureBlock)failureBlock;
@end
