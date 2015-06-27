//
//  HomeViewController.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeSubjectCell.h"
#import "ProductListViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HomeViewModel *viewModel;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self.tableView registerNib:[HomeSubjectCell nib] forCellReuseIdentifier:NSStringFromClass([HomeSubjectCell class])];
    self.tableView.rowHeight = 95;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.viewModel subjects];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.viewModel fetchSubjectsOnCompletion:^(NSError *error) {
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    }];
    
    [self.tableView.header beginRefreshing];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark -------------------- Properties ---------------------
- (HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark -
#pragma mark -------------------- UITableView DataSource ---------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.subjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeSubjectCell class]) forIndexPath:indexPath];
    cell.viewModel = [[HomeSubjectCellViewModel alloc] initWithSubjectObject:self.viewModel.subjects[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectEntity *subject = self.viewModel.subjects[indexPath.row];
    ProductListViewController *productListController = [ProductListViewController create];
    productListController.subjectId = subject.sid;
    productListController.title = subject.name;
    [self.navigationController pushViewController:productListController animated:YES];
}

@end
