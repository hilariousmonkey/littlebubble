//
//  LSecondTableCollectionViewCell.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSecondTableCollectionViewCell : UICollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame  initDic:(NSDictionary*)initData;
- (void)setImageName:(NSDictionary*)initData;
@end