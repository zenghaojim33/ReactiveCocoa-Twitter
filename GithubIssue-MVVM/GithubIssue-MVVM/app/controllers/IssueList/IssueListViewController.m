//
//  IssueListViewController.m
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//

#import "IssueListViewController.h"
#import "IssueListViewModel.h"
#import "IssueListCell.h"
#import "TableLoadMorer.h"
#import "IssueDetailViewController.h"

@interface IssueListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IssueListViewModel *viewModel;

@end

@implementation IssueListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark -------------------- Properties ---------------------
- (IssueListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[IssueListViewModel alloc] init];
    }
    return _viewModel;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[IssueListCell nib] forCellReuseIdentifier:NSStringFromClass([IssueListCell class])];
    self.tableView.rowHeight = 86;
    
    [self.viewModel issues];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.viewModel fetchIssuesOnCompletion:^(NSError *error) {
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    }];
    
    [TableLoadMorer setUpWithTableView:self.tableView withHeight:50 withAction:^{
        [weakSelf.viewModel fetchNextPageIssuesOnCompletion:^(NSError *error) {
            [weakSelf.tableView.tableLoadMorer stopAnimation];
            [weakSelf.tableView reloadData];
        }];
    }];
    
    [self.tableView.header beginRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView reloadRowsAtIndexPaths:@[self.tableView.indexPathForSelectedRow] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark -------------------- UITableView DataSource ---------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.issues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IssueListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IssueListCell class]) forIndexPath:indexPath];
    cell.viewModel = [[IssueListCellViewModel alloc] initWithIssueObject:self.viewModel.issues[indexPath.row]];
    return cell;
}

#pragma mark -
#pragma mark -------------------- UITableView Delegate ---------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IssueDetailViewController *detailVC = [IssueDetailViewController create];
    detailVC.viewModel = [[IssueDetailViewModel alloc] initWithIssue:self.viewModel.issues[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
