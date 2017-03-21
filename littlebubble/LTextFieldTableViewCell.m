//
//  LTextFieldTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/3/14.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LTextFieldTableViewCell.h"

@implementation LTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)initUI{
    _cellTxt = [[UITextField alloc] init];
    [self addSubview:_cellTxt];
  
    _cellTxt.font = FONT(14);
    _cellTxt.textColor = [UIColor blackColor];
    
    _cellLab = [[UILabel alloc] init];
    [self addSubview:_cellLab];
    [_cellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.size.sizeOffset(CGSizeMake(100, self.frame.size.height));
    }];
    [_cellTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_cellLab.mas_right).offset(10);
        make.size.sizeOffset(CGSizeMake(200, self.frame.size.height));
    }];
    _cellLab.font = FONT(14);
    _cellLab.textColor = [UIColor blackColor];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initData:(NSDictionary*)initData{
    if (initData) {
        _cellLab.text =  initData[@"cellLab"];
        _cellTxt.placeholder =  initData[@"cellTxt"];
    }
}

@end
