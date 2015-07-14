//
//  FavouriteViewModel.m
//  twitter
//
//  Created by Anson on 15/7/11.
//
//

#import "FavouriteViewModel.h"
#import "TwitterClient.h"
#import "Tweet.h"
@implementation FavouriteViewModel

-(void)loadFavourite{
    
    [[TwitterClient instance] FavouriteListWithCount:10 sinceId:nil maxId:nil success:^(AFHTTPRequestOperation *operation, id response) {
       
        self.tweet = [Tweet tweetsWithArray:response];
        NSLog(@"%ld",self.tweet.count);

        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


-(void)loadMore{
    
    int indexOfLastLoadedTweet = (int)[_tweet count] - 2;
    Tweet *lastLoadedTweet = _tweet[indexOfLastLoadedTweet];
    
    // provide synchonization & remove possibility that many requests are made at the same time
    
    [[TwitterClient instance] FavouriteListWithCount:10 sinceId:nil maxId:lastLoadedTweet.idStr
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
