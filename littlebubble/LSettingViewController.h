//
//  LSettingViewController.h
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/8/10.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLoginViewController.h"

@interface LSettingViewController : UIViewController
@property (strong, nonatomic)UIView *footerView;
@property (strong,nonatomic) void (^popLoginVc) (NSInteger);
-(LSettingViewController*)init :(void(^) (NSInteger))logView;
-(void)clearCacheSuccess;
@end
