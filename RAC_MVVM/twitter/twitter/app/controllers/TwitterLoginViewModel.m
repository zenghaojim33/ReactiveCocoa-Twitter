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
        
        self.helper = [twitterHelper shareHelper];
        
        return self;
    }
    return nil;
}

-(void)loginTwitter{
    
    
    [[twitterHelper shareHelper]authorizeWithCallbackUrl:[NSURL URLWithString:@"adamtait-twitter://success"] success:^(AF2OAuth1Token *accessToken, id responseObject) {
        
        
        
        
    } failure:^(NSError *error) {
        
        
        
        
    }];
    
    
    
    
}

@end
