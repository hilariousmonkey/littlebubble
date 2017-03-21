//
//  LLoginViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/8.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LLoginViewController.h"
#import "LRegisterViewController.h"
#import "UIImage+color.h"
#import "LForgetPsdViewController.h"
#import "BaseRequest.h"
#import "LPublicData.h"
#import <objc/runtime.h>

#import <QuartzCore/CoreAnimation.h>

@interface LLoginViewController ()

@end

@implementation LLoginViewController{
    UILabel* forgetPsdLab,*registLab,*otherLogin;
    UIButton* loginBtn;
    UIView* horLine1,*horLine2;
    UITextField* userName,*userPsd;
    UIImageView* userIcon,*userPsdIcon;
    UIImageView* weiXinLogin,*QQLogin,*weiBoLogin;
    UILabel* weiXinLab,*QQLab,*weiBoLab;
    
}
/*
 本方法为测试runtime输出效果
 */
-(void)runtimeTest{
    const char *className = object_getClassName([self class]);
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method:>>>>>>>>>>%@",NSStringFromSelector(method_getName(method)));
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = @"登录";
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setBackgroundColor:MAINCOLOR];
    //self.navigationController.navigationBar.tintColor = MAINCOLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MAINCOLOR] forBarMetrics:(UIBarMetricsDefault)];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //[self runtimeTest];
}

-(void)initUI
    {
    UIImageView *bgImage = [UIImageView new];
    [bgImage sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"]];
   /* [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT));
    }];*/
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[leftBtn setTitle:@"测试" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"QQ20170103-151146.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键
    userName = [[UITextField alloc] init];
    [self.view addSubview:userName];
    userName.layer.cornerRadius = 4;
    userName.layer.borderColor = [RGB(221, 221, 221) CGColor];
    userName.layer.borderWidth = 1;
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH-100, 30));
        make.centerX.equalTo(self.view);
    }];
    userIcon = [[UIImageView alloc] init];
    [self.view addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName).offset(10);
        make.centerY.equalTo(userName);
        make.size.sizeOffset(CGSizeMake(17, 19));
    }];
    userName.placeholder = @"手机号码/用户名";
    userName.font = FONT(12);
    //userName.textColor = [UIColor whiteColor];
    userName.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 19)];
    userName.leftViewMode = UITextFieldViewModeAlways;
    userIcon.image = [UIImage imageNamed:@"登录用户.png"];
    userPsd = [[UITextField alloc]init];
    [self.view addSubview:userPsd];
    userPsd.layer.cornerRadius = 4;
    userPsd.layer.borderColor =[RGB(221, 221, 221) CGColor];
    userPsd.layer.borderWidth = 1;
    [userPsd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userName.mas_bottom).offset(20);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH-100, 30));
        make.centerX.equalTo(self.view);
    }];
    userPsdIcon = [[UIImageView alloc] init];
    [self.view addSubview:userPsdIcon];
    [userPsdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userPsd).offset(10);
        make.centerY.equalTo(userPsd);
        make.size.sizeOffset(CGSizeMake(17, 19));
    }];
    userPsd.placeholder = @"密码";
    //userPsd.textColor = [UIColor whiteColor];
    userPsd.font = FONT(12);
    userPsd.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 19)];
    userPsd.leftViewMode = UITextFieldViewModeAlways;
    userPsd.secureTextEntry = YES;
    userPsdIcon.image = [UIImage imageNamed:@"登录密码.png"];
    forgetPsdLab = [[UILabel alloc] init];
    [self.view addSubview:forgetPsdLab];
    registLab = [[UILabel alloc] init];
    [self.view addSubview:registLab];
    forgetPsdLab.text = @"忘记密码？";
    forgetPsdLab.textColor = [UIColor grayColor];
    UITapGestureRecognizer* tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goForgetPsd)];
    [forgetPsdLab addGestureRecognizer:tapGesture1];
    forgetPsdLab.userInteractionEnabled = YES;
    [forgetPsdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userPsd.mas_bottom).offset(5);
        make.left.equalTo(userPsd);
        make.size.sizeOffset(CGSizeMake(100, 10));
    }];
    forgetPsdLab.font = FONT(12);

    registLab = [[UILabel alloc] init];
    [self.view addSubview:registLab];
    registLab.text = @"注册账号";
    registLab.textAlignment = NSTextAlignmentRight;
    registLab.textColor = MAINCOLOR;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goRegister)];
    [registLab addGestureRecognizer:tapGesture];
    registLab.userInteractionEnabled = YES;
    [registLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userPsd.mas_bottom).offset(5);
        make.right.equalTo(userPsd.mas_right);
        make.size.sizeOffset(CGSizeMake(100, 10));
    }];
    registLab.font = FONT(12);
    loginBtn = [[UIButton alloc] init];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userPsd);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH-100, 30));
        make.top.equalTo(userPsd.mas_bottom).offset(40);
    }];

    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:MAINCOLOR];
    [loginBtn addTarget:self action:@selector(logins) forControlEvents:UIControlEventTouchDown];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 16;
    //self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage.image];
    UILabel* loginWay = [[UILabel alloc] init];
    loginWay.text = @"其他登录";
    loginWay.font = FONT(12);
    loginWay.textColor =  RGB(221, 221, 221);
    [self.view addSubview:loginWay];
    [loginWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loginBtn);
        make.top.equalTo(loginBtn).offset(30);
        make.size.sizeOffset(CGSizeMake(100, 40));
    }];
    loginWay.textAlignment = NSTextAlignmentCenter;
    UIView *leftLine = [[UIView alloc] init];
    UIView *rightLine = [[UIView alloc] init];
    leftLine.backgroundColor = RGB(221, 221, 221);
    rightLine.backgroundColor = RGB(221, 221, 221);
    [self.view addSubview:leftLine];
    [self.view addSubview:rightLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginWay.mas_left).offset(-10);
        make.size.sizeOffset(CGSizeMake(80, 1));
        make.centerY.equalTo(loginWay);
    }];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginWay.mas_right).offset(10);
        make.size.sizeOffset(CGSizeMake(80, 1));
        make.centerY.equalTo(loginWay);
    }];
}
-(void)goRegister{
    LRegisterViewController* registerView = [[LRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}
-(void)goForgetPsd{
    LForgetPsdViewController* registerView = [[LForgetPsdViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loginWarnning{
    if (userName.text.length ==0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请先输入手机号" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请输入正确手机号" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
    }
    
}

//登录方法

-(void)logins{   //登录接口
    NSString* phoneNum = userName.text;
    NSString* pasd = userPsd.text;
    if ([pasd isEqualToString:@""]) {
        UIAlertView*  alertView = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:@"请输入密码" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    NSDictionary *loginDic = @{@"phone_num" : phoneNum,@"psw":pasd};
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:loginDic paramarsSite:@"/user/login" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"登录认证信息%@",loginDic);
        UIAlertView *alertView;
        NSLog(@"登录认证信息%@",loginDic[@"msg"]);
        switch ([loginDic[@"msg"] integerValue]) {
            case 0:
                alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"账号不存在，请重新输入" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
                userName.text = @"";
                userPsd.text = @"";
               // [self editChange];
                break;
            case 1:
                alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
               // [[NSNotificationCenter defaultCenter] postNotificationName:@"userHXRelogin" object:@YES];
                [LPublicData sharedUserInfo].userId = loginDic[@"user_id"];
                /**保存用户的登录信息**/
                [[LPublicData sharedUserInfo] setValuesByDictionary:@{@"id":loginDic[@"user_id"],@"username":loginDic[@"user_name"],@"password":pasd}];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:0.25];
                break;
            case 3:
                alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"密码错误，请重新输入" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                userPsd.text = @"";
                [alertView show];
                break;
            case 4:
                alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"您的账户被禁用" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                userName.text = @"";
                [alertView show];
                break;
            default:
                break;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        
    }];
    
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
