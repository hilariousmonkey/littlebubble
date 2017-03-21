//
//  LUserInfoTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/10.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LUserInfoTableViewCell.h"

@implementation LUserInfoTableViewCell{
    UIImageView* userIcon;
    
}
@synthesize userIcon;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initUI];
    return self;
}
-(void)initUI{
    userIcon = [[UIImageView alloc] init];
    [self addSubview:userIcon];
    userIcon.layer.cornerRadius = 24;
    userIcon.layer.masksToBounds = YES;
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(50, 50));
    }];
}
-(void)initData:(NSDictionary*)initData{
    if (initData) {
        userIcon.image = [UIImage imageNamed:initData[@"userIcon"]] ;
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
