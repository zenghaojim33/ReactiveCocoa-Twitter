//
//  TimelineViewController.m
//  twitter
//
//  Created by Anson on 15/7/10.
//
//

#import "TimelineViewController.h"
#import "TimelineViewModel.h"
#import "TweetCell.h"
@interface TimelineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TimelineTableView;
@property(nonatomic,strong)TimelineViewModel * viewModel;
@end

#define kCellIdentifier @"Cell"

@implementation TimelineViewController

-(TimelineViewModel *)viewModel{
    
    if (!_viewModel){
        _viewModel = [[TimelineViewModel alloc]init];
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
    // Do any additional setup after loading the view from its nib.
    
    self.TimelineTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self.viewModel loadTweet];
        

        
    }];
    
    [self.TimelineTableView.header beginRefreshing];

    self.TimelineTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self.viewModel loadMore];
        
    }];
    

    @weakify(self)
    
    [[RACObserve(self.viewModel, tweet) filter:^BOOL(NSMutableArray *array) {
        @strongify(self)
        return !!self.viewModel.tweet;
    }]

     subscribeNext:^(id x) {
        @strongify(self)
        [self.TimelineTableView reloadData];
        [self.TimelineTableView.header endRefreshing];
        [self.TimelineTableView.footer endRefreshing];
     }];
    

    
    
}


#pragma mark ----UITableViewDelegate------


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TweetCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell configureCellWithTweet:self.viewModel.tweet[indexPath.row]];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.viewModel.tweet.count;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
