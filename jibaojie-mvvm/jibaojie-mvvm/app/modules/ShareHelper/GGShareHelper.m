//
//  GGShareHelper.m
//  StartUp4iPhone
//
//  Created by Ron on 14-1-27.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import "GGShareHelper.h"

@implementation GGShareHelper

+ (void)bindShareWithType:(ShareType)shareType withBlock:(SSGetUserInfoEventHandler)resultBlock
{
    [ShareSDK getUserInfoWithType:shareType authOptions:[ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleModal viewDelegate:nil authManagerViewDelegate:nil] result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (resultBlock) {
            resultBlock(result,userInfo,error);
        }
    }];
}

@end
