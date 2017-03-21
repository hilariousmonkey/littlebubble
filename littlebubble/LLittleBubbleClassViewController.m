//
//  LLittleBubbleClassViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/3/1.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LLittleBubbleClassViewController.h"
#import "UIImage+color.h"
@interface LLittleBubbleClassViewController ()

@end

@implementation LLittleBubbleClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
