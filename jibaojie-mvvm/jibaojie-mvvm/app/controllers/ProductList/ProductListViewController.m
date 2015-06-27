//
//  ProductListViewController.m
//  jibaojie-mvvm
//
//  Created by Ron on 18/6/15.
//
//

#import "ProductListViewController.h"
#import "ProductListViewModel.h"
#import "TableLoadMorer.h"
#import "ProductListCell.h"
#import "ProductDetailViewController.h"

@interface ProductListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ProductListViewModel *viewModel;

@end

@implementation ProductListViewController

- (void)dealloc{
    [self.tableView.tableLoadMorer cleanUp];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark -------------------- Propreties ---------------------
- (ProductListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ProductListViewModel alloc] initWithCacheKey:[NSString stringWithFormat:@"%@%@",NSStringFromClass([ProductListViewController class]),self.subjectId] subjectId:self.subjectId];
    }
    return _viewModel;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[ProductListCell nib] forCellReuseIdentifier:NSStringFromClass([ProductListCell class])];
    self.tableView.rowHeight = 96;
    
    [self.viewModel products];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.viewModel fetchProductsOnCompletion:^(NSError *error) {
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    }];
    
    [TableLoadMorer setUpWithTableView:self.tableView withHeight:50 withAction:^{
        [weakSelf.viewModel fetchNextPageProductsOnCompletion:^(NSError *error) {
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
    return self.viewModel.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductListCell class]) forIndexPath:indexPath];
    cell.viewModel = [[ProductListCellViewModel alloc] initWithProduct:self.viewModel.products[indexPath.row]];
    return cell;
}

#pragma mark -
#pragma mark -------------------- UITableView Delegate ---------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *detailVC = [ProductDetailViewController create];
    detailVC.viewModel = [[ProductDetailViewModel alloc] initWithProduct:self.viewModel.products[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];

}



@end
