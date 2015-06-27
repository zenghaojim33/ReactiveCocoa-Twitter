//
//  TableLoadMorer.m
//  jibaojie-mvvm
//
//  Created by Ron on 16/6/15.
//
//

#import "TableLoadMorer.h"



@interface TableLoadMorer()<UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIActivityIndicatorView *loadMoreIndicatorView;
@property (nonatomic, weak) UILabel *tipsLabel;
@property (nonatomic, copy) voidBlock loadmoreAction;
@property (nonatomic, assign) BOOL isObserving;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) CGFloat footHeight;

@end

@implementation TableLoadMorer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (void)setUpWithTableView:(UITableView*)tableView withHeight:(CGFloat)height withAction:(void (^)(void))actionHandler
{
    TableLoadMorer *footView = (TableLoadMorer*)tableView.tableFooterView;
    
    if ([footView isKindOfClass:[TableLoadMorer class]] && footView.loadmoreAction) {
        return;
    }
        
    footView = [[TableLoadMorer alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    footView.tableView = tableView;
    footView.backgroundColor = [UIColor clearColor];
    footView.footHeight = height;
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.center = CGPointMake(footView.frame.size.width/2, footView.frame.size.height/2);
    [footView addSubview:activityIndicatorView];
    footView.loadMoreIndicatorView = activityIndicatorView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:footView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
//    label.text = @"更多...";
    label.hidden = YES;
    [footView addSubview:label];
    footView.tipsLabel = label;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = footView.bounds;
    [button addTarget:footView action:@selector(onClickLoadMore:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    footView.loadmoreAction = actionHandler;
    footView.enable = YES;
    tableView.tableFooterView = footView;
}

- (void)cleanUp{
    [self setEnable:NO];
    self.tableView.tableFooterView = nil;
}

- (void)stopAnimation
{
    if (self.isLoading) {
        self.tipsLabel.hidden = NO;
        [self.loadMoreIndicatorView stopAnimating];
        self.isLoading = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.loadMoreIndicatorView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    if (!_enable) {
        if (self.isObserving) {
            [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
            [self.tableView removeObserver:self forKeyPath:@"contentSize"];
            self.isObserving = NO;
        }
        
        [self stopAnimation];
        self.tipsLabel.hidden = YES;
        self.userInteractionEnabled = NO;
        UIView *temp = self.tableView.tableFooterView;
        CGRect rectOfTempView = temp.frame;
        rectOfTempView.size.height = 0;
        temp.frame = rectOfTempView;
        self.tableView.tableFooterView = nil;
        self.tableView.tableFooterView = temp;
    }
    else {
        if (!self.isObserving) {
            [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            self.isObserving = YES;
        }
        self.tipsLabel.hidden = NO;
        self.userInteractionEnabled = YES;
        UIView *temp = self.tableView.tableFooterView;
        CGRect rectOfTempView = temp.frame;
        rectOfTempView.size.height = self.footHeight;
        temp.frame = rectOfTempView;
        self.tableView.tableFooterView = nil;
        self.tableView.tableFooterView = temp;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint newContentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (newContentOffset.y == 0 || self.tableView.contentSize.height < self.tableView.frame.size.height) {
            return;
        }
        
        if (newContentOffset.y >= (MAX(self.tableView.contentSize.height , self.tableView.frame.size.height) - self.tableView.frame.size.height)) {
            
            if (!self.isLoading && self.loadmoreAction) {
                
                [self onClickLoadMore:nil];
                
            }
            
        }
    }
    else if([keyPath isEqualToString:@"contentSize"]){
        
        CGSize newContentSize = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
        
        if (newContentSize.height > self.tableView.frame.size.height) {
            if (self.enable) {
                self.tipsLabel.hidden = NO;
            }
        }
        else {
            self.tipsLabel.hidden = YES;
        }
        
    }
}

#pragma mark -
#pragma mark -------------------- User Action ---------------------
- (void)onClickLoadMore:(id)sender{
    if (!self.isLoading) {
        if (self.loadmoreAction) {
            self.loadmoreAction();
        }
        self.isLoading = YES;
        self.tipsLabel.hidden = YES;
        [self.loadMoreIndicatorView startAnimating];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
