//
//  IssueDetailViewModel.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import <Foundation/Foundation.h>

@class Issue;

@interface IssueDetailViewModel : NSObject

@property (nonatomic, readonly) NSString *link;

- (instancetype)initWithIssue:(Issue *)issue;

@end
