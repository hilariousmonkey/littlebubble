//
//  CYLTabBarControllerConfig.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/3.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "CYLTabBarControllerConfig.h"
#import "LMainViewController.h"
#import "LOrderViewController.h"
#import "LMineViewController.h"

@implementation CYLTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        LMainViewController * firstViewController = [[LMainViewController alloc] init];
        UIViewController * firstNavigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
        
        LOrderViewController * secondViewController = [[LOrderViewController alloc] init];
        UIViewController * secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        
        LMineViewController * thirdViewController = [[LMineViewController alloc] init];
        UIViewController * thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
        
        NSArray * tabBarItemsAttributes = [self tabBarItemsAttributes];
        NSArray * viewControllers = @[firstNavigationController, secondNavigationController, thirdNavigationController];
        
        CYLTabBarController * tabBarController = [[CYLTabBarController alloc] init];
        tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
        tabBarController.viewControllers = viewControllers;
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
    
}

- (NSArray *)tabBarItemsAttributes {

    NSDictionary * tabBarItem1Attribute = @{
                                            CYLTabBarItemTitle : @"首页",
                                            CYLTabBarItemImage : @"首页未点击.png",
                                            CYLTabBarItemSelectedImage : @"首页.png"
                                            };
    NSDictionary * tabBarItem2Attribute = @{
                                            CYLTabBarItemTitle : @"订单",
                                            CYLTabBarItemImage : @"订单没选择.png",
                                            CYLTabBarItemSelectedImage : @"订单已选择.png"
                                            };
    NSDictionary * tabBarItem3Attribute = @{
                                            CYLTabBarItemTitle : @"我的",
                                            CYLTabBarItemImage : @"我的.png",
                                            CYLTabBarItemSelectedImage : @"我的已选择.png"
                                            };
    NSArray * tarBarItemsAttrbutes = @[tabBarItem1Attribute, tabBarItem2Attribute, tabBarItem3Attribute];
    return tarBarItemsAttrbutes;
    
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //     tabBarController.tabBarHeight = 80.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = MAINCOLOR;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

@end
