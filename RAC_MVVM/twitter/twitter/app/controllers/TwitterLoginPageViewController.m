//
//  TwitterLoginPageViewController.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "TwitterLoginPageViewController.h"
#import "TwitterLoginViewModel.h"
@interface TwitterLoginPageViewController ()
@property(nonatomic,strong)TwitterLoginViewModel * viewModel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation TwitterLoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
