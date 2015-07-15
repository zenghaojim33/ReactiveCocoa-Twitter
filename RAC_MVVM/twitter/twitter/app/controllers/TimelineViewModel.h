//
//  TimelineViewModel.h
//  twitter
//
//  Created by Anson on 15/7/10.
//
//

#import <Foundation/Foundation.h>
#import "TweetCellViewModel.h"
@interface TimelineViewModel : NSObject
@property(nonatomic,strong)NSMutableArray * cellViewModels;
@property(nonatomic,strong)NSMutableArray * tweet;
@property(nonatomic,strong,getter=isNoMoreData)NSNumber * noMoreData;

-(void)loadTweet;

-(void)loadMore;




@end
