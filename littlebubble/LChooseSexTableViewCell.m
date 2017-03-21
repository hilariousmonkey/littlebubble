//
//  LChooseSexTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/3/14.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LChooseSexTableViewCell.h"

@implementation LChooseSexTableViewCell{
    UIButton* leftView,*rightView;
    UIButton *currentSelct; //当前选择序号
    UILabel *leftLab,*rightLab;
    NSString* userSelectSex;
}


-(void)initUI{
    currentSelct = [UIButton new];
    UILabel* lab = [[UILabel alloc]init];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(100, self.frame.size.height));
    }];
    lab.text = @"称谓";
    lab.font = FONT(14);
    
    leftView  = [[UIButton alloc]init];
    leftView.tag = 100;
    [self addSubview:leftView];
    [leftView setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab.mas_right);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(20, 20));
    }];
    
    leftLab.layer.cornerRadius = 5;
    leftLab = [[UILabel alloc]init];
    [self addSubview:leftLab];
    leftLab.text = @"先生";
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.mas_right);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(60, 20));
    }];

    leftLab.font = FONT(14);
    rightView  = [[UIButton alloc]init];
    rightView.tag = 101;
    [self addSubview:rightView];
    [rightView setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLab.mas_right);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(20, 20));
    }];
    
    rightLab = [[UILabel alloc]init];
    [self addSubview:rightLab];
    rightLab.text = @"女士";
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_right);
        make.centerY.equalTo(self);
        make.size.sizeOffset(CGSizeMake(60, 20));
    }];
    rightLab.font = FONT(14);
    [leftView addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchDown];
    [rightView addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchDown];
    
}
-(void)buttonSelect:(UIResponder*)btn{
    UIButton* tempBtn = (UIButton*)btn;
    if (currentSelct != tempBtn) {
        if (tempBtn.tag == 100) {
            self.userSelecSex = 0 ;
        } else {
            self.userSelecSex = 1;
        }
        [tempBtn setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [currentSelct setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        currentSelct = tempBtn;
        
    }else{
        return;
    }
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
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
