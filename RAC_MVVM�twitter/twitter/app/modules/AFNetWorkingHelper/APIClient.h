//
//  APIClient.h
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIAddress.h"

@interface APIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

@end
