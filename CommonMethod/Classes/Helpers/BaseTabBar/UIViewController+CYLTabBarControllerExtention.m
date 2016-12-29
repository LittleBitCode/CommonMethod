//
//  UIViewController+CYLTabBarControllerExtention.m
//  CommonMethod
//
//  Created by littleBit on 13-4-17.
//  Copyright (c) 2013年 littleBit. All rights reserved.
//

#import "UIViewController+CYLTabBarControllerExtention.h"
#import "CYLTabBarController.h"

@implementation UIViewController (CYLTabBarControllerExtention)

- (UIViewController *)cyl_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index {
    [self checkTabBarChildControllerValidityAtIndex:index];
    [self.navigationController popToRootViewControllerAnimated:NO];
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    tabBarController.selectedIndex = index;
    UIViewController *selectedTabBarChildViewController = tabBarController.selectedViewController;
    BOOL isNavigationController = [[selectedTabBarChildViewController class] isSubclassOfClass:[UINavigationController class]];
    if (isNavigationController) {
        return ((UINavigationController *)selectedTabBarChildViewController).viewControllers[0];
    }
    return selectedTabBarChildViewController;
}

- (void)cyl_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index
                                           completion:(CYLPopSelectTabBarChildViewControllerCompletion)completion {
    UIViewController *selectedTabBarChildViewController = [self cyl_popSelectTabBarChildViewControllerAtIndex:index];
    dispatch_async(dispatch_get_main_queue(), ^{
        !completion ?: completion(selectedTabBarChildViewController);
    });
}

- (UIViewController *)cyl_popSelectTabBarChildViewControllerForClassType:(Class)classType {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    __block NSInteger atIndex = NSNotFound;
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj_ = nil;
        BOOL isNavigationController = [[tabBarController.viewControllers[idx] class] isSubclassOfClass:[UINavigationController class]];
        if (isNavigationController) {
            obj_ = ((UINavigationController *)obj).viewControllers[0];
        } else {
            obj_ = obj;
        }
        if ([obj_ isKindOfClass:classType]) {
            atIndex = idx;
            *stop = YES;
            return;
        }
    }];
    
    return [self cyl_popSelectTabBarChildViewControllerAtIndex:atIndex];
}

- (void)cyl_popSelectTabBarChildViewControllerForClassType:(Class)classType
                                                completion:(CYLPopSelectTabBarChildViewControllerCompletion)completion {
    UIViewController *selectedTabBarChildViewController = [self cyl_popSelectTabBarChildViewControllerForClassType:classType];
    dispatch_async(dispatch_get_main_queue(), ^{
        !completion ?: completion(selectedTabBarChildViewController);
    });
}

- (void)checkTabBarChildControllerValidityAtIndex:(NSUInteger)index {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    @try {
        UIViewController *viewController;
        viewController = tabBarController.viewControllers[index];
        if (index != tabBarController.selectedIndex) {
            CYLExternPlusButton.selected = NO;
        }
    } @catch (NSException *exception) {
        NSString *formatString = @"\n\n\
        ------ BEGIN NSException Log ---------------------------------------------------------------------\n \
        class name: %@                                                                                    \n \
        ------line: %@                                                                                    \n \
        ----reason: The Class Type or the index or its NavigationController you pass in method `-cyl_popSelectTabBarChildViewControllerAtIndex` or `-cyl_popSelectTabBarChildViewControllerForClassType` is not the item of CYLTabBarViewController \n \
        ------ END ---------------------------------------------------------------------------------------\n\n";
        NSString *reason = [NSString stringWithFormat:formatString,
                            @(__PRETTY_FUNCTION__),
                            @(__LINE__)];
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:reason
                                     userInfo:nil];
    }
}

@end
