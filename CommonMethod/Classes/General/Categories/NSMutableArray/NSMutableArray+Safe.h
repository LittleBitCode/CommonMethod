//
//  NSMutableArray+Safe.h
//  CommonMethod
//
//  Created by littleBit on 2016/12/13.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)
//以下写法均防止闪退
- (void)safeAddObject:(id)object;

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index;

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs;

- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)safeRemoveObjectsInRange:(NSRange)range;
@end
