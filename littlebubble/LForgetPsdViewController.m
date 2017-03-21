//
//  LForgetPsdViewController.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/8/8.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#define pressBtnColrY [UIColor colorWithRed:208/255.0f green:30/255.0f blue:41/255.0f alpha:1]
#define pressBtnColrN [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1]


#import "LForgetPsdViewController.h"
#import "BaseRequest.h"
#import "IdentifierValidator.h"
#import "LUserInputTextField.h"

@interface LForgetPsdViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL ifHidden;
    UIButton* maskBtn;
    
    NSMutableArray* psd;
    UIAlertView* alert ;
    LUserInputTextField* textFid;
    LUserInputTextField* cerCode;
    LUserInputTextField* newPassWord;
    UIButton* pressBtn;
    
    UIView* maskBtnBackView;
    __block int timeout;
}
@property (strong,nonatomic) UIButton* ensurBtn;

@end

@implementation LForgetPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    //设置navigationBar
    UIButton* tempBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(fanHui) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem* goBack = [[UIBarButtonItem alloc]initWithCustomView:tempBtn];
    self.navigationItem.leftBarButtonItem = goBack;
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0f green:240/255.0f blue:241/255.0f alpha:1];
    UITableView* tab = [[UITableView alloc]initWithFrame:CGRectMake(0,84, self.view.frame.size.width, 150) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.backgroundColor = [UIColor whiteColor];
    tab.delegate = self;
    tab.dataSource = self;
    tab.scrollEnabled = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;  //调整tableview初始滚动条位置
    
    _ensurBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-(self.view.frame.size.width-50)/2, tab.frame.origin.y+tab.frame.size.height+50, self.view.frame.size.width-50, 40)];
    _ensurBtn.enabled = NO;
    _ensurBtn.layer.cornerRadius = 4;
    [self.view addSubview:_ensurBtn];
    [_ensurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ensurBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [_ensurBtn setBackgroundColor:pressBtnColrN];
    [_ensurBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
            textFid = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 150, 40)];
            [cell.contentView addSubview:textFid];
            textFid.placeholder = @"请输入手机号";
            textFid.font = [UIFont systemFontOfSize:14];
            textFid.tag = 200;
            [textFid addTarget:self action:@selector(editChange) forControlEvents:UIControlEventEditingChanged];
            [textFid addTarget:self action:@selector(checkPhone) forControlEvents:UIControlEventEditingChanged];
            [textFid addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            UIButton* clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-150, cell.frame.size.height/2-10, 20, 20)];
            [cell.contentView addSubview:clearBtn];
            [clearBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchDown];
            clearBtn.enabled = NO;
            clearBtn.tag = 201;
            UIView* verLine = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.size.width-58, cell.frame.origin.y+1, 1, cell.frame.size.height)];
            verLine.backgroundColor = [UIColor colorWithRed:218/255.0f green:219/255.0f blue:220/255.0f alpha:1];
            [cell.contentView addSubview: verLine];
            [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(verLine).offset(-5);
                make.centerY.equalTo(cell);
            }];
            pressBtn.enabled = NO;
            pressBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, cell.frame.size.height/2-15, 100, 40)];
            [pressBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [pressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [pressBtn setBackgroundColor:pressBtnColrN];
            pressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [pressBtn addTarget:self action:@selector(code) forControlEvents:UIControlEventTouchDown];
            [cell.contentView addSubview:pressBtn];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"验证码";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            
            cerCode = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 200, 40)];
            [cell.contentView addSubview:cerCode];
            cerCode.placeholder = @"请输入验证码";
            cerCode.font = [UIFont systemFontOfSize:14];
        }else {
            cell.textLabel.text = @"新密码";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            newPassWord = [[LUserInputTextField alloc]initWithFrame:CGRectMake(100, cell.frame.size.height/2-20, 100, 40)];
            [cell.contentView addSubview:newPassWord];
            newPassWord.placeholder = @"请输入新密码";
            newPassWord.font = [UIFont systemFontOfSize:14];
            newPassWord.tag = 202;
            newPassWord.secureTextEntry = YES;
            [newPassWord addTarget:self action:@selector(checkPsdIfEmpty) forControlEvents:UIControlEventEditingChanged];
            
            maskBtnBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            maskBtnBackView.backgroundColor =[UIColor clearColor ];
            maskBtnBackView.hidden = YES;
            [cell.contentView addSubview:maskBtnBackView];
         
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskPsd)];
            [maskBtnBackView addGestureRecognizer:tap];
            maskBtnBackView.userInteractionEnabled = YES;
            maskBtnBackView.superview.userInteractionEnabled = YES;
            
            maskBtn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, cell.frame.size.height/2-10, 15, 10)];
            [cell.contentView addSubview:maskBtn];
            maskBtn.hidden = YES;
            [maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell);
                make.right.equalTo(cell).offset(-50);
            }];
            
            [maskBtnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(maskBtn);
                make.centerX.equalTo(maskBtn);
                make.size.sizeOffset(CGSizeMake(50, 50));
            }];
            
            
            [maskBtn setBackgroundImage:[UIImage imageNamed:@"show"] forState:UIControlStateNormal];
            [maskBtn addTarget:self action:@selector(maskPsd) forControlEvents:UIControlEventTouchDown  ];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)maskPsd{
    if(!ifHidden){
        UITextField* tempTxt = [self.view viewWithTag:202];
        tempTxt.secureTextEntry = NO;
        [maskBtn setBackgroundImage:[UIImage imageNamed:@"Not-show"] forState:UIControlStateNormal];
        ifHidden = YES;
    }else{
        UITextField* tempTxt = [self.view viewWithTag:202];
        tempTxt.secureTextEntry = YES;
        [maskBtn setBackgroundImage:[UIImage imageNamed:@"show"] forState:UIControlStateNormal];
        ifHidden = NO;
    }
}
-(void)btnClick{
    UITextField* tempTextFid = [self.view viewWithTag:200];
    tempTextFid.text = @"";
    cerCode.text = @"";
    newPassWord.text = @"";
    UIButton* tempBtn = [self.view viewWithTag:201];
    tempBtn.enabled = NO;
    [tempBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self checkPhone];

}
-(void)editChange{
    if ([textFid.text isEqualToString:@""]) {
        UIButton* tempBtn = [self.view viewWithTag:201];
        tempBtn.enabled = NO;
        [tempBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return;
    }
    UIButton* tempBtn = [self.view viewWithTag:201];
    tempBtn.enabled = YES;
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
}
-(void)checkPhone{
    
    if ([IdentifierValidator isMobileNumber:textFid.text]) {
        [pressBtn setBackgroundColor:COLOR(206, 0, 0, 1)];
        pressBtn.enabled = YES;
        _ensurBtn.enabled = YES;
        [_ensurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ensurBtn setBackgroundColor:MAINCOLOR];
        
    } else {
        [pressBtn setBackgroundColor:pressBtnColrN];
        [_ensurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ensurBtn setBackgroundColor:pressBtnColrN];
        pressBtn.enabled = NO;
        _ensurBtn.enabled = NO;
        
    };
}
-(void)checkPsdIfEmpty{
    if (newPassWord.text.length > 0) {
        maskBtn.hidden = NO;
        maskBtnBackView.hidden = NO;
    }else{
        maskBtn.hidden = YES;
        maskBtnBackView.hidden = YES;
    }
}
-(void)fanHui{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"验证码发送成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"验证码发送失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertView show];
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码发送失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        
    }];
}

//忘记密码方法
-(void)back{
    NSString* phoneNum = textFid.text;
    NSString* yanzhengma = cerCode.text;
    NSString* pasd = newPassWord.text;
    
    if (!(phoneNum.length!=0 && yanzhengma.length!=0 && pasd.length!=0)) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"请输入完整信息" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    
    NSDictionary *loginDic = @{@"phone":phoneNum,@"msg":yanzhengma,@"psw":pasd};
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:loginDic paramarsSite:@"/user/forgetPsw" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"验证码信息%@",loginDic);
        UIAlertView *alertView;
        switch ([loginDic[@"msg"] integerValue]) {
            case 0:
                alertView = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:@"请重新输入" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
                timeout = 60;
                break;
            case 1:
                alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"成功修改密码" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
                [pressBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                pressBtn.userInteractionEnabled = YES;  //当注册成功时恢复验证码发送按钮
                [self.navigationController popViewControllerAnimated:YES];
                textFid.text = @"";
                cerCode.text = @"";
                newPassWord.text = @"";
                break;
            case 3:
                alertView = [[UIAlertView alloc] initWithTitle:@"账号不存在" message:@"账号不存在" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alertView show];
                timeout = 60;

                break;
            default:
                break;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
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

@end
