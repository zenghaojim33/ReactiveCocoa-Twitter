//
//  ProductDetailViewController.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation ProductDetailViewController

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
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.viewModel.link]]];
    __weak __typeof(&*self)weakSelf = self;
    [self.viewModel.product fetchMoreInfo:^(NSError *error) {
        if (!error) {
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(favoriteToggle:)];
            weakSelf.navigationItem.rightBarButtonItem = barButtonItem;
            [weakSelf updateFavoriteUI];
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFavoriteUI{
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:(self.viewModel.isFavorite) ? @"icon_favorited" : @"icon_favorite"];
}

- (void)favoriteToggle:(id)sender{
    __weak __typeof(&*self)weakSelf = self;
    [self.viewModel.product requestFavoriteToggle:^{
        [weakSelf updateFavoriteUI];
    }];
    [self updateFavoriteUI];
}

@end
