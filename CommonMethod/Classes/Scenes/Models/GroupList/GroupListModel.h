//
//  GroupListModel.h
//  CommonMethod
//
//  Created by littleBit on 2016/11/28.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubGroupList : NSObject
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSArray *role;
@end


@interface GroupList : NSObject
@property (nonatomic,strong) SubGroupList *data;
@property (nonatomic,strong) NSString *errcode;
@end


@interface DetailList : NSObject
@property (nonatomic,copy) NSString *group;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pic;

@end
