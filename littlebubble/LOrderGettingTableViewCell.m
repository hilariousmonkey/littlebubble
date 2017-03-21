//
//  LOrderGettingTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/28.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LOrderGettingTableViewCell.h"

@implementation LOrderGettingTableViewCell{
    UIImageView* cellImg,*rainbowLine;
    UILabel* gustName,*gustPhone,*gustAddress;
}
@synthesize  gustName,gustPhone,gustAddress;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    cellImg = [[UIImageView alloc]init];
    [self addSubview:cellImg];
    [cellImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(17, 23));
    }];
    cellImg.image = [UIImage imageNamed:@"定位.png"];
    gustName = [[UILabel alloc]init];
    [self addSubview:gustName];
    [gustName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(cellImg.mas_right).offset(5);
        make.size.sizeOffset(CGSizeMake(120, 20));
    }];
    gustPhone = [[UILabel alloc]init];
    [self addSubview:gustPhone];
    [gustPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gustName);
        make.right.equalTo(self);
        make.size.sizeOffset(CGSizeMake(120, 20));
    }];
    gustAddress = [[UILabel alloc]init];
    [self addSubview:gustAddress];
    [gustAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cellImg);
        make.left.equalTo(gustName);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 20));
    }];
    
    gustName.font = FONT(14);
    gustPhone.font = FONT(14);
    gustAddress.font = FONT(14);
    rainbowLine = [[UIImageView alloc]init];
    [self addSubview:rainbowLine];
    [rainbowLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 2));
        make.bottom.equalTo(self);
        make.left.equalTo(self);
    }];
    rainbowLine.image = [UIImage imageNamed:@"彩条.png"];
}

-(void)initData:(NSDictionary*)initData{
    if (initData) {
        gustName.text = initData[@"gustName"];
        gustPhone.text = initData[@"gustPhone"];
        gustAddress.text = initData[@"gustAddress"];
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
