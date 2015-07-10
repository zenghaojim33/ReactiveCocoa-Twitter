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
    
    
}

@end
