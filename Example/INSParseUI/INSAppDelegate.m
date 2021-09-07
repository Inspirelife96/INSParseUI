//
//  INSAppDelegate.m
//  INSParseUI
//
//  Created by inspirelife@hotmail.com on 06/24/2021.
//  Copyright (c) 2021 inspirelife@hotmail.com. All rights reserved.
//

#import "INSAppDelegate.h"

#import <Parse/Parse.h>

#import <INSParseUI-umbrella.h>

#import <SwiftTheme/SwiftTheme-umbrella.h>

@implementation INSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [ThemeManager setThemeWithPlistInMainBundle:@"ThemeDefault"];
    
    // 初始化Parse
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"oDzmpRypCHeD8K8bI8lD7yDpBGU1povw14h2dL9j";
        configuration.clientKey = @"";
        configuration.server = @"https://inspirelife2017.com/learnpaint2";
        configuration.networkRetryAttempts = 0;
        NSURLSessionConfiguration *URLSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionConfiguration.timeoutIntervalForRequest = 15.0f;
        configuration.URLSessionConfiguration = URLSessionConfiguration;
    }]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    INSLogInViewController *loginVM = [[INSLogInViewController alloc] init];
    
    INSFeedQueryViewModel *feedQueryVM = [[INSFeedQueryViewModel alloc] initQueryFeedWithOrderBy:@"createdAt"];
    
    INSQueryViewController *queryVC = [[INSQueryViewController alloc] initWithQueryVM:feedQueryVM];
    UINavigationController *queryNV = [[UINavigationController alloc] initWithRootViewController:queryVC];
    
    
    INSAddFeedViewController *addFeedVC = [[INSAddFeedViewController alloc] init];
    addFeedVC.addFeedVM = [[INSAddFeedViewModel alloc] init];
    UINavigationController *addFeedNV = [[UINavigationController alloc] initWithRootViewController:addFeedVC];
    
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    tabbarVC.viewControllers = @[loginVM, queryNV, addFeedNV];
    
    
    
    self.window.rootViewController = tabbarVC;

    [self.window makeKeyAndVisible];
    
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

@end
