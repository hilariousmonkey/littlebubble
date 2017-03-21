//
//  LAboutUsViewController.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/8/10.
//  Copyright © 2016年 Aivard. All rights reserved.
//


#import "LAboutUsViewController.h"
#import <Masonry.h>
#import "UIImage+color.h"
#define versionNo @"当前版本: 1.0"
@interface LAboutUsViewController ()<UIGestureRecognizerDelegate>
@property(strong,nonatomic)UIImageView* icon;
@property(strong,nonatomic)UILabel* version;
@property(strong,nonatomic)UITextView* introduce;
@end

@implementation LAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* tempBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10  , 17)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(fanHui) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem* goBack = [[UIBarButtonItem alloc]initWithCustomView:tempBtn];
    self.navigationItem.leftBarButtonItem = goBack;
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = COLOR(255, 255, 255, 1);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MAINCOLOR] forBarMetrics:(UIBarMetricsDefault)];
    
    _icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"klcon"]];
    [self.view addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.centerX.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(60,60));
    }];
    _version = [[UILabel alloc]init];
    _version.text = versionNo;
    [self.view addSubview:_version];
    [_version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).offset(5);
        make.centerX.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(100,40));
    }];
    _version.textColor = [UIColor grayColor];
    _version.font = FONT(13);
    _version.textAlignment = NSTextAlignmentCenter;
    _introduce = [[UITextView alloc]init];
    [self.view addSubview:_introduce];
    [_introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_version.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH-10,300));
    }];
    _introduce.font = FONT(13);
    _introduce.text = @"测测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试试";
    _introduce.backgroundColor = [UIColor clearColor]; 
}
-(void)fanHui{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
