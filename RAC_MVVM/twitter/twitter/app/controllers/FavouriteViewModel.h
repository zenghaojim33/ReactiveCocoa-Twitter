//
//  FavouriteViewModel.h
//  twitter
//
//  Created by Anson on 15/7/11.
//
//

#import <Foundation/Foundation.h>

@interface FavouriteViewModel : NSObject
@property(nonatomic,strong)NSMutableArray * cellViewModels;
@property(nonatomic,strong)NSMutableArray * tweet;
@property(nonatomic,strong,getter=isNoMoreData)NSNumber * noMoreData;

-(void)loadFavourite;

-(void)loadMore;

@end
