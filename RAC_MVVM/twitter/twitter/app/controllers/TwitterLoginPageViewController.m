//
//  TwitterLoginPageViewController.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "TwitterLoginPageViewController.h"
#import "TwitterLoginViewModel.h"
#import "TimelineViewController.h"
@interface TwitterLoginPageViewController ()
@property(nonatomic,strong)TwitterLoginViewModel * viewModel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation TwitterLoginPageViewController


-(TwitterLoginViewModel *)viewModel{
    if (!_viewModel){
        _viewModel = [[TwitterLoginViewModel alloc]init];
        
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self)
    
    self.loginButton.rac_command.allowsConcurrentExecution = NO;
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [[self.viewModel loginSignal] subscribeNext:^(NSNumber * isLogin) {
            if ([isLogin isEqualToNumber:@(YES)]){
                DLog(@"Login Success");
                UITabBarController * tab = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTab"];
                [self presentViewController:tab animated:YES completion:nil];
                
            }
        }];
        
        
    } error:^(NSError *error) {
        
        DLog(@"%@",error);
    
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
