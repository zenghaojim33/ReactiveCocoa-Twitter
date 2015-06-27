//
//  IssueListCellViewModel.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "IssueListCellViewModel.h"
#import "Issue.h"

@interface IssueListCellViewModel()

@property (nonatomic, strong) Issue *issue;

@end


@implementation IssueListCellViewModel

- (instancetype)initWithIssueObject:(Issue *)issue{
    self = [super init];
    if (self) {
        self.issue = issue;
    }
    return self;
}

- (NSString *)username{
    return self.issue.username;
}

- (NSString *)avatar{
    return self.issue.avatar;
}

- (NSString *)body{
    return self.issue.body;
}

- (NSString *)link{
    return self.issue.url;
}

@end
