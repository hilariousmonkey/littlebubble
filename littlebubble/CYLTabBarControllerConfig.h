//
//  CYLTabBarControllerConfig.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/3.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CYLTabBarController.h>
@interface CYLTabBarControllerConfig : NSObject<UITabBarDelegate>
@property (nonatomic, retain) CYLTabBarController * tabBarController;
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController;
@end
