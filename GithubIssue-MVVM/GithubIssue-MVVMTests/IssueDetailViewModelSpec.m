//
//  IssueDetailViewModelSpec.m
//  GithubIssue-MVVM
//
//  Created by Ron on 12/6/15.
//
//

#import <UIKit/UIKit.h>
#import "IssueDetailViewModel.h"
#import "Issue.h"

SpecBegin(IssueDetailViewModel)

describe(@"IssueDetailViewModel", ^{
    
    __block Issue *issue;
    __block IssueDetailViewModel *detailViewModel;
    
    beforeAll(^{
        issue = OCMClassMock([Issue class]);
        OCMStub([issue username]).andReturn(MOCK_ISSUE_USERNAME);
        OCMStub([issue avatar]).andReturn(MOCK_ISSUE_AVATAR);
        OCMStub([issue url]).andReturn(MOCK_ISSUE_URL);
        OCMStub([issue body]).andReturn(MOCK_ISSUE_BODY);
        detailViewModel = [[IssueDetailViewModel alloc] initWithIssue:issue];
    });
    
    context(@"when input a mock issue", ^{
        
        it(@"should return the same mock value", ^{
            expect(detailViewModel.link).to.equal(MOCK_ISSUE_URL);
        });
        
    });
    
});

SpecEnd



