//
//  LThirdTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LThirdTableViewCell.h"
#import "LOrderGettingViewController.h"
@implementation LThirdTableViewCell{
    MAMapView *_mapView ;
    AMapNearbySearchManager *_nearbyManager;
    AMapNearbySearchRequest *request;
    UIButton* oneKeyOrder;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initMethod];
    return self;
    
}

- (void)initMethod{
    [AMapServices sharedServices].apiKey = @"2ddddd87e03ef92ae7692f30506cf84a";
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    ///把地图添加至view
    [self addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //_mapView.logoCenter = CGPointMake(CGRectGetWidth(self.bounds)-55, 450);
    [_mapView setCompassImage:[UIImage imageNamed:@""]];

    //一键下单按钮
    oneKeyOrder = [[UIButton alloc] init];
    oneKeyOrder.layer.cornerRadius = 8 ;
    [self addSubview:oneKeyOrder];
    [oneKeyOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.sizeOffset(CGSizeMake(331, 48));
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [oneKeyOrder setBackgroundColor:MAINCOLOR];
    [oneKeyOrder setTitle:@"一键下单" forState:UIControlStateNormal];
    [oneKeyOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneKeyOrder addTarget:self action:@selector(makeOrder) forControlEvents:UIControlEventTouchDown];
 }

-(void)makeOrder{
    LOrderGettingViewController* tempVC = [[LOrderGettingViewController alloc]init];
    UIViewController* mainVC = [self findVC:self];
    tempVC.hidesBottomBarWhenPushed = YES;
    [mainVC.navigationController pushViewController:tempVC animated:YES];
    
}
-(UIViewController*)findVC:(UIView*)tempView{
    UIViewController* findView = [[UIViewController alloc]init];
    while (tempView) {
        if ([tempView.nextResponder isKindOfClass:[UIViewController class]]) {
            findView = (UIViewController*)tempView.nextResponder;
            return findView;
        }else{
            tempView =(UIView*) tempView.nextResponder;
        }
    }
    return findView;
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
