//
//  LBToAppStore.h
//  CommonMethod
//
//  Created by littleBit on 13-4-17.
//  Copyright (c) 2013年 littleBit. All rights reserved.
//

// 提示用户去评论

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LBToAppStore : NSObject<UIAlertViewDelegate>
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    UIAlertView *alertViewTest;
#else
    UIAlertController *alertController;
#endif
}

@property (nonatomic,strong) NSString * myAppID;//appID


- (void)showGotoAppStore:(UIViewController *)VC;

@end
