//
//  JBJAccount.m
//  jibaojie-mvvm
//
//  Created by Ron on 21/6/15.
//
//

#import "JBJAccount.h"
#import "GGShareHelper.h"

@implementation JBJAccount

+ (void)loginOnCompletion:(loginBlock)successBlock{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [GGShareHelper bindShareWithType:ShareTypeSinaWeibo withBlock:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (successBlock) {
            if (!error && result && userInfo) {
                
                NSString *token = [userInfo credential].token;
                NSDictionary *userInfoDic = [userInfo sourceData];
                
                [[APIClient sharedClient] POST:API_LOGIN_LIST parameters:@{@"token": token, @"type" : @"weibo"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSInteger errorCode = [[responseObject objectForKey:@"error"] integerValue];
                    if (errorCode == 0) {
                        
                        NSNumber *uid = userInfoDic[@"id"];
                        JBJAccount *account = [[JBJAccount findByColumn:@"uid" value:uid] firstObject];
                        if (!account) {
                            account = [[JBJAccount alloc] init];
                        }
                        
                        account.uid = uid;
                        account.nickName = userInfoDic[@"screen_name"];
                        account.token = responseObject[@"token"];
                        account.avatarUrl = userInfoDic[@"avatar_hd"];
                        [account flagLogin];
                        successBlock(account);
                    }else {
                        successBlock(nil);
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    successBlock(nil);
                }];
            
            }else {
                successBlock(nil);
            }
        }
    }];

}

+ (JBJAccount *)currentAccount{
    NSString *uid = [JBJAccount currentUid];
    if (uid) {
        return [[JBJAccount findByColumn:@"uid" value:uid] firstObject];
    }
    return nil;
}

+ (NSString*)currentUid{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[JBJAccount loginKey]];
}

- (void)flagLogin{
    if (self.uid) {
        [self save];
        [[NSUserDefaults standardUserDefaults] setObject:self.uid forKey:[JBJAccount loginKey]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)loginKey{
    return [NSString stringWithFormat:@"%@-account",[[NSBundle mainBundle] bundleIdentifier]];
}

+ (void)logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[JBJAccount loginKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
