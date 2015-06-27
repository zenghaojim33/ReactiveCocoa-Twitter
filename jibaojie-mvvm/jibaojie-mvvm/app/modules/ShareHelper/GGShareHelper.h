//
//  GGShareHelper.h
//  StartUp4iPhone
//
//  Created by Ron on 14-1-27.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGShareHelper : NSObject

+ (void)bindShareWithType:(ShareType)shareType withBlock:(SSGetUserInfoEventHandler)resultBlock;

@end
