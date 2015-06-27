//
//  IssueListViewModelSpec.m
//  GithubIssue-MVVM
//
//  Created by Ron on 12/6/15.
//
//

#import <UIKit/UIKit.h>
#import "IssueListViewModel.h"
#import "Issue.h"

SpecBegin(IssueListViewModel)

describe(@"IssueListViewModel", ^{
   
    __block Issue *issue;
    __block IssueListViewModel *listViewModel;
    
    beforeAll(^{
        issue = OCMClassMock([Issue class]);
        OCMStub([issue username]).andReturn(MOCK_ISSUE_USERNAME);
        OCMStub([issue avatar]).andReturn(MOCK_ISSUE_AVATAR);
        OCMStub([issue url]).andReturn(MOCK_ISSUE_URL);
        OCMStub([issue body]).andReturn(MOCK_ISSUE_BODY);
        listViewModel = [[IssueListViewModel alloc] init];
    });
    
    context(@"when fetch issues", ^{
        
        it(@"should do fetch Issue Object", ^{
            waitUntilTimeout(100, ^(DoneCallback done) {
                
                [listViewModel fetchIssuesOnCompletion:^(NSError *error) {
                    expect(listViewModel.issues.count).beGreaterThan(0);
                    expect(listViewModel.issues.firstObject).beKindOf([Issue class]);
                    expect(error).beNil();
                    done();
                }];
                
            });
        });
        
        
        
        it(@"should fetch next Page Issue", ^{
           waitUntilTimeout(100, ^(DoneCallback done) {
              
               __block IssueListViewModel *_listViewModel = [[IssueListViewModel alloc]init];
               
               [_listViewModel fetchIssuesOnCompletion:^(NSError *error) {
                   
                   expect(_listViewModel.issues.count).equal(PER_PAGE_SIZE.integerValue);
                   
                   [_listViewModel fetchNextPageIssuesOnCompletion:^(NSError *error) {
                       expect(_listViewModel.currentPage).equal(2);
                       expect(_listViewModel.issues.count).beGreaterThan(PER_PAGE_SIZE.integerValue);
                       expect(_listViewModel.issues.firstObject).beKindOf([Issue class]);
                       expect(error).beNil();
                       done();
                   }];
                   
               }];
               
           });
        });
        
    });
    
});

SpecEnd




