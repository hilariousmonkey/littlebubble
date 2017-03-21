//
//  LFirstTableViewCell.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface LFirstTableViewCell : UITableViewCell <SDCycleScrollViewDelegate>
@property (strong,nonatomic) UIScrollView* scrollView;
@property (strong,nonatomic) UIPageControl* pageControl;

@end
