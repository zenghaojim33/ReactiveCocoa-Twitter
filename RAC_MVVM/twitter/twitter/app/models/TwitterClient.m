//
//  TwitterClient.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TwitterClient.h"
#import "AFNetworking.h"

#define TWITTER_BASE_URL [NSURL URLWithString:@"https://api.twitter.com/"]
#define TWITTER_CONSUMER_KEY @"I6DFKpf9tNscxPhdLDkYsA"
#define TWITTER_CONSUMER_SECRET @"vtr6Vm590pcWzS9tHwqOVelCoJqTnzAaKHX5d1II"

static NSString * const kAccessTokenKey = @"kAccessTokenKey";

@implementation TwitterClient

#pragma mark - Public static methods

+ (TwitterClient *)instance {
    static dispatch_once_t once;
    static TwitterClient *instance;
    
    dispatch_once(&once, ^{
        instance = [[TwitterClient alloc] initWithBaseURL:TWITTER_BASE_URL key:TWITTER_CONSUMER_KEY secret:TWITTER_CONSUMER_SECRET];
    });
    
    return instance;
}

+ (void (^)(AFHTTPRequestOperation *operation, id response))emptySuccessBlock
{
    return ^(AFHTTPRequestOperation *operation, id response) {};
}

+ (void (^)(AFHTTPRequestOperation *operation, NSError *error))networkFailureBlock
{
    return ^(AFHTTPRequestOperation *operation, NSError *error){
        DLog(@"%@",error);
    };
}


#pragma mark - Public instance methods

- (id)initWithBaseURL:(NSURL *)url key:(NSString *)key secret:(NSString *)secret {
    self = [super initWithBaseURL:TWITTER_BASE_URL key:TWITTER_CONSUMER_KEY secret:TWITTER_CONSUMER_SECRET];
    if (self != nil) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:kAccessTokenKey];
        if (data) {
            self.accessToken = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return self;
}

#pragma mark - Users API

- (void)authorizeWithCallbackUrl:(NSURL *)callbackUrl
                         success:(void (^)(AFOAuth1Token *accessToken, id responseObject))success
                         failure:(void (^)(NSError *error))failure {
    self.accessToken = nil;
    [super authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token" userAuthorizationPath:@"oauth/authorize" callbackURL:callbackUrl accessTokenPath:@"oauth/access_token" accessMethod:@"POST" scope:nil success:success failure:failure];
}

- (void)currentUserWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success{
    [self getPath:@"1.1/account/verify_credentials.json"
       parameters:nil
          success:success
          failure:[TwitterClient networkFailureBlock]];
}

#pragma mark - Statuses API

- (void)homeTimelineWithCount:(int)count
                      sinceId:(NSString *)sinceId
                        maxId:(NSString *)maxId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
{
    [self homeTimelineWithCount:count
                        sinceId:sinceId
                          maxId:maxId
                        success:success
                        failure:[TwitterClient networkFailureBlock]];
}

- (void)homeTimelineWithCount:(int)count
                      sinceId:(NSString *)sinceId
                        maxId:(NSString *)maxId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"count": @(count)}];
    if (sinceId) {
        [params setObject:sinceId forKey:@"since_id"];
    }
    if (maxId) {
        [params setObject:maxId forKey:@"max_id"];
    }

    [self getPath:@"1.1/statuses/home_timeline.json"
       parameters:params
          success:success
          failure:failure];
}


- (void)favouriteListWithCount:(int)count
                      sinceId:(NSString *)sinceId
                        maxId:(NSString *)maxId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"count": @(count)}];
    if (sinceId) {
        [params setObject:sinceId forKey:@"since_id"];
    }
    if (maxId) {
        [params setObject:maxId forKey:@"max_id"];
    }
    
    [self getPath:@"1.1/favorites/list.json"
       parameters:params
          success:success
          failure:failure];
}


- (void)createRetweet:(NSString *)tweetId callback:(void (^)(NSDictionary *tweetWithRetweet))callback
{
    NSString *path = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    [self postPath:path parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}]
           success:^(AFHTTPRequestOperation *operation, id response) {
               callback((NSDictionary *)response);
           } failure:[TwitterClient networkFailureBlock]];
}

- (void)deleteRetweet:(NSString *)tweetId
{
    NSString *path = [NSString stringWithFormat:@"1.1/statuses/destroy/%@.json", tweetId];
    [self postPath:path parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}]
           success:[TwitterClient emptySuccessBlock]
           failure:[TwitterClient networkFailureBlock]];
}

- (void)createFavorite:(NSString *)tweetId callback:(void (^)(NSDictionary *favoriteResult))callback failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{

    [self postPath:@"1.1/favorites/create.json" parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}]
           success:^(AFHTTPRequestOperation *operation, id response) {
               callback((NSDictionary *)response);
           } failure:failure];
}

- (void)deleteFavorite:(NSString *)tweetId callback:(void (^)(NSDictionary *favoriteResult))callback failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [self postPath:@"1.1/favorites/destroy.json" parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}]
        success:^(AFHTTPRequestOperation *operation, id response) {
        callback((NSDictionary *)response);
        } failure:failure];
}

- (void)updateStatusWithString:(NSString *)status
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"status": status}];
    [self postPath:@"1.1/statuses/update.json" parameters:params
           success:[TwitterClient emptySuccessBlock]
           failure:[TwitterClient networkFailureBlock]];
}


- (void)FavouriteListWithCount:(int)count
                      sinceId:(NSString *)sinceId
                        maxId:(NSString *)maxId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self favouriteListWithCount:count
                        sinceId:sinceId
                          maxId:maxId
                        success:success
                        failure:failure];
}






#pragma mark - Private methods

- (void)setAccessToken:(AFOAuth1Token *)accessToken {
    [super setAccessToken:accessToken];
    
    if (accessToken) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accessToken];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAccessTokenKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccessTokenKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
