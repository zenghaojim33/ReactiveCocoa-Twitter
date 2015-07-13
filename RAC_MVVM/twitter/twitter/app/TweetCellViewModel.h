//
//  TweetCellViewModel.h
//  twitter
//
//  Created by Anson on 15/7/13.
//
//

#import <Foundation/Foundation.h>
#import "Tweet.h"
@interface TweetCellViewModel : NSObject
@property(nonatomic,strong)Tweet * tweet;
@property(nonatomic,strong)RACCommand * favouriteCommand;

-(instancetype)initWithTweet:(Tweet*)tweet;

@end
