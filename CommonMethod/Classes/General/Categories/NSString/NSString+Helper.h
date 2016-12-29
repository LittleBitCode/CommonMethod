//
//  NSString-Helper.h
//  CommonMethod
//
//  Created by littleBit on 2016/12/13.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Helper)
+ (BOOL)isNickName:(NSString *)nickName;///判断字符串是否只还有数字，大小写字母和汉字
+ (BOOL)isName:(NSString *)nameStr;  //判断是否姓名
+ (BOOL)isRemMsg: (NSString *)aString; //过滤掉'<'、"<"、‘&’字符的 60汉字和20字符
+ (BOOL)isPassword:(NSString *)password;///判断字符串是否只还有数字，大小字母
+ (BOOL) isDigital:(NSString *)aString;// 判断输入是否数字（含小数点）
- (BOOL) isNumber; // 判断是否纯数字
+ (BOOL) isIDNumber:(NSString *)aString; // 判断是否身份号

+ (BOOL) isSixDigitalPassword:(NSString *)password; //判断字符串是否6位数字
+ (BOOL) isSixToThTwelvePassword:(NSString *)password; //判断字符串是否6－12位字符（大小写字符和数字）
+ (BOOL) isCardNumber:(NSString *)aString;  //是否正常银行卡号（10－32位）
+ (BOOL)isLoginPassword:(NSString *)password;// 修改登陆密码纯数字与纯字母不能过

+ (NSString *)md5Digest:(NSString *)str;
+ (NSInteger) checkSimplePassword: (NSString *)password; //判断是否简单密码 modified by sunruilian
+ (BOOL)isRecName:(NSString *)nameStr;
+ (int)convertToInt:(NSString*)strtemp;
+ (NSString *) screenIDWithIdStr:(NSString *)idStr;//账号中间段屏蔽
+ (BOOL)payNumCheck:(NSString *)nickName;//缴费号码判断


//用于账号保护加空格 返回四位以空格的账户号
+ (NSString *)formatAccountFromAccountStr:(NSString *)accountStr;

+(NSString *)numberStringTurnToPhoneNumWith:(NSString*)number;
+(NSString *)NumberStringTurnToAccountNumberWith:(NSString*)number;
+(NSDictionary *)checkMessageStringWithDesString:(NSString *)desString andDesValueString:(NSString *)desValue;
//账户加空格  格式化
+(NSString*)accountStringWithAccount:(NSString *)account;

//通过时间戳计算时间差（几小时前、几天前）
+ (NSString *) compareCurrentTime:(NSTimeInterval) compareDate;

//通过时间戳得出显示时间
+ (NSString *) getDateStringWithTimestamp:(NSTimeInterval)timestamp;

//通过时间戳和格式显示时间
+ (NSString *) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter;
@end
