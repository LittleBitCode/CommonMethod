//
//  AppMacro_H.h
//  CommonMethod
//
//  Created by littleBit on 2016/11/24.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#ifndef AppMacro_H_h
#define AppMacro_H_h

//获取屏幕宽度和高度
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height

#define kWidthScale   [[UIScreen mainScreen] bounds].size.width/320

//获取通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//对象是否为空
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//APP风格背景
#define kBGCOLOR [UIColor colorWithRed:255.0f/255.0f green:210.0f/255.0f blue:73.0f/255.0f alpha:1]
//设置RGB及透明度
#define kRGBWithAlapha(RedValue, GreenValue,BlueValue, AlphaValue ) [UIColor colorWithRed:RedValue/255.0 green:GreenValue/255.0 blue:BlueValue/255.0 alpha:AlphaValue]
//rgb颜色转换（16进制->10进制）
#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//子线程
#define kDisPatch_Global(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
//主线程
#define kDisPatch_Main(block) dispatch_async(dispatch_get_main_queue(),block)


//自定义高效率的NSLog
#ifdef DEBUG
#define LBLog(...) NSLog(@"%s 第%d行\n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LBLog(...)
#endif

//弱引用/强引用
#define LBWeakSelf(type) __weak typeof(type) weak##type = type;
#define LBStrongSelf(type) __strong typeof(type) type = weak##type;

//设置view圆角和边框
#define LBViewBorderRadius(View,Radius,Width,Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBoderColer:[Color CGColor]]

//由角度转换弧度 由弧度转换角度
#define LBDegreesToRadian(x) (M_PI *(x)/180.0)
#define LBRadianToDegrees(radian) (radian * 180.0)/(M_PI)

//获取View的frame
#define kGetViewWidth(view) view.frame.size.width
#define kGetViewHeight(view) view.frame.size.height
#define kGetViewX(view) view.frame.orgin.x
#define kGetViewY(view) view.frame.orgin.y

//获取图片资源
#define kImageName(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//获取本地图片
#define  kLoadImage(file) [UIImage imageWithContentsOfFile:[NSBundle mainBundle]pathForResource:file ofType:nil]
//获取当前语言
#define LBCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取当前设备版本
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )

//获取当前系统版本
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
#define IS_IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)
#define IS_IOS_10 ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE //真机

#endif
#if TARGET_IPHONE_SIMULATOR //模拟器

#endif

//沙盒目录文件
//获取temp
#define kTempPath NSTemporaryDirectory()
//获取沙盒Document
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]
//获取沙盒Cache
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject]

//定义常量用 UIKIT_EXTERN   //定义代码用define
UIKIT_EXTERN NSString *const LBToken;

#define kMainUrlString @"http://123.57.137.100:8080/"
#define kPayUrlString @"http://123.57.137.100:8083/"

typedef NS_ENUM(NSInteger,REQUEST_TYPE)  {
    GET_REQUEST  = 0,
    POST_REQUEST  = 1,
};

#endif /* AppMacro_H_h */
