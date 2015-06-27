//
//  APIClient.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIAddress.h"

@interface APIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

@end
