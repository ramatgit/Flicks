//
//  AppDelegate.m
//  Flicks
//
//  Created by Rama Pillutla on 9/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *topRatedNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MoviesNavigationController"];
    ViewController *topRatedViewController = (ViewController *)[topRatedNavigationController topViewController];
    topRatedViewController.endPoint = @"top_rated";
    topRatedViewController.tabBarItem.title = @"Top Rated";
    topRatedViewController.tabBarItem.image = [UIImage imageNamed:@"heart"];

    
    UINavigationController *nowPlayingNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MoviesNavigationController"];
    ViewController *nowPlayingController = (ViewController *)[nowPlayingNavigationController topViewController];
    nowPlayingController.endPoint = @"now_playing";
    nowPlayingController.tabBarItem.title = @"Now Playing";
    nowPlayingController.tabBarItem.image = [UIImage imageNamed:@"star"];

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[topRatedNavigationController, nowPlayingNavigationController];
    
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabBarControllerForTitle = (UITabBarController *)self.window.rootViewController;
    
    [[tabBarControllerForTitle.viewControllers objectAtIndex:0] setTitle:@"Top Rated"];
    [[tabBarControllerForTitle.viewControllers objectAtIndex:1] setTitle:@"Now Playing"];

    
    [[[tabBarControllerForTitle.viewControllers objectAtIndex:0] tabBarItem] setImage:[[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
    [[[tabBarControllerForTitle.viewControllers objectAtIndex:1] tabBarItem] setImage:[[UIImage imageNamed:@"star"] imageWithRenderingMode:UIImageRenderingModeAutomatic]];


    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
