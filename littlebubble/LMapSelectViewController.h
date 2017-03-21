//
//  LMapSelectViewController.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/23.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMapSelectViewController : UIViewController
@property (nonatomic,strong) void (^trans) (NSDictionary*);
-(instancetype)init :(void (^) (NSDictionary* a)) transData;
@end
