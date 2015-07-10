//
//  TwitterLoginViewModel.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "TwitterLoginViewModel.h"


@implementation TwitterLoginViewModel

-(instancetype)init{
    
    if (self = [super init]){
        
        self.client = [TwitterClient instance];
        
        return self;
    }
    return nil;
}


-(void)loginTwitter{
    
    
    [[TwitterClient instance]authorizeWithCallbackUrl:[NSURL URLWithString:@"adamtait-twitter://success"] success:^(AFOAuth1Token *accessToken, id responseObject) {
        
        [[TwitterClient instance] homeTimelineWithCount:10 sinceId:nil maxId:nil
                                                success:^(AFHTTPRequestOperation *operation, id response) {
                                                    NSLog(@"%@",response);
                                                    
                                                }  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    
                                              
                                                }];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

}

@end
