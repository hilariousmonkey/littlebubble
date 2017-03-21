//
//  LHeaderCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/5.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LHeaderCell.h"

@implementation LHeaderCell{
    UIImageView* userIcon;
    
}
@synthesize userIcon;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initUI];
    return self;
}
-(void)initUI{
    self.backgroundColor = MAINCOLOR;
    userIcon = [[UIImageView alloc] init];
    [self addSubview:userIcon];
    userIcon.layer.cornerRadius = 30;
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.sizeOffset(CGSizeMake(100, 100));
    }];
    userIcon.layer.cornerRadius = 50;
    userIcon.layer.masksToBounds = YES;
    userIcon.image = [UIImage imageNamed:@"QQ20170103-151146.png"];
  
    _loginOrNickName = [[UILabel alloc]init];
    [self addSubview:_loginOrNickName];
    [_loginOrNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userIcon);
        make.top.equalTo(userIcon.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(100, 20));
        
    }];
    _loginOrNickName.font = FONT(14);
    _loginOrNickName.textColor = [UIColor whiteColor];
    _loginOrNickName.text = @"登录/注册";
    _loginOrNickName.textAlignment = NSTextAlignmentCenter;

    _selfDescription = [[UILabel alloc]init];
    [self addSubview:_selfDescription];
    [_selfDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_loginOrNickName.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(150, 10));
    }];
    _selfDescription.textAlignment = NSTextAlignmentCenter;
    _selfDescription.font = FONT(12);
    _selfDescription.textColor = [UIColor whiteColor];
    _selfDescription.text = @"用心服务 用爱洗护";
   /**/
}
-(void)initData:(NSDictionary*)initData{
    if (initData) {
        
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
