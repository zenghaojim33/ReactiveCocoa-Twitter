//
//  ProductEntity.h
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "GGModel.h"

UIKIT_EXTERN NSString *const ProductEntityFavoriteDidChangeNotification;

@interface ProductEntity : GGModel

@property (strong, nonatomic)  NSNumber *pid;
@property (strong, nonatomic)  NSNumber *categoryId;
@property (strong, nonatomic)  NSString *name;
@property (strong, nonatomic)  NSNumber *price;
@property (strong, nonatomic)  NSString *url;
@property (strong, nonatomic)  NSString *originalImage;
@property (strong, nonatomic)  NSString *middleImage;
@property (strong, nonatomic)  NSString *smallImage;
@property (strong, nonatomic)  NSNumber *imageRatio;
@property (strong, nonatomic)  NSString *content;
@property (strong, nonatomic)  NSString *createdAt;
@property (strong, nonatomic)  NSString *collection;
/**
 *  商品被收藏的总数
 */
@property (strong, nonatomic)  NSNumber *collect;
/**
 *  当前登陆用户是否已收藏
 */
@property (strong, nonatomic)  NSNumber *collected;

- (void)fetchMoreInfo:(errorBlock)completionBlock;

- (void)requestFavoriteToggle:(voidBlock)completionBlock;

- (void)beginFavoriteToggle;

- (void)failFavoriteToggle;

- (void)beginFavorite;

- (void)failFavorite;

- (void)beginUnFavorite;

- (void)failUnFavorite;

@end
