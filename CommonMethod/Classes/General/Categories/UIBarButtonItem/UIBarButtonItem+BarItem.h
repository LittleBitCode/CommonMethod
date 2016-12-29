//
//  UIBarButtonItem+BarItem.h
//  CommonMethod
//
//  Created by littleBit on 2016/12/13.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarItem)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName imageSize:(CGSize)imagesize target:(id)target action:(SEL)action;
@end
