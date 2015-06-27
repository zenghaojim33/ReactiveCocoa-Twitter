//
//  AppDelegate.m
//  jibaojie-mvvm
//
//  Created by Ron on 16/6/15.
//
//

#import "AppDelegate.h"
#import <FLEXManager.h>
#import <Reachability.h>
#import "RootTabBarController.h"
#import "AppDatabase.h"

@interface AppDelegate()


@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    AppDatabase *dadaBase = [[AppDatabase alloc] initWithMigrations];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[RootTabBarController alloc] init];
    [self addFlexTapGestureIfNeed];
    [self startNotifierNetWork];
    [self showBuildsNumber];
    [self initializeShareSDK];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark -------------------- About FLEX ---------------------
- (void)addFlexTapGestureIfNeed{
#ifdef DEBUG
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFlex:)];
    tapGR.numberOfTapsRequired = 2;
    tapGR.numberOfTouchesRequired = 2;
    [self.window addGestureRecognizer:tapGR];
#endif
}

- (void)didTapFlex:(UITapGestureRecognizer*)tapGR
{
    if (tapGR.state == UIGestureRecognizerStateRecognized) {
#if DEBUG
        [[FLEXManager sharedManager] showExplorer];
#endif
    }
}

- (void)showBuildsNumber{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    label.text = [NSString stringWithFormat:@"Builds %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    label.font = [UIFont systemFontOfSize:9];
    label.textAlignment = NSTextAlignmentCenter;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.window addSubview:label];
    });
    
}


#pragma mark -
#pragma mark -------------------- Reachability ---------------------
- (void)startNotifierNetWork
{
    [[Reachability reachabilityForLocalWiFi] startNotifier];
    [[NSNotificationCenter defaultCenter] addObserverForName:kReachabilityChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        Reachability *reachDetector = note.object;
        switch (reachDetector.currentReachabilityStatus) {
            case ReachableViaWiFi:
                NSLog(@"已连接上wifi");
                break;
            case ReachableViaWWAN:
                NSLog(@"正在使用蜂窝网络");
                break;
            case NotReachable:
                NSLog(@"网络已断开");
                break;
            default:
                break;
        }
    }];
    
}


#pragma mark -
#pragma mark -------------------- ShareSDK init ---------------------
- (void)initializeShareSDK
{
    [ShareSDK registerApp:@"6feccc26c7c"];

    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3161835861"
                               appSecret:@"1c6dbea4114e6f53e4c91454106a0484"
                             redirectUri:@"http://www.jibaojie.com"];
    
    
}


- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


@end