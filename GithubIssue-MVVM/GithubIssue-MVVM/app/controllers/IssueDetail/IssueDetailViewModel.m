//
//  IssueDetailViewModel.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "IssueDetailViewModel.h"
#import "Issue.h"
@interface IssueDetailViewModel()

@property (nonatomic, strong) Issue *issue;

@end

@implementation IssueDetailViewModel

- (instancetype)initWithIssue:(Issue *)issue{
    self = [super init];
    if (self) {
        self.issue = issue;
    }
    return self;
}

- (NSString *)link{
    return self.issue.url;
}


@end
