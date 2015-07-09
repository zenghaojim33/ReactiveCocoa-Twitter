//
//  ResponseSerializer.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "ResponseSerializer.h"

@implementation ResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    
    NSNumber *code = responseObject[@"code"];
 
    if (code && code.integerValue == 402) {
        DLog(@"GGResposnseSerializer is working.");
    }
    return responseObject;
}

@end