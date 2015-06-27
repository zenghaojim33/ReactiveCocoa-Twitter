//
//  SettingViewController.m
//  jibaojie-mvvm
//
//  Created by Ron on 17/6/15.
//
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (nonatomic, weak) IBOutlet UIButton *logoutButton;

@end

@implementation SettingViewController

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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI{
    self.logoutButton.hidden = ![JBJAccount currentAccount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark -------------------- User Action ---------------------
- (IBAction)onClickLogout:(id)sender {
    [JBJAccount logout];
    [self updateUI];
}

@end
