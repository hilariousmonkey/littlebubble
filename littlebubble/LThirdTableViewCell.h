//
//  LThirdTableViewCell.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface LThirdTableViewCell : UITableViewCell <AMapNearbySearchManagerDelegate,AMapSearchDelegate,MAMapViewDelegate>
@end
