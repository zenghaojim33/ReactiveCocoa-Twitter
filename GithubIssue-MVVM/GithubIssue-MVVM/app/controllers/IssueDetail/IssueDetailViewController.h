//
//  IssueDetailViewController.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import <UIKit/UIKit.h>
#import "IssueDetailViewModel.h"

@interface IssueDetailViewController : UIViewController

@property (nonatomic, strong) IssueDetailViewModel *viewModel;

@end
