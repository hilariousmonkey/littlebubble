//
//  LAddressTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/15.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LAddressTableViewCell.h"

@implementation LAddressTableViewCell{
    UILabel* userName ,*userPhone ,*userAddress;
    UIButton* editBtn;
    UIView* verLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier trans:(void(^)(NSString *))d trans1:(void(^)(NSString *))d1{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.transData = d;
        self.transData1 = d1;
        [self initUI];
    }
    return self;
}
-(void)initUI{
    userName = [[UILabel alloc] init];
    [self addSubview:userName];
    userName.font = FONT(12);
    
    userPhone = [[UILabel alloc] init];
    [self addSubview:userPhone];
    userPhone.font = FONT(12);

    userAddress = [[UILabel alloc] init];
    [self addSubview:userAddress];
    userAddress.font = FONT(12);

    editBtn = [[UIButton alloc] init];
    [self addSubview:editBtn];
    [editBtn setBackgroundImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editingCell) forControlEvents:UIControlEventTouchDown];
    
    verLine = [[UIView alloc] init];
    [self addSubview:verLine];
    
    verLine.backgroundColor = [UIColor grayColor];
    //Masonry
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(5);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    
    [userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-50);
        make.top.equalTo(self).offset(5);
        make.size.sizeOffset(CGSizeMake(120, 20));
    }];
    
    [userAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(userName).offset(20);
        make.size.sizeOffset(CGSizeMake(200, 20));
    }];
    
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(userPhone).offset(10);
        make.centerY.equalTo(self) ;
        make.size.sizeOffset(CGSizeMake(1, 28));
    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verLine).offset(10);
        make.top.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(22, 25));
    }];
}
-(void)editingCell{
    self.transData(@"");
}
-(void)initData:(NSDictionary*)initData{
    if (initData) {
        userName.text = initData[@"userName"];
        
        userPhone.text = initData[@"userPhone"];
        userAddress.text = initData[@"userAddress"];
        self.cellId = initData[@"id"];
        self.lat = [initData[@"lat"] floatValue];
        self.lng = [initData[@"lng"] floatValue];
        self.ifDefaultLocation = [initData[@"ifDefault"] isEqualToString:@"1"]?YES:NO;
        
        self.userName =  initData[@"userName"];
        self.userAddress = initData[@"userAddress"];
        self.userPhone = initData[@"userPhone"];

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
