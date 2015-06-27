//
//  FavoriteViewModel.h
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import <Foundation/Foundation.h>

@interface FavoriteViewModel : NSObject

- (instancetype)initWithCacheKey:(NSString *)key;

@property (nonatomic, readonly) NSArray *products;

@property (nonatomic, readonly) NSInteger currentPage;

- (void)fetchProductsOnCompletion:(errorBlock)block;

- (void)fetchNextPageProductsOnCompletion:(errorBlock)block;

@end
