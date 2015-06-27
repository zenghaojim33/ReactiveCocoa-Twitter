//
//  ProductDetailViewModel.m
//  jibaojie-mvvm
//
//  Created by Ron on 20/6/15.
//
//

#import "ProductDetailViewModel.h"

@interface ProductDetailViewModel()

@property (nonatomic, strong) ProductEntity *product;

@end

@implementation ProductDetailViewModel

- (instancetype)initWithProduct:(ProductEntity *)product{
    self = [super init];
    if (self) {
        self.product = product;
    }
    return self;
}

- (NSString *)link{
    return self.product.url;
}

- (BOOL)isFavorite{
    return self.product.collected.boolValue;
}


@end
