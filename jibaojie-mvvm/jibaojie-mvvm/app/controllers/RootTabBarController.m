//
//  RootTabBarController.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeViewController = [HomeViewController create];
    FavoriteViewController *favViewController = [FavoriteViewController create];
    SettingViewController *settingViewControler = [SettingViewController create];
    GGNavigationController *homeNav = [[GGNavigationController alloc] initWithRootViewController:homeViewController];
    GGNavigationController *favNav = [[GGNavigationController alloc] initWithRootViewController:favViewController];
    GGNavigationController *setNav = [[GGNavigationController alloc] initWithRootViewController:settingViewControler];
    self.viewControllers = @[homeNav,favNav,setNav];
    
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    favNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    setNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    
    
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
