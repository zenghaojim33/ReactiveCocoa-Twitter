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
        NSArray * tweets = [Tweet tweetsWithArray:response];
        self.cellViewModels = [NSMutableArray array];
        NSMutableArray * cellViewModels = [self mutableArrayValueForKey:@"cellViewModels"];
        for (NSUInteger i = 0 ; i < tweets.count; i++){
            
            TweetCellViewModel * viewModel = [[TweetCellViewModel alloc]initWithTweet:tweets[i]];
            [cellViewModels addObject:viewModel];
        }
    }];
    
}


-(void)loadMore{
    
    int indexOfLastLoadedTweet = (int)[_tweet count] - 2;
    Tweet *lastLoadedTweet = _tweet[indexOfLastLoadedTweet];
    
    // provide synchonization & remove possibility that many requests are made at the same time
    
    [[TwitterClient instance] homeTimelineWithCount:10 sinceId:nil maxId:lastLoadedTweet.idStr
                                            success:^(AFHTTPRequestOperation *operation, NSArray * response) {
                                                
                                                if (response.count == 0){
                                                    self.noMoreData = @(YES);
                                                    return ;
                                                }
                                                NSArray * tweets = [Tweet tweetsWithArray:response];
                                                NSMutableArray * cellViewModels = [self mutableArrayValueForKey:@"cellViewModels"];
                                                for (NSUInteger i = 0 ; i < response.count; i++){
                                                    
                                                    TweetCellViewModel * viewModel = [[TweetCellViewModel alloc]initWithTweet:tweets[i]];
                                                    [cellViewModels addObject:viewModel];
                                                
                                                }
                                                
                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                
                                                
                                            
                                            }];

    
}

-(TweetCellViewModel *)viewModelForCellAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCellViewModel * viewModel = [[TweetCellViewModel alloc]initWithTweet:self.tweet[indexPath.row]];
    
    return viewModel;
    
}



@end
