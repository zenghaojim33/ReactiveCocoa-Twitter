//
//  AppDelegate.m
//  twitter
//
//  Created by Anson on 15/7/9.
//
//

#import "AppDelegate.h"
#import <FLEXManager.h>
#import <Reachability.h>
#import "AF2OAuth1Client.h"
#import "TwitterLoginPageViewController.h"
@interface AppDelegate()
@property(nonatomic,strong) AF2OAuth1Client * twitterClient;

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self addFlexTapGestureIfNeed];
    [self startNotifierNetWork];
    [self showBuildsNumber];
    
//    self.twitterClient = [[AF2OAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"4oFCF0AjP4PQDUaCh5RQ" secret:@"NxAihESVsdUXSUxtHrml2VBHA0xKofYKmmGS01KaSs"];
//    
//    [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"/oauth/request_token" userAuthorizationPath:@"/oauth/authorize" callbackURL:[NSURL URLWithString:@"af-twitter://success"] accessTokenPath:@"/oauth/access_token" accessMethod:@"POST" scope:nil success:^(AF2OAuth1Token *accessToken, id responseObject) {
//        NSMutableURLRequest *request = [self.twitterClient requestWithMethod:@"GET" path:@"statuses/user_timeline.json" parameters:nil];
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"Success: %@", responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", [error localizedDescription]);
//        }];
//        [manager.operationQueue addOperation:operation];
//    } failure:^(NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    
    TwitterLoginPageViewController * vc = [[UIStoryboard storyboardWithName:@"TwitterLoginPage" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"login"];
    
    self.window.rootViewController = vc;
    
    
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
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


@end