//
//  LLoaddingViewController.h
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/9/12.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangeRoot)();
@interface LLoaddingViewController : UIViewController
@property (nonatomic,strong) ChangeRoot changeRoot;//回调block
@property (nonatomic,strong) NSString *imgUrlString;

-(instancetype)initWithString:(NSString*)string;

@end
