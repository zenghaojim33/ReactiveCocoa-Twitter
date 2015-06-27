//
//  ProductDetailViewModel.h
//  jibaojie-mvvm
//
//  Created by Ron on 20/6/15.
//
//

#import <Foundation/Foundation.h>
#import "ProductEntity.h"

@interface ProductDetailViewModel : NSObject

@property (nonatomic, readonly) NSString *link;
@property (nonatomic, readonly) BOOL isFavorite;
@property (nonatomic, readonly) ProductEntity *product;

- (instancetype)initWithProduct:(ProductEntity *)product;

@end
