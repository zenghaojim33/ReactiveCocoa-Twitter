//
//  FavoriteSubjectCellViewModel.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "FavoriteSubjectCellViewModel.h"

@interface FavoriteSubjectCellViewModel()

@property (nonatomic, strong) ProductEntity *product;

@end


@implementation FavoriteSubjectCellViewModel

- (instancetype)initWithProduct:(ProductEntity *)product{
    self = [super init];
    if (self) {
        self.product = product;
    }
    return self;
}

- (NSString *)productName{
    return self.product.name;
}

- (NSString *)productImageUrl{
    return self.product.originalImage;
}

- (NSString *)productDescrition{
    return self.product.content;
}

- (NSNumber *)favTotalCount{
    return self.product.collect;
}

- (NSString *)previewPrice{
    return [NSString stringWithFormat:@"￥%@",self.product.price];
}


@end
