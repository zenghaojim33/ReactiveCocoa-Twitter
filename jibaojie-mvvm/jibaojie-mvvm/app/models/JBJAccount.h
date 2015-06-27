//
//  JBJAccount.h
//  jibaojie-mvvm
//
//  Created by Ron on 21/6/15.
//
//

#import "MojoModel.h"

@interface JBJAccount : MojoModel

typedef void(^loginBlock)(JBJAccount *account);

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *avatarUrl;

+ (void)loginOnCompletion:(loginBlock)successBlock;

- (void)flagLogin;

+ (JBJAccount *)currentAccount;

+ (void)logout;


@end
