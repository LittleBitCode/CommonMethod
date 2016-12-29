//
//  UIBarButtonItem+BarItem.m
//  CommonMethod
//
//  Created by littleBit on 2016/12/13.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "UIBarButtonItem+BarItem.h"

@implementation UIBarButtonItem (BarItem)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //根据图片大小设置button大小（如果正常  和 highlight的图片大小不一样 无法显示出图片）
    //    //button.bounds = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    //    [button mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(19, 27));
    //
    //    }];
    button.bounds = CGRectMake(0, 0, 16, 25);
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName imageSize:(CGSize)imagesize target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.bounds = CGRectMake(0, 0, imagesize.width, imagesize.height);
    
    //    if (kSession) {
    if ([imageName isEqualToString:@"weidenglu"]) {
        [button setBackgroundImage:[UIImage imageNamed:@"yidenglu"] forState:UIControlStateNormal];
        
    }else{
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
    }
    //    }else{
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    //    }
    
    //    [button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

@end
