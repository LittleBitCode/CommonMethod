//
//  LBMethods.m
//  CommonMethod
//
//  Created by littleBit on 2016/11/25.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "LBMethods.h"
#import <CoreText/CoreText.h>
@implementation LBMethods
SYNTHESIZE_SINGLETON_FOR_CLASS(LBMethods)

#pragma mark - 取得本软件的版本
+(NSString *)getAppVersion {
    NSDictionary * dict = [[NSBundle mainBundle] infoDictionary];
    return [dict objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark 获取磁盘总空间大小
+ (CGFloat)allSizeMBytesOfDisk {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"%@",error.localizedDescription);
#endif
    }else {
        NSNumber *number  = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

#pragma mark 获取磁盘可用空间大小
+ (CGFloat)canUseSizeMBytesOfDisk {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"%@",error.localizedDescription);
#endif
    }else {
        NSNumber *number  = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

#pragma mark 获取指定路径下某个文件的大小
+ (CGFloat)fileSizeMBytesAtPath:(NSString *)filePath{
    NSFileManager *filenamager = [NSFileManager defaultManager];
    if (![filenamager fileExistsAtPath:filePath]) {
        return 0;
    }
    return [[filenamager attributesOfItemAtPath:filePath error:nil] fileSize];
}

#pragma mark 获取文件夹下所有文件的大小
+ (CGFloat)folderSizeMBytesAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *fileEnmerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [fileEnmerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeMBytesAtPath:filePath];
    }
    return folerSize;
}

#pragma mark 根据时间间隔计算多少天多少小时
+ (NSString *)betweenDate:(NSDate *)end withDate:(NSDate *)start{
    NSTimeInterval time = [end timeIntervalSinceDate:start];
    if (time < 0) {
        
    }
    NSString *timeStr = [[LBMethods sharedLBMethods] getOvertime:time];
    return timeStr;
}
- (NSString*)getOvertime:(NSInteger )msec {
    if (msec <= 0) {
        return @"";
    }
    NSInteger d = msec/60/60/24;
    double h = msec/60/60%24;
    double  m = msec/60%60;
    m = m / 60;
    h = h + m;
    NSString *_tStr = @"";
    NSString *_dStr = @"";
    NSString *_hStr = @"";
    if (d > 0) {
        _dStr = [NSString stringWithFormat:@"%ld天",d];
    }
    if (h > 0) {
        _hStr = [NSString stringWithFormat:@"%.1f小时",h];
    }
    _tStr = [NSString stringWithFormat:@"%@%@",_dStr,_hStr];
    return _tStr;
}

#pragma mark 判断是否是身份证
+(BOOL)isPersonCard:(NSString*)string {
    if ([string length]!= 15 && [string length] != 18)
    {
        return NO;
    }
    else if ( ([string length] == 18 ||[string length] ==15) && [self isNumberStr:string])
    {
        return YES;
    }
    else if ([string length] == 18  && ([self isNumberStr:[string substringToIndex:17] ] && ([string hasSuffix:@"X"] || [string hasSuffix:@"x"])))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    //    return [string isMatchedByRegex:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}((19\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|(19\\d{2}(0[13578]|1[02])31)|(19\\d{2}02(0[1-9]|1\\d|2[0-8]))|(19([13579][26]|[2468][048]|0[48])0229))\\d{3}(\\d|X|x)?$"];
}

#pragma mark 判断是否数字组成
+ (BOOL)isNumberStr:(NSString*)string {
    NSString *number =@"0123456789";
    NSCharacterSet * cs =[[NSCharacterSet characterSetWithCharactersInString:number]invertedSet];
    NSString * comparStr = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    return [string isEqualToString:comparStr];
}


#pragma mark  获取手机归属地
+ (NSString *)getProvinceWithPhoneNumber:(NSString *)phoneNumber {
    NSString *URLString = @"https://tcc.taobao.com/cc/json/mobile_tel_segment.htm";
    NSURL *URL =[NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest =[NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    NSString *bodyString = [NSString stringWithFormat:@"tel=%@",phoneNumber];
    [URLRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *responseObject = [NSURLConnection sendSynchronousRequest:URLRequest returningResponse:nil error:nil];
    NSString *string= @"";
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    string= [[NSString alloc] initWithData:responseObject   encoding:gbkEncoding];
    NSArray *array = [string componentsSeparatedByString:@"carrier:'"];
    NSArray *lastArray = [array.lastObject componentsSeparatedByString:@"'"];
    NSDictionary *resultDic = @{@"province":lastArray[0]};
    return resultDic[@"province"];
}

#pragma mark 获取唯一标示符
+ (NSString*) getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark 计算字符串size,用于label的frame
+ (CGSize)sizeWithText:(NSString *)text boundingRectWithSize:(CGSize)boundingSize font:(UIFont *)font{
    if (IS_IOS_7 || IS_IOS_8 || IS_IOS_9 || IS_IOS_10) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];//调整行间距
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjects:@[font,paragraphStyle] forKeys:@[NSFontAttributeName,NSParagraphStyleAttributeName]];
        
        CGSize contentSize = [text boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return contentSize;
    } else {
        CGSize labelsize = [text sizeWithFont:font constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
        return labelsize;
    }
}

#pragma mark 得到今天是星期几
+(NSString *)getWeekNameWithDate:(NSDate *)date {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * comps =[calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDay = [comps weekday];
    switch (weekDay) {
        case 1:
            return @"星期日";
        case 2:
            return @"星期一";
        case 3:
            return @"星期二";
        case 4:
            return @"星期三";
        case 5:
            return @"星期四";
        case 6:
            return @"星期五";
        case 7:
            return @"星期六";
        default:
            return @"未知";
    }
}

#pragma mark  - navgation pop和push动画 iOS7适配
+(void)currentPage:(UIViewController*)currentPage pushTo:(UIViewController*)newPage; {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =
    //kCATransitionFromTop;
//    kCATransitionFromLeft;
    kCATransitionFromRight;
//    kCATransitionFromBottom;
    [currentPage.navigationController.view.layer addAnimation:transition forKey:nil];
    [currentPage.navigationController pushViewController:newPage animated:NO];
}

+(void)currentPage:(UIViewController*)currentPage popViewControllerAnimated:(BOOL)myBool {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    [currentPage.navigationController.view.layer addAnimation:transition forKey:nil];
    [currentPage.navigationController  popViewControllerAnimated:NO];
}

+(void)currentPage:(UIViewController*)currentPage popToViewController:(UIViewController*)oldPage {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    [currentPage.navigationController.view.layer addAnimation:transition forKey:nil];
    [currentPage.navigationController  popToViewController:oldPage animated:NO];
    
}
+(void)currentPage:(UIViewController*)currentPage popToRootViewControllerAnimated:(BOOL)myBool {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    [currentPage.navigationController.view.layer addAnimation:transition forKey:nil];
    [currentPage.navigationController popToRootViewControllerAnimated:NO];
}

/**
 *  单纯改变一句话中的某些字的颜色
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)changeCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    for (NSString *rangeStr in subArray) {
        NSMutableArray *array = [[LBMethods sharedLBMethods] getRangeWithTotalString:totalStr SubString:rangeStr];
        for (NSNumber *rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    return attributedStr;
}

#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
- (NSMutableArray *)getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString {
    NSMutableArray *arrayRanges = [NSMutableArray array];
    if (subString == nil && [subString isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [totalString rangeOfString:subString];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber valueWithRange:rang]];
        NSRange      rang1 = {0,0};
        NSInteger location = 0;
        NSInteger   length = 0;
        for (int i = 0;; i++) {
            if (0 == i) {
                location = rang.location + rang.length;
                length = totalString.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            } else {
                location = rang1.location + rang1.length;
                length = totalString.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [totalString rangeOfString:subString options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            } else {
                [arrayRanges addObject:[NSNumber valueWithRange:rang1]];
            }
        }
        return arrayRanges;
    }
    return nil;
}

/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)changeSpaceWithTotalString:(NSString *)totalString Space:(CGFloat)space {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    
    return attributedStr;
}
/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}
/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSLinkAttributeName value:totalString range:range];
    }
    return attributedStr;
}



















@end
