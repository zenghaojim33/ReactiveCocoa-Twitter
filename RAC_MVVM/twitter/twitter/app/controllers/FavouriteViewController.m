//
//  FavouriteViewController.m
//  twitter
//
//  Created by Anson on 15/7/11.
//
//

#import "FavouriteViewController.h"
#import "FavouriteViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import "FavouriteCell.h"
#import "TweetCellViewModel.h"
@interface FavouriteViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *FavouriteListTableView;
@property(nonatomic,strong)FavouriteViewModel * viewModel;
@end

#define kCellIdentifier @"Cell"

@implementation FavouriteViewController


-(FavouriteViewModel *)viewModel{
    if (!_viewModel){
    
        _viewModel = [[FavouriteViewModel alloc]init];
        
        
    }
    
    return _viewModel;
    
}



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
    // Do any additional setup after loading the view.
    
    self.FavouriteListTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.viewModel loadFavourite];
        
        
        
    }];
    
    [self.FavouriteListTableView.header beginRefreshing];
    
    self.FavouriteListTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self.viewModel loadMore];
        
    }];
    
    @weakify(self)
    
    [[RACObserve(self.viewModel, cellViewModels) filter:^BOOL(NSMutableArray *array) {
        @strongify(self)
        return !!self.viewModel.cellViewModels;
    }]
     
     subscribeNext:^(id x) {
         @strongify(self)
         [self.FavouriteListTableView reloadData];
         [self.FavouriteListTableView.header endRefreshing];
         [self.FavouriteListTableView.footer endRefreshing];
     }];
    
    
    
    
}

#pragma mark ------UITableViewDelegate -------


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavouriteCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    [cell bindViewModel:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        TweetCellViewModel * viewModel = ((FavouriteCell *)[tableView cellForRowAtIndexPath:indexPath]).viewModel;
        
        [viewModel.unFavoriteCommand execute:nil];
        [self.viewModel.cellViewModels removeObjectAtIndex:indexPath.row];
        [self.FavouriteListTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
