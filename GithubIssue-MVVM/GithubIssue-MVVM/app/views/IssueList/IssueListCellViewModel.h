//
//  IssueListCellViewModel.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import <Foundation/Foundation.h>
@class Issue;

@interface IssueListCellViewModel : NSObject

@property (nonatomic, readonly) NSString *username;
@property (nonatomic, readonly) NSString *avatar;
@property (nonatomic, readonly) NSString *body;
@property (nonatomic, readonly) NSString *link;

- (instancetype)initWithIssueObject:(Issue *)issue;

@end
