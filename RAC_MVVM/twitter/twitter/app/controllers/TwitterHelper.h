//
//  TwitterLoginHelper.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "AF2OAuth1Client.h"




@interface twitterHelper : AF2OAuth1Client


+(twitterHelper *)shareHelper;
+ (void (^)(AFHTTPRequestOperation *operation, id response))emptySuccessBlock;
+ (void (^)(AFHTTPRequestOperation *operation, NSError *error))networkFailureBlock;

- (void)authorizeWithCallbackUrl:(NSURL *)callbackUrl success:(void (^)(AF2OAuth1Token *accessToken, id responseObject))success
                         failure:(void (^)(NSError *error))failure;

- (void)currentUserWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success;

// Statuses API

- (void)homeTimelineWithCount:(int)count
                      sinceId:(NSString *)sinceId
                        maxId:(NSString *)maxId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success;

- (void)homeTimelineWithCount:(int)count
                      sinceId:(NSString *)sinceId
                        maxId:(NSString *)maxId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)createRetweet:(NSString *)tweetId callback:(void (^)(NSDictionary *tweetWithRetweet))callback;
- (void)deleteRetweet:(NSString *)tweetId;
- (void)createFavorite:(NSString *)tweetId;
- (void)deleteFavorite:(NSString *)tweetId;
- (void)updateStatusWithString:(NSString *)status;


@end
