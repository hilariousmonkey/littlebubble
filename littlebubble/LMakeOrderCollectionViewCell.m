//
//  LMakeOrderCollectionViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/20.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LMakeOrderCollectionViewCell.h"

@implementation LMakeOrderCollectionViewCell{
    UIImageView* cellImg;
    UILabel* imgLab,*priceLab;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        cellImg = [[UIImageView alloc] init];
        [self addSubview:cellImg];
        imgLab = [[UILabel alloc] init];
        [self addSubview:imgLab];
        imgLab.font = FONT(14);
        imgLab.textAlignment = NSTextAlignmentCenter;
        priceLab = [[UILabel alloc]init];
        [self addSubview:priceLab];
        priceLab.font = FONT(14);
        priceLab.textAlignment = NSTextAlignmentCenter;
        priceLab.textColor = [UIColor redColor];
        [cellImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.sizeOffset(CGSizeMake(80, 80));
            make.top.equalTo(self);
        }];
        cellImg.contentMode = UIViewContentModeScaleAspectFit;
        [imgLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cellImg.mas_bottom);
            make.size.sizeOffset(CGSizeMake(120, 20));
            make.centerX.equalTo(self);
        }];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.sizeOffset(CGSizeMake(120, 20));
            make.top.equalTo(imgLab.mas_bottom).offset(5);
        }];
    }
    return self;
}

-(void)initData:(NSDictionary*)initData{
    if (initData) {
        cellImg.image = [UIImage imageNamed:initData[@"imgName"]];
        imgLab.text = initData[@"imgTitle"];
        priceLab.text = [NSString stringWithFormat:@"¥ %@",initData[@"imgPrice"]];
        
    }
}


@end
