//
//  APIClient.m
//  jibaojie-mvvm
//
//  Created by Ron on 16/6/15.
//
//

#import "APIClient.h"
#import "ResponseSerializer.h"

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:API_HOST]];
        _sharedClient.responseSerializer = [ResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", @"text/javascript", nil];
    });
    return _sharedClient;
}

@end
