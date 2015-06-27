//
//  ResponseSerializer.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "ResponseSerializer.h"

@implementation ResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    
    return responseObject;
}

@end