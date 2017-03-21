//
//  LRemarkViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/3/2.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LRemarkViewController.h"
#import "UIImage+color.h"
@interface LRemarkViewController ()
@property (nonatomic,strong) void (^translate)(NSString* c);
@end

@implementation LRemarkViewController{
    UITextView *txtFid;
    UIButton* btn;
}
-(instancetype)init:(void (^)(NSString* a))array{
    self.translate = array;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"备注";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MAINCOLOR] forBarMetrics:(UIBarMetricsDefault)];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
        
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[leftBtn setTitle:@"测试" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键
    [self initUI];
}
-(void)initUI{
    txtFid = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-20, 200)];
    txtFid.backgroundColor = RGB(221, 221, 221);
    [self.view addSubview:txtFid];
    [txtFid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH-20, 200));
    }];
    btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(300, 40));
    }];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setBackgroundColor:MAINCOLOR];
    btn.layer.cornerRadius = 8;
    [btn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchDown];
}
-(void)makeSure{
    self.translate(txtFid.text);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
