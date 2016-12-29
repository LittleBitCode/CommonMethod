//
//  NSMutableDictionary+Safe.h
//  CommonMethod
//
//  Created by littleBit on 2016/12/13.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)
- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey;
- (id)safeObjectForKey:(id<NSCopying>)aKey;
@end
