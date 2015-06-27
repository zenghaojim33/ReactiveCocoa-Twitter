//
//  FavoriteViewController.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "FavoriteViewController.h"
#import "FavoriteViewModel.h"
#import "FavoriteSubjectCell.h"
#import "TableLoadMorer.h"
#import "ProductDetailViewController.h"
#import "LoginWeiboView.h"

@interface FavoriteViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FavoriteViewModel *viewModel;
@property (nonatomic, strong) LoginWeiboView *loginView;

@end

@implementation FavoriteViewController

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
- (FavoriteViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[FavoriteViewModel alloc] initWithCacheKey:[NSString stringWithFormat:@"%@Fav",NSStringFromClass([FavoriteViewController class])]];
    }
    return _viewModel;
}

- (LoginWeiboView *)loginView{
    if (!_loginView) {
        _loginView = [LoginWeiboView loadFromNib];
        _loginView.hidden = YES;
        __weak __typeof(&*self)weakSelf = self;
        _loginView.loginBlock = ^(){
            [JBJAccount loginOnCompletion:^(JBJAccount *account) {
                weakSelf.loginView.hidden = account;
            }];
        };
    }
    return _loginView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[FavoriteSubjectCell nib] forCellReuseIdentifier:NSStringFromClass([FavoriteSubjectCell class])];
    self.tableView.rowHeight = 67;
    
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
    
    [self.view addSubview:self.loginView];
    [self.loginView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [[NSNotificationCenter defaultCenter] addObserverForName:ProductEntityFavoriteDidChangeNotification  object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf.tableView.header beginRefreshing];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView reloadRowsAtIndexPaths:@[self.tableView.indexPathForSelectedRow] withRowAnimation:UITableViewRowAnimationNone];
    }
    self.loginView.hidden = [JBJAccount currentAccount];
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
    FavoriteSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FavoriteSubjectCell class]) forIndexPath:indexPath];
    cell.viewModel = [[FavoriteSubjectCellViewModel alloc] initWithProduct:self.viewModel.products[indexPath.row]];
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
