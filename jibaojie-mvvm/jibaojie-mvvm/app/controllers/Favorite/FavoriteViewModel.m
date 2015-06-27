//
//  FavoriteViewModel.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "FavoriteViewModel.h"
#import "ProductEntity.h"

@interface FavoriteViewModel()

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *allProduct;
@property (nonatomic, strong) NSString *cacheKey;

@end

@implementation FavoriteViewModel

- (instancetype)initWithCacheKey:(NSString *)key{
    self = [super init];
    if (self) {
        self.cacheKey = key;
    }
    return self;
}

#pragma mark -
#pragma mark -------------------- Properties ---------------------
- (NSMutableArray *)allProduct{
    if (!_allProduct) {
        _allProduct = [NSMutableArray arrayWithArray:[ProductEntity cachesListByKey:self.cacheKey]];
    }
    return _allProduct;
}

- (NSString *)cacheKey{
    if (!_cacheKey) {
        return NSStringFromClass([FavoriteViewModel class]);
    }
    return _cacheKey;
}

- (NSArray *)products{
    return [self.allProduct copy];
}

- (void)fetchProductsOnCompletion:(errorBlock)block{
    self.currentPage = 0;
    [self fetchNextPageProductsOnCompletion:block];
}

- (void)fetchNextPageProductsOnCompletion:(errorBlock)block{
    __weak __typeof(&*self)weakSelf = self;
    self.currentPage ++;
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithDictionary:@{@"current_page" : @(self.currentPage), @"per_page" : RequestPerPageCount}];
    NSString *token = [JBJAccount currentAccount].token;
    if (token) {
        [paramters setObject:token forKey:@"token"];
    }
    
    [[APIClient sharedClient] GET:[NSString stringWithFormat:@"%@",API_COLLECTION_LIST] parameters:paramters
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              
                              if (weakSelf.currentPage == 1) {
                                  [weakSelf.allProduct removeAllObjects];
                              }
                              
                              NSArray *goodsOriginDatas = [responseObject objectForKey:@"goods"];
                              
                              if (goodsOriginDatas.count > 0) {
                                  for (NSDictionary *dic in goodsOriginDatas) {
                                      ProductEntity *product = [ProductEntity createFrom:dic];
                                      [weakSelf.allProduct addObject:product];
                                  }
                              }
                              
                              if (weakSelf.currentPage == 1) {
                                  [ProductEntity save2CachesByList:weakSelf.allProduct andKey:self.cacheKey];
                              }
                              
                              if (block) {
                                  block(nil);
                              }
                              
                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              weakSelf.currentPage --;
                              if (block) {
                                  block(error);
                              }
                          }];
    
}

@end
