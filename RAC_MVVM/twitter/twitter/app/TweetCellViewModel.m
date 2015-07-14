//
//  TweetCellViewModel.m
//  twitter
//
//  Created by Anson on 15/7/13.
//
//

#import "TweetCellViewModel.h"
#import "TwitterClient.h"
@implementation TweetCellViewModel



-(instancetype)initWithTweet:(Tweet *)tweet{
    
    if (self = [super init]){
        
        self.tweet = tweet;
        NSLog(@"%@",tweet.username);
        return self;
        
    }
    
    return self;
    
    
}

-(RACCommand *)favouriteCommand{
    
    
    if (!_favouriteCommand){
        @weakify(self)
        _favouriteCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[TwitterClient instance]createFavorite:self.tweet.idStr callback:^(NSDictionary *favoriteResult) {
                    DLog(@"%@",favoriteResult);
                    [subscriber sendNext:@(YES)];
                
                }];
                return nil;
            }];
        }];
    
    }
    
    return _favouriteCommand;
}



@end
