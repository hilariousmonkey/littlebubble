//
//  AppDelegate.m
//  littlebubble
//
//  Created by  罗海峰 on 2016/12/16.
//  Copyright © 2016年  罗海峰. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarControllerConfig.h"
#import "ViewController.h"
#import "LLoaddingViewController.h"
#import "LPublicData.h"
@interface AppDelegate ()<UITabBarControllerDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ViewController alloc] init];
    
    LPublicData* pubData = [LPublicData sharedUserInfo];
    [pubData loadUserInfoFromSandBox];  //从沙盒加载数据
    
    LLoaddingViewController* loadVc = [[LLoaddingViewController alloc] init];  //启动页
    [self.window setRootViewController:loadVc];
    // loadVc.changeRoot = void(^ChangeRoot)(){
    
    //回调
    loadVc.changeRoot = ^{
        CYLTabBarControllerConfig * TabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
        [TabBarControllerConfig customizeTabBarAppearance:TabBarControllerConfig.tabBarController];
        TabBarControllerConfig.tabBarController.delegate = self;
        [self.window setRootViewController:TabBarControllerConfig.tabBarController];
    };
    [self.window makeKeyAndVisible];
    [self customizeInterface];
    return YES;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([LPublicData sharedUserInfo].userId == nil && [viewController isEqual:tabBarController.viewControllers[1]]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

        return NO;
    }else
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)customizeInterface {
    [self setUpNavigationBarAppearance];
}

/**
 *  设置navigationBar样式
 */

- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
