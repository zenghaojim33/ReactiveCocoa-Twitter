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

        
    }];
    
    
}


-(void)loadMore{
    
    
    
    
}



@end
