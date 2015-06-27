//
//  ProductEntity.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "ProductEntity.h"

NSString *const ProductEntityFavoriteDidChangeNotification = @"ProductEntityFavoriteDidChangeNotification";

@implementation ProductEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
 
    return @{
             @"pid" : @"id",
             @"categoryId" : @"category_id",
             @"name" : @"name",
             @"price" : @"price",
             @"url" : @"url",
             @"originalImage" : @"original_image",
             @"middleImage" : @"middle_image",
             @"smallImage" : @"small_image",
             @"imageRatio" : @"image_ratio",
             @"content" : @"content",
             @"createdAt" : @"created_at",
             @"collection" : @"collection",
             @"collect" : @"collect",
             @"collected" : @"collected"
      };
}

- (BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[ProductEntity class]]) {
        return [self.pid isEqual:[(ProductEntity*)object pid]];
    }
    return [super isEqual:object];
}

- (void)fetchMoreInfo:(errorBlock)completionBlock{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    NSString *token = [JBJAccount currentAccount].token;
    if (token) {
        [paramters setObject:token forKey:@"token"];
    }
    __weak __typeof(&*self)weakSelf = self;
    [[APIClient sharedClient] GET:[NSString stringWithFormat:@"goods/%@",self.pid] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [weakSelf updateFrom:responseObject];
        
        if (completionBlock) {
            completionBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            completionBlock(error);
        }
    }];
}

- (void)requestFavoriteToggle:(voidBlock)completionBlock{
    NSString *token = [JBJAccount currentAccount].token;
    if (token) {
        
        NSMutableDictionary *paramters = [NSMutableDictionary dictionaryWithDictionary:@{@"token" : token , @"goods_id" : self.pid}];
        
        if (self.collected.boolValue) {
            [paramters setObject:@"delete" forKey:@"action"];
        }
        
        [self beginFavoriteToggle];
        
        __weak __typeof(&*self)weakSelf = self;
        [[APIClient sharedClient] POST:API_COLLECTION_LIST parameters: paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger errorCode = [[responseObject objectForKey:@"error"] integerValue];
            if (errorCode != 0) {
                [weakSelf failFavoriteToggle];
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:ProductEntityFavoriteDidChangeNotification object:weakSelf];
            }
            completionBlock();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weakSelf failFavoriteToggle];
            completionBlock();
        }];
    }else {
        completionBlock();
    }

}

- (void)beginFavoriteToggle{
    if (self.collected.boolValue) {
        [self beginUnFavorite];
    }else {
        [self beginFavorite];
    }
}

- (void)failFavoriteToggle{
    if (self.collected.boolValue) {
        [self failFavorite];
    }else {
        [self failUnFavorite];
    }
}

- (void)beginFavorite{
    [self _increaseFavorite];
}

- (void)failFavorite{
    [self _decreaseFavorite];
}

- (void)beginUnFavorite{
    [self _decreaseFavorite];
}

- (void)failUnFavorite{
    [self _increaseFavorite];
}

- (void)_increaseFavorite{
    self.collected = @YES;
    self.collect = @(self.collect.integerValue + 1);
}

- (void)_decreaseFavorite{
    self.collected = @NO;
    self.collect = @(self.collect.integerValue - 1);
}

@end
