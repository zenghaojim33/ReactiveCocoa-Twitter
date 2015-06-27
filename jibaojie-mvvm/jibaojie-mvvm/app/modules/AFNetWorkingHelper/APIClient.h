//
//  APIClient.h
//  jibaojie-mvvm
//
//  Created by Ron on 16/6/15.
//
//

#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIAddress.h"

@interface APIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

@end
