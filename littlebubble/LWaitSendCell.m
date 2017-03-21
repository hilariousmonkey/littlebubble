//
//  LWaitSendCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/16.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LWaitSendCell.h"

@implementation LWaitSendCell{
    UIImageView* cellIcon,*cellImg;
    UILabel *cellName,*orderNo;
    UILabel *orderState,*orderDate;
    UIButton *remindBtn;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    cellIcon = [[UIImageView alloc]init];
    cellImg = [[UIImageView alloc]init];
    cellName = [[UILabel alloc]init];
    orderNo = [[UILabel alloc]init];
    orderState = [[UILabel alloc]init];
    orderDate = [[UILabel alloc]init];
    remindBtn = [[UIButton alloc]init];
    orderState.textColor = RGB(254, 121, 69);
    [self addSubview:cellIcon];
    [self addSubview:cellImg];
    [self addSubview:cellName];
    [self addSubview:orderNo];
    [self addSubview:orderState];
    [self addSubview:orderDate];
    [self addSubview:remindBtn];
    
    [cellIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(12, 13));
    }];
    [cellName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellIcon.mas_right).offset(10);
        make.centerY.equalTo(cellIcon);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    cellName.font = FONT(12);
    
    [cellImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(45, 45));
    }];
    
    cellImg.layer.cornerRadius = 10;
    
    [orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellImg.mas_right).offset(10);
        make.top.equalTo(cellIcon).offset(10);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    orderNo.font = FONT(12);
    [orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(cellIcon);
        make.size.sizeOffset(CGSizeMake(140, 20));
    }];
    
    orderState.font = FONT(14);
    [orderDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(cellImg);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    orderDate.font = FONT(12);
    [remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(orderDate);
        make.bottom.equalTo(self);
        make.size.sizeOffset(CGSizeMake(80, 18));
    }];
    [remindBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    remindBtn.titleLabel.font = FONT(14);
    [remindBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    remindBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    remindBtn.layer.borderWidth = 1;
    UIView* horLine = [[UIView alloc]init];
    horLine.backgroundColor = RGB(221, 221, 221);
    [self addSubview:horLine];
    [horLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-1);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 1));
        make.left.equalTo(self);
    }];

}
-(void)initData:(NSDictionary*)initData{
    if (initData) {
        cellIcon.image = [UIImage imageNamed:initData[@"cellIcon"]];
        //cellImg.image = [UIImage imageNamed:initData[@"cellImg"]];
        [cellImg sd_setImageWithURL:initData[@"cellImg"] placeholderImage:[UIImage imageNamed:initData[@"cellImg"]]];
        cellName.text = initData[@"cellName"];
        orderDate.text =  initData[@"orderDate"];
        orderNo.text =  initData[@"orderNo"];
        orderState.text =  initData[@"orderState"];
    }
}
@end
