//
//  IssueListViewModel.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import <Foundation/Foundation.h>
#import "IssueListCellViewModel.h"

@interface IssueListViewModel : NSObject

@property (nonatomic, readonly) NSArray *issues;
@property (nonatomic, readonly) NSInteger currentPage;

- (void)fetchIssuesOnCompletion:(errorBlock)block;

- (void)fetchNextPageIssuesOnCompletion:(errorBlock)block;

@end
