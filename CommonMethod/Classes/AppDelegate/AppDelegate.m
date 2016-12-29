//
//  AppDelegate.m
//  CommonMethod
//
//  Created by littleBit on 2016/11/24.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "CYLPlusButtonSubclass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [NSThread sleepForTimeInterval:2.5];
    // 统一修改导航栏字体属性
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //统一修改导航栏背景颜色
     [[UINavigationBar appearance] setBarTintColor:kBGCOLOR];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    //当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //之前版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"appVersion"];
    
//    if (lastVersion == nil || lastVersion != currentVersion) {
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"appVersion"];
        LBGuidViewController *vc =[[UIStoryboard storyboardWithName:@"HomePage" bundle:nil] instantiateViewControllerWithIdentifier:@"LBGuidViewController"];
        [self.window setRootViewController:vc];
//    }else {
//        [CYLPlusButtonSubclass registerPlusButton];
//        BaseTabBarController *tabBarControllerConfig = [[BaseTabBarController alloc] init];
//        [self.window setRootViewController:tabBarControllerConfig.tabBarController];
//    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}
- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
