//
//  ProductListViewModel.m
//  jibaojie-mvvm
//
//  Created by Ron on 18/6/15.
//
//

#import "ProductListViewModel.h"

@interface ProductListViewModel()

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *allProduct;
@property (nonatomic, strong) NSString *cacheKey;
@property (nonatomic, strong) NSNumber *subjectId;

@end

@implementation ProductListViewModel

- (instancetype)initWithCacheKey:(NSString *)key subjectId:(NSNumber *)subjectId{
    self = [super init];
    if (self) {
        self.cacheKey = key;
        self.subjectId = subjectId;
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
        return NSStringFromClass([ProductListViewModel class]);
    }
    return _cacheKey;
}

- (NSNumber *)subjectId{
    NSAssert(_subjectId, @" without subjectid , you should use - (instancetype)initWithCacheKey:(NSString *)key subjectId:(NSString *)subjectId; ");
    return _subjectId;
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
    
    [[APIClient sharedClient] GET:[NSString stringWithFormat:@"%@/%@",API_SUBJECT_LIST,self.subjectId] parameters:paramters
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
