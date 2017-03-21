//
//  LDounbleButtonTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/8.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LDounbleButtonTableViewCell.h"

@implementation LDounbleButtonTableViewCell{
    UIButton* leftBtn,*rightBtn;
    UIImageView* leftBtnView,*rightBtnView;
    UILabel* leftLab,*rightLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initUI];
    return self;
}
-(void)initUI{
    leftBtn = [[UIButton alloc] init];
    [self addSubview:leftBtn];
    
    rightBtn = [[UIButton alloc] init];
    [self addSubview:rightBtn];
    
    leftLab = [[UILabel alloc]init];
    [self addSubview:leftLab];
    leftLab.font = FONT(14);
    
    rightLab = [[UILabel alloc]init];
    [self addSubview:rightLab];
    rightLab.font = FONT(14);
    
    leftBtnView = [[UIImageView alloc] init];
    [leftBtn addSubview:leftBtnView];
  
    rightBtnView = [[UIImageView alloc] init];
    [rightBtn addSubview:rightBtnView];
    
    UIView* verLine = [[UIView alloc] init];
    verLine.backgroundColor = RGB(221, 221, 221);
    [self addSubview:verLine];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.size.sizeOffset(CGSizeMake(self.frame.size.width/2-1, self.frame.size.height));
        make.centerY.equalTo(self);
    }];
    
    [leftBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn).offset(15);
        make.centerY.equalTo(leftBtn);
        make.size.sizeOffset(CGSizeMake(20, 21));
    }];
    
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.sizeOffset(CGSizeMake(1, self.frame.size.height));
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verLine);
        make.size.sizeOffset(CGSizeMake(self.frame.size.width/2, self.frame.size.height));
    }];
    [rightBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightBtn).offset(15);
        make.centerY.equalTo(rightBtn);
        make.size.sizeOffset(CGSizeMake(20, 21));
    }];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtnView.mas_right).offset(15);
        make.centerY.equalTo(rightBtn);
        make.size.sizeOffset(CGSizeMake(70, 40));
    }];
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightBtnView.mas_right).offset(15);
        make.centerY.equalTo(rightBtn);
        make.size.sizeOffset(CGSizeMake(70, 40));
    }];
}
-(void)initData:(NSDictionary*)initData{
    if (initData) {
        leftBtnView.image = [UIImage imageNamed:initData[@"leftBtnView"]];
        rightBtnView.image = [UIImage imageNamed:initData[@"rightBtnView"]];
        leftLab.text = initData[@"leftTitle"];
        rightLab.text = initData[@"rightTitle"];
//
//        [leftBtn setTitle:initData[@"leftTitle"] forState:UIControlStateNormal];
//        [rightBtn setTitle:initData[@"rightTitle"] forState:UIControlStateNormal];
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
