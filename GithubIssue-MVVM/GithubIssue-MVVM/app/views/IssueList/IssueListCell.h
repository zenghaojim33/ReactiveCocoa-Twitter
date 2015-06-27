//
//  IssueListCell.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import <UIKit/UIKit.h>
#import "IssueListCellViewModel.h"

@interface IssueListCell : UITableViewCell

@property (nonatomic, strong) IssueListCellViewModel *viewModel;

@end
