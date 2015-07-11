//
//  TimelineViewModel.m
//  twitter
//
//  Created by Anson on 15/7/10.
//
//

#import "TimelineViewModel.h"
#import "TwitterClient.h"
#import "Tweet.h"
@implementation TimelineViewModel


-(void)loadTweet{
    
    [[TwitterClient instance]homeTimelineWithCount:10 sinceId:nil maxId:nil success:^(AFHTTPRequestOperation *operation, id response) {
        self.tweet = [Tweet tweetsWithArray:response];
    }];
    
}


-(void)loadMore{
    
    int indexOfLastLoadedTweet = (int)[_tweet count] - 1;
    Tweet *lastLoadedTweet = _tweet[indexOfLastLoadedTweet];
    
    // provide synchonization & remove possibility that many requests are made at the same time
    
    [[TwitterClient instance] homeTimelineWithCount:10 sinceId:nil maxId:lastLoadedTweet.idStr
                                            success:^(AFHTTPRequestOperation *operation, id response) {
                                                
                                                if (((NSArray *)response).count == 0){
                                                    self.noMoreData = @(YES);
                                                    return ;
                                                }
                                                
                                                NSMutableArray * tweets = [self mutableArrayValueForKey:@"tweet"];
                                                [tweets addObjectsFromArray:[Tweet tweetsWithArray:response]];
                                                
                                                
                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                
                                                
                                            
                                            }];

    
}





@end
