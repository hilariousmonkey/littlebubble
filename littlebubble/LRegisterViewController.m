//
//  LRegisterViewController.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/8/8.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#define pressBtnColrY MAINCOLOR
#define pressBtnColrN [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1]

#import "LRegisterViewController.h"
#import "BaseRequest.h"
#import "IdentifierValidator.h"
#import "LUserInputTextField.h"
@interface LRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* psd;
    UIAlertView* alert ;
    LUserInputTextField* textFid;
    LUserInputTextField* cerCode;
    LUserInputTextField* passWord;
    LUserInputTextField* reinputPsd;
    UIButton* pressBtn;
    __block int timeout;
     bool ifHaveRegister,ifHuanXinRegister;
}
@property (strong,nonatomic) UIButton* ensurBtn;

@end

@implementation LRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快速注册";
    //设置navigationBar
    UIButton* tempBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"返回.ong"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(fanHui) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem* goBack = [[UIBarButtonItem alloc]initWithCustomView:tempBtn];
    self.navigationItem.leftBarButtonItem = goBack;
    UIButton* tempBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 16)];
    [tempBtn1 setTitle:@"登录" forState:UIControlStateNormal];
    tempBtn1.titleLabel.font = FONT(14);
    [tempBtn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [tempBtn1 addTarget:self action:@selector(fanHui) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem* goBack1 = [[UIBarButtonItem alloc]initWithCustomView:tempBtn1];
    //self.navigationItem.rightBarButtonItem = goBack1;
    //初始化设置
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0f green:240/255.0f blue:241/255.0f alpha:1];
    UITableView* tab = [[UITableView alloc]initWithFrame:CGRectMake(0,84, self.view.frame.size.width, 200) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.backgroundColor = [UIColor whiteColor];
    tab.delegate = self;
    tab.dataSource = self;
    tab.scrollEnabled = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _ensurBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-(self.view.frame.size.width-50)/2, tab.frame.origin.y+tab.frame.size.height+50, self.view.frame.size.width-50, 40)];
    _ensurBtn.layer.cornerRadius = 4;
    [self.view addSubview:_ensurBtn];
    _ensurBtn.enabled = NO;
    [_ensurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ensurBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_ensurBtn setBackgroundColor:pressBtnColrN];
    [_ensurBtn addTarget:self action:@selector(index) forControlEvents:UIControlEventTouchDown];
     alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"两次输入密码不一致" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"ok", nil];
    [self.view addSubview:alert];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellidentifier = @"cellidentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"账号";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
    /*检查手机号规则*/
            textFid = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 200, 40)];
            [cell.contentView addSubview:textFid];
            textFid.placeholder = @"请输入手机号";
            textFid.font = [UIFont systemFontOfSize:14];
            textFid.keyboardType = UIKeyboardTypeNumberPad;
            textFid.tag = 200;
            [textFid addTarget:self action:@selector(editChange) forControlEvents:UIControlEventEditingChanged];
            [textFid addTarget:self action:@selector(checkPhone) forControlEvents:UIControlEventEditingChanged];
            [textFid addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            UIButton* clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-150, cell.frame.size.height/2-10, 20, 20)];
            [cell.contentView addSubview:clearBtn];
            [clearBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchDown];
            clearBtn.enabled = NO;
            clearBtn.tag = 201;
            UIView* verLine = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.size.width-58, cell.frame.origin.y, 1, cell.frame.size.height)];
            verLine.backgroundColor = [UIColor colorWithRed:218/255.0f green:219/255.0f blue:220/255.0f alpha:1];
            [cell.contentView addSubview: verLine];
       
            [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(verLine).offset(-5);
                make.centerY.equalTo(cell);
            }];
            pressBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-40, cell.frame.size.height/2-15, 100, 40)];
            pressBtn.enabled = NO;
            [pressBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            pressBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [pressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [pressBtn setBackgroundColor:pressBtnColrN];
            pressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:pressBtn];
            [pressBtn addTarget:self action:@selector(code) forControlEvents:UIControlEventTouchDown];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"验证码";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            cerCode = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 200, 40)];
            [cell.contentView addSubview:cerCode];
            cerCode.placeholder = @"请输入验证码";
            cerCode.font = [UIFont systemFontOfSize:14];
            cerCode.keyboardType = UIKeyboardTypeNumberPad;
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"密码";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            passWord = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 200, 40)];
            [cell.contentView addSubview:passWord];
            passWord.tag = 203;
            passWord.placeholder = @"请输入密码";
            passWord.font = [UIFont systemFontOfSize:14];
            passWord.secureTextEntry = YES;
        }else{
            cell.textLabel.text = @"确认密码";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            reinputPsd = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 200, 40)];
            [cell.contentView addSubview:reinputPsd];
            reinputPsd.tag = 204;
            reinputPsd.placeholder = @"请确认密码";
            reinputPsd.font = [UIFont systemFontOfSize:14];
            reinputPsd.secureTextEntry = YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)btnClick{
    UITextField* tempTextFid = [self.view viewWithTag:200];
    tempTextFid.text = @"";
    cerCode.text = @"";
    passWord.text = @"";
    reinputPsd.text = @"";
    UIButton* tempBtn = [self.view viewWithTag:201];
    tempBtn.enabled = NO;
    [tempBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self checkPhone];
}
-(void)editChange{
    UIButton* tempBtn = [self.view viewWithTag:201];
    tempBtn.enabled = YES;
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"shouye_cha"] forState:UIControlStateNormal];
}
-(Boolean)checkPsd{
    UITextField* tempFid1 = [self.view viewWithTag:203];
    UITextField* tempFid2 = [self.view viewWithTag:204];
    NSString* psd1 = tempFid1.text;
    NSString* psd2 = tempFid2.text;

    if(![psd1 isEqualToString: psd2 ]){
       [alert show];
        return NO;
}
    return YES;
}

-(void)checkPhone{
    
    if ([IdentifierValidator isMobileNumber:textFid.text]) {
        [pressBtn setBackgroundColor:MAINCOLOR];
        pressBtn.enabled = YES;
        _ensurBtn.enabled = YES;
        [_ensurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ensurBtn setBackgroundColor:pressBtnColrY];

    } else {
        [pressBtn setBackgroundColor:pressBtnColrN];
        [_ensurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ensurBtn setBackgroundColor:pressBtnColrN];
        pressBtn.enabled = NO;
        _ensurBtn.enabled = NO;
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fanHui{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)timerSet{
    /*******  验证码倒计时   *******/
    timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [pressBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                pressBtn.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [pressBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //hqBtn.backgroundColor = [UIColor grayColor];
                pressBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)checkHaveRegister{
    NSString* phoneNum = textFid.text;
    NSDictionary *loginDic = @{@"phone" : phoneNum};

    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:loginDic paramarsSite:@"/user/code" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"验证码信息%@",loginDic);
        if ([loginDic[@"msg"] integerValue] == 1) {
            [self code];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号已经注册" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertView show];
            return ;
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        return ;
    }];

}
/*******  *******  *******  *******   接口   *******  *******  *******  *******/
-(void)code{   //验证码接口
/*******  验证码倒计时   *******/
    timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [pressBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                pressBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [pressBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //hqBtn.backgroundColor = [UIColor grayColor];
                pressBtn.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    NSString* phoneNum = textFid.text;
    NSDictionary *loginDic = @{@"phone" : phoneNum};
  
        [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:loginDic paramarsSite:@"/user/code" sucessBlock:^(id content) {
            NSError *error;
            NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"验证码信息%@",loginDic);
            if ([loginDic[@"msg"] integerValue] == 1) {
                
            }
            else{

            }
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertView show];
            
        }];

  
}

//注册方法
-(void)index{   //验证码接口
    if (!(pressBtn.enabled  && passWord.text.length!=0 && reinputPsd.text.length!=0 && cerCode.text.length!=0)) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"请输入完整信息" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    if (![self checkPsd]) {
        return ;
    }
    NSString* phoneNum = textFid.text;
    NSString* yanzhengma = cerCode.text;
    NSString* pasd = passWord.text;
    
    NSDictionary *loginDic = @{@"phone":phoneNum,@"code":yanzhengma,@"password":pasd};
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:loginDic paramarsSite:@"/user/registerOk" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"验证码信息%@",loginDic);
        UIAlertView *alertView;
        switch ([loginDic[@"msg"] integerValue]) {
            case 0:
                alertView = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:@"请重新输入" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
                 break;
            case 1:
//                if (![self registerHX]) {
//                    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
//                    [alertV show];
//                    return;
//                }
                //[self registerHX];
               // alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
             //   [alertView show];
                    ifHuanXinRegister = YES;
                    Alert(@"注册成功");
                [pressBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                pressBtn.userInteractionEnabled = YES;  //当注册成功时恢复验证码发送按钮
              ;//注册环信
                 [self.navigationController popViewControllerAnimated:YES];
                break;
            case 2:
                alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号已存在" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
                timeout = 60;
                break;
            default:
                break;
        }
 
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注册失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == textFid) {
        if (textField.text.length > 11) {
             NSString* tempString =[textField.text substringToIndex:11];
            textField.text = tempString;
            [self checkPhone];
        }
    }
 }
-(bool)registerHX{
    ifHuanXinRegister = NO;
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars: @{@"phone":textFid.text,@"password":@"123"} paramarsSite:@"/Register/index" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *indexDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",indexDic);
        if ([indexDic[@"msg"] intValue] ==1) {
            ifHuanXinRegister = YES;
            Alert(@"注册成功");
             return  ;
        }else
            ifHuanXinRegister = NO;
            Alert(@"注册失败");
     }
   failure:^(NSError *error) {
       ifHuanXinRegister = NO;
       Alert(@"注册失败");
        NSLog(@"error = %@",error);
    }];
     return ifHuanXinRegister;
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
