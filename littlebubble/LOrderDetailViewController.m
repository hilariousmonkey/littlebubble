//
//  LOrderDetailViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/21.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LOrderDetailViewController.h"
#import "BaseRequest.h"

@interface LOrderDetailViewController (){
    UILabel* orderNo,*orderName,*orderPhone,*orderSite;
    NSDictionary* initDataDic;
    NSString *orderNum;
}

@end

@implementation LOrderDetailViewController
-(LOrderDetailViewController*)init:(NSDictionary*)initDic{
    self = [super init];
    initDataDic = initDic;
    orderNum = initDic[@"orderNo"];
    return self;
}
/*
 每次返回页面时请求数据
 */
-(void)viewWillAppear{
    [self getOrderDetail:orderNum];
}
-(void)getOrderDetail:(NSString*)orderNo{
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:nil paramarsSite:@"Order/orderDetails" sucessBlock:^(id content) {
        NSError* error;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",result);
        if ([result[@"msg"] isEqualToString:@"1"]) {
            [self handleDic:result];
        }
    } failure:^(NSError *error) {
        Alert(@"请求失败");
    }];
}
-(void)handleDic:(NSDictionary*)tempDic{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self initUI];
    self.view.backgroundColor = RGB(221, 221, 221);
    // Do any additional setup after loading the view.
}
-(void)initUI{
    UIView* topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 200));
    }];

    UIImageView* topIcon = [[UIImageView alloc]init];
    topIcon.image = [UIImage imageNamed:@"店铺图片.png"];
    [topView addSubview:topIcon];
    [topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(10);
        make.size.sizeOffset(CGSizeMake(20, 20));
        make.left.equalTo(topView).offset(10);
    }];
    UILabel *topLab = [[UILabel alloc]init];
    topLab.text = @"订单详情";
    topLab.font = FONT(12);
    [topView addSubview:topLab];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(10);
        make.size.sizeOffset(CGSizeMake(120, 20));
        make.left.equalTo(topIcon.mas_right).offset(12);
    }];
  
    UIView *topLine = [[UIView alloc]init];
    [topView addSubview:topLine];
    topLine.backgroundColor = RGB(221, 221, 221);
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLab.mas_bottom).offset(7);
        make.size.sizeOffset(CGSizeMake(340, 1));
        make.centerX.equalTo(topView);
    }];
    
    UILabel *orderLab = [[UILabel alloc]init];
    [topView addSubview:orderLab];
    orderLab.text = @"订单编号:";
    [orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine).offset(18);
        make.left.equalTo(topView).offset(17);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    orderLab.font = FONT(14);
    
    orderNo = [[UILabel alloc]init];
    [topView addSubview:orderNo];
    
    UILabel *userName = [[UILabel alloc]init];
    [topView addSubview:userName];
    userName.text = @"客户姓名:";
    userName.font = FONT(14);

    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderLab).offset(25);
        make.left.equalTo(topView).offset(17);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    orderName = [[UILabel alloc]init];
    [topView addSubview:orderName];
    
    UILabel *userPhone = [[UILabel alloc]init];
    [topView addSubview:userPhone];
    userPhone.text = @"客户电话:";
    userPhone.font = FONT(14);

    [userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userName).offset(25);
        make.left.equalTo(topView).offset(17);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    orderPhone = [[UILabel alloc]init];
    [topView addSubview:orderPhone];

    UILabel *userLocation = [[UILabel alloc]init];
    [topView addSubview:userLocation];
    userLocation.text = @"客户地址:";
    userLocation.font = FONT(14);
    [userLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userPhone).offset(25);
        make.left.equalTo(topView).offset(17);
        make.size.sizeOffset(CGSizeMake(100, 20));
    }];
    orderSite = [[UILabel alloc]init];
    [topView addSubview:orderSite];
//
    //   //   //   //   //第二部分   //   //   //   //   //
//
    UIView *centerView = [[UIView alloc]init];
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 225));
        make.left.equalTo(self.view);
    }];
    centerView.backgroundColor = [UIColor whiteColor];
    
    UILabel* commodity = [[UILabel alloc]init];
    [centerView addSubview:commodity];
    [commodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView).offset(13);
        make.centerX.equalTo(centerView).offset(-90);
        make.size.sizeOffset(CGSizeMake(80, 15));
    }];

    commodity.text = @"商品";
    commodity.font = FONT(12);
    commodity.textColor = MAINCOLOR;
    commodity.textAlignment = NSTextAlignmentCenter;

    UILabel* commodityNum = [[UILabel alloc]init];
    [centerView addSubview:commodityNum];
    commodityNum.text = @"数量";
    commodityNum.font = FONT(12);
    commodityNum.textColor = MAINCOLOR;
    commodityNum.textAlignment = NSTextAlignmentCenter;
    [commodityNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView).offset(13);
        make.centerX.equalTo(centerView).offset(90);
        make.size.sizeOffset(CGSizeMake(80, 15));
    }];
  
    UIView *centerLine = [[UIView alloc]init];
    [centerView addSubview:centerLine];
    centerLine.backgroundColor = RGB(221, 221, 221);
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commodity.mas_bottom).offset(13);
        make.size.sizeOffset(CGSizeMake(340, 1));
        make.centerX.equalTo(topView);
    }];
      /**/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
