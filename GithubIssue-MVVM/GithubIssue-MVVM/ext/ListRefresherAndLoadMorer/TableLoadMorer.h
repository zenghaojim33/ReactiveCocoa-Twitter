//
//  TableLoadMorer.h
//  GithubIssue-MVVM
//
//  Created by Ron on 11/6/15.
//
//


@interface TableLoadMorer : UIView

@property (nonatomic, assign) BOOL enable;

+ (void)setUpWithTableView:(UITableView*)tableView withHeight:(CGFloat)height withAction:(void (^)(void))actionHandler;

- (void)cleanUp;

- (void)stopAnimation;

@end

@interface UITableView(More)

- (TableLoadMorer*)tableLoadMorer;

@end

@implementation UITableView(More)

- (TableLoadMorer*)tableLoadMorer
{
    return (TableLoadMorer*)self.tableFooterView;
}

@end