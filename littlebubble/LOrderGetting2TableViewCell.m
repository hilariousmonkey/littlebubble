//
//  LOrderGetting2TableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/3/1.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LOrderGetting2TableViewCell.h"

@implementation LOrderGetting2TableViewCell{
    UIImageView* cellIcon;
    UILabel* cellLab;
}
@synthesize cellLab;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    cellIcon = [[UIImageView alloc]init];
    [self addSubview:cellIcon];
    [cellIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(17, 17));
    }];
    cellLab = [[UILabel alloc]init];
    [self addSubview:cellLab];
    [cellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(cellIcon.mas_right).offset(5);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 20));
    }];
    cellLab.font = FONT(14);
}

-(void)initData:(NSDictionary*)initData{
    if (initData) {
        cellIcon.image = [UIImage imageNamed:initData[@"cellIcon"]];
        cellLab.text = initData[@"cellLab"];
        
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
