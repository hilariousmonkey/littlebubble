//
//  LSecondTableCollectionViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LSecondTableCollectionViewCell.h"

@implementation LSecondTableCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame  initDic:(NSDictionary*)initData
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImageName:initData];
    }
    return self;
}

- (void)setImageName:(NSDictionary*)initData
{
    UILabel* lab = [[UILabel alloc]init];
    [self addSubview:lab];
    lab.font = FONT(12);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = initData[@"labText"];

    //图片
    UIImageView* img = [[UIImageView alloc]init];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    img.image = [UIImage imageNamed:initData[@"imageName"]];
    
    //标签
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.size.sizeOffset(CGSizeMake(self.frame.size.width, 20));
    }];
    
}

@end
