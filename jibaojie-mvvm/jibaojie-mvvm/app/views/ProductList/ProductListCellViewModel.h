//
//  ProductListCellViewModel.h
//  jibaojie-mvvm
//
//  Created by Ron on 18/6/15.
//
//

#import <Foundation/Foundation.h>
#import "ProductEntity.h"

@interface ProductListCellViewModel : NSObject

@property (nonatomic, readonly) NSString *productName;
@property (nonatomic, readonly) NSString *productImageUrl;
@property (nonatomic, readonly) NSString *productDescrition;
@property (nonatomic, readonly) NSNumber *favTotalCount;
@property (nonatomic, readonly) NSString *previewPrice;

- (instancetype)initWithProduct:(ProductEntity *)product;

@end
