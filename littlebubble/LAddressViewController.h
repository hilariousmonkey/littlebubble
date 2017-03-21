//
//  LAddressViewController.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/12.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LAddressViewController : UIViewController
@property(strong,nonatomic) void (^trans)(NSDictionary*);
-(instancetype)init:(void(^)(NSDictionary*))a;
@end
