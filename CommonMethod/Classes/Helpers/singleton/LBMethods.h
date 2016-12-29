//
//  LBMethods.h
//  CommonMethod
//
//  Created by littleBit on 2016/11/25.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBMethods : NSObject
+ (instancetype) sharedLBMethods;

#pragma mark - 取得本软件的版本
+(NSString *)getAppVersion;

#pragma mark 获取磁盘总空间大小
+ (CGFloat)allSizeMBytesOfDisk;

#pragma mark 获取磁盘可用空间大小
+ (CGFloat)canUseSizeMBytesOfDisk;

#pragma mark 获取指定路径下某个文件的大小
+ (CGFloat)fileSizeMBytesAtPath:(NSString *)filePath;

#pragma mark 获取文件夹下所有文件的大小
+ (CGFloat)folderSizeMBytesAtPath:(NSString *)folderPath;

#pragma mark  获取手机归属地
+ (NSString *)getProvinceWithPhoneNumber:(NSString *)phoneNumber;

#pragma mark 获取唯一标示符
+ (NSString*) getUUID;

#pragma mark - 根据时间间隔计算多少天多少小时
+ (NSString *)betweenDate:(NSDate *)end withDate:(NSDate *)start;

#pragma mark 得到今天是星期几
+(NSString *)getWeekNameWithDate:(NSDate *)date;

#pragma mark 判断是否是身份证
+(BOOL)isPersonCard:(NSString*)string;

#pragma mark 判断是否数字组成
+ (BOOL)isNumberStr:(NSString*)string;
#pragma mark 计算字符串size,用于label的frame
+ (CGSize)sizeWithText:(NSString *)text boundingRectWithSize:(CGSize)boundingSize font:(UIFont *)font;

#pragma mark  - navgation pop和push动画 iOS7适配
+(void)currentPage:(UIViewController*)currentPage pushTo:(UIViewController*)newPage;
+(void)currentPage:(UIViewController*)currentPage popViewControllerAnimated:(BOOL)myBool;
+(void)currentPage:(UIViewController*)currentPage popToViewController:(UIViewController*)oldPage;
+(void)currentPage:(UIViewController*)currentPage popToRootViewControllerAnimated:(BOOL)myBool;

#pragma mark - 富文本操作     单纯改变一句话中的某些字的颜色
+ (NSMutableAttributedString *)changeCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray;

#pragma mark 单纯改变句子的字间距
+ (NSMutableAttributedString *)changeSpaceWithTotalString:(NSString *)totalString Space:(CGFloat)space;

#pragma mark 同时更改行间距和字间距
+ (NSMutableAttributedString *)changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

#pragma mark 改变某些文字的颜色 并单独设置其字体
+ (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

#pragma mark 为某些文字改为链接形式
+ (NSMutableAttributedString *)addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;
@end
