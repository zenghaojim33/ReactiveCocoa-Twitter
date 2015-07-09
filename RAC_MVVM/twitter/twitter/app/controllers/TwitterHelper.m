//
//  TwitterLoginHelper.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "TwitterHelper.h"

#define TWITTER_BASE_URL [NSURL URLWithString:@"https://api.twitter.com/"]
#define TWITTER_CONSUMER_KEY @"I6DFKpf9tNscxPhdLDkYsA"
#define TWITTER_CONSUMER_SECRET @"vtr6Vm590pcWzS9tHwqOVelCoJqTnzAaKHX5d1II"

static NSString * const kAccessTokenKey = @"kAccessTokenKey";


@implementation twitterHelper

#pragma mark - Public static methods

+ (twitterHelper *)shareHelper {
    static dispatch_once_t once;
    static twitterHelper * instance;
    
    dispatch_once(&once, ^{
        instance = [[twitterHelper
                     alloc] initWithBaseURL:TWITTER_BASE_URL key:TWITTER_CONSUMER_KEY secret:TWITTER_CONSUMER_SECRET];
        
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
    
        DLog("%@",[error localizedDescription]);
    };
}


#pragma mark - Public instance methods

- (id)initWithBaseURL:(NSURL *)url key:(NSString *)key secret:(NSString *)secret {
    self = [super initWithBaseURL:TWITTER_BASE_URL key:TWITTER_CONSUMER_KEY secret:TWITTER_CONSUMER_SECRET];
    if (self != nil) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        
        NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:kAccessTokenKey];
        if (data) {
            self.accessToken = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return self;
}

#pragma mark - Users API

- (void)authorizeWithCallbackUrl:(NSURL *)callbackUrl
                         success:(void (^)(AF2OAuth1Token *accessToken, id responseObject))success
                         failure:(void (^)(NSError *error))failure {
    self.accessToken = nil;
    [super authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token" userAuthorizationPath:@"oauth/authorize" callbackURL:callbackUrl accessTokenPath:@"oauth/access_token" accessMethod:@"POST" scope:nil success:success failure:failure];
}

- (void)currentUserWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success{

    
    [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:success failure:[twitterHelper networkFailureBlock]];
    
    
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
                        failure:[twitterHelper networkFailureBlock]];
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
    
     [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:success failure:[twitterHelper networkFailureBlock]];
}

- (void)createRetweet:(NSString *)tweetId callback:(void (^)(NSDictionary *tweetWithRetweet))callback
{
    NSString *path = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];

    
    [self POST:path parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback((NSDictionary *)responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [twitterHelper networkFailureBlock];
    }];
}
- (void)deleteRetweet:(NSString *)tweetId
{
    NSString *path = [NSString stringWithFormat:@"1.1/statuses/destroy/%@.json", tweetId];

    [self POST:path parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [twitterHelper emptySuccessBlock];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [twitterHelper networkFailureBlock];
    }];
    
}

- (void)createFavorite:(NSString *)tweetId
{
//    [self postPath:@"1.1/favorites/create.json" parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}]
//           success:[TwitterClient emptySuccessBlock]
//           failure:[TwitterClient networkFailureBlock]];
    
    
    [self POST:@"1.1/favorites/create.json" parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}] success:[twitterHelper emptySuccessBlock] failure:[twitterHelper networkFailureBlock]];
}

- (void)deleteFavorite:(NSString *)tweetId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}];

    
    [self POST:@"1.1/favorites/destroy.json" parameters:params success:[twitterHelper emptySuccessBlock] failure:[twitterHelper networkFailureBlock]];
}

- (void)updateStatusWithString:(NSString *)status
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"status": status}];
 
    
    [self POST:@"1.1/statuses/update.json" parameters:params success:[twitterHelper emptySuccessBlock] failure:[twitterHelper networkFailureBlock]];
}



#pragma mark - Private methods

- (void)setAccessToken:(AF2OAuth1Token *)accessToken {
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
