//
//  IssueListCellViewModelSpec.m
//  GithubIssue-MVVM
//
//  Created by Ron on 12/6/15.
//
//

#import <UIKit/UIKit.h>
#import "IssueListCellViewModel.h"
#import "Issue.h"


SpecBegin(IssueListCellViewModel)

describe(@"IssueListCellViewModel", ^{
    
    __block Issue *issue;
    __block IssueListCellViewModel *cellViewModel;
    
    beforeAll(^{
        issue = OCMClassMock([Issue class]);
        OCMStub([issue username]).andReturn(MOCK_ISSUE_USERNAME);
        OCMStub([issue avatar]).andReturn(MOCK_ISSUE_AVATAR);
        OCMStub([issue url]).andReturn(MOCK_ISSUE_URL);
        OCMStub([issue body]).andReturn(MOCK_ISSUE_BODY);
        cellViewModel = [[IssueListCellViewModel alloc] initWithIssueObject:issue];
    });
    
    context(@"when input a mock issue", ^{
        
        it(@"should return the same mock value", ^{
            expect(cellViewModel.username).to.equal(MOCK_ISSUE_USERNAME);
            expect(cellViewModel.avatar).to.equal(MOCK_ISSUE_AVATAR);
            expect(cellViewModel.link).to.equal(MOCK_ISSUE_URL);
            expect(cellViewModel.body).to.equal(MOCK_ISSUE_BODY);
        });
        
    });
    
});

SpecEnd
