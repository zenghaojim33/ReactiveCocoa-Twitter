//
//  Issue.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "Issue.h"

@implementation Issue

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"username" : @"user.login",
             @"avatar" : @"user.avatar_url",
             @"body" : @"body",
             @"url" : @"html_url"
             };
}

@end
