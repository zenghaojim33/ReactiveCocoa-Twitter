//
//  IssueListViewModel.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "IssueListViewModel.h"
#import "Issue.h"

@interface IssueListViewModel()

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *allIssues;

@end

@implementation IssueListViewModel

#pragma mark -
#pragma mark -------------------- Properties ---------------------
- (NSMutableArray *)allIssues{
    if (!_allIssues) {
        _allIssues = [NSMutableArray arrayWithArray:[Issue cachesListByKey:NSStringFromClass([Issue class])]];
    }
    return _allIssues;
}

- (NSArray *)issues{
    return [self.allIssues copy];
}

- (void)fetchIssuesOnCompletion:(errorBlock)block{
    self.currentPage = 0;
    [self fetchNextPageIssuesOnCompletion:block];
}

- (void)fetchNextPageIssuesOnCompletion:(errorBlock)block{
    self.currentPage ++;
    __weak __typeof(&*self)weakSelf = self;

    [[APIClient sharedClient] GET:ISSUE_URL parameters:@{@"page" : @(self.currentPage),@"per_page" : PER_PAGE_SIZE} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (weakSelf.currentPage == 1) {
            [Issue save2CachesByList:weakSelf.allIssues andKey:NSStringFromClass([IssueListViewModel class])];
            [weakSelf.allIssues removeAllObjects];
        }
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *issueDic in responseObject) {
                Issue *issue= [Issue createFrom:issueDic];
                [weakSelf.allIssues addObject:issue];
            }
        }
        
        if (block) {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
    }];

}

@end
