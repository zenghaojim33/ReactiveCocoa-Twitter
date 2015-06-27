//
//  ProductListViewModel.h
//  jibaojie-mvvm
//
//  Created by Ron on 18/6/15.
//
//

#import <Foundation/Foundation.h>
#import "ProductEntity.h"

@interface ProductListViewModel : NSObject

- (instancetype)initWithCacheKey:(NSString *)key subjectId:(NSNumber *)subjectId;

@property (nonatomic, readonly) NSArray *products;

@property (nonatomic, readonly) NSInteger currentPage;

- (void)fetchProductsOnCompletion:(errorBlock)block;

- (void)fetchNextPageProductsOnCompletion:(errorBlock)block;


@end
