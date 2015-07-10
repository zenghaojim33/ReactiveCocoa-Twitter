//
//  TwitterLoginViewModel.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "TwitterLoginViewModel.h"
#import "User.h"

@implementation TwitterLoginViewModel

-(instancetype)init{
    
    if (self = [super init]){
        
        self.client = [TwitterClient instance];
        
        return self;
    }
    return nil;
}




-(RACSignal *)loginSignal{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[TwitterClient instance]authorizeWithCallbackUrl:[NSURL URLWithString:@"adamtait-twitter://success"] success:^(AFOAuth1Token *accessToken, id responseObject) {
            
            [[TwitterClient instance] currentUserWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
                [User setCurrentUser:[[User alloc] initWithDictionary:response]];
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
            }];
            
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    
}

@end
