//
//  LOrderGettingViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/28.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LOrderGettingViewController.h"
#import "UIImage+color.h"
#import "LOrderGettingTableViewCell.h"
#import "LOrderGetting2TableViewCell.h"
#import "DZSelectorView.h"
#import "LRemarkViewController.h"
#import "BaseRequest.h"
#import "LAddressViewController.h"
#import "LOrderGetting2TableViewCell.h"
@interface LOrderGettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LOrderGettingViewController{
    UITableView* tab;
    NSArray* cellClassArray,*cellDictionnary;
    UIButton* makeSure;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cellClassArray = @[@"LOrderGettingTableViewCell",@"LOrderGetting2TableViewCell"];
    cellDictionnary = @[@[@{@"gustName":@"测试",@"gustPhone":@"13198730143",@"gustAddress":@"保利香槟国际7栋2单元413"}],@[@{@"cellIcon":@"取件时间",@"cellLab":@"请选择上门取件时间"},@{@"cellIcon":@"备注",@"cellLab":@"备注"}]];
    // Do any additional setup after loading the view.
    self.title = @"订单预约";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MAINCOLOR] forBarMetrics:(UIBarMetricsDefault)];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    tab.dataSource = self;
    tab.delegate = self;
    //tab.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tab];
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[leftBtn setTitle:@"测试" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"QQ20170103-151146.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键
    makeSure = [[UIButton alloc]init];
    [self.view addSubview:makeSure];
    [makeSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(330, 45));
    }];
    makeSure.layer.cornerRadius = 8;
    makeSure.backgroundColor = MAINCOLOR;
    [makeSure setTitle:@"预约取件" forState:UIControlStateNormal];
    [makeSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSure addTarget:self action:@selector(makesure) forControlEvents:UIControlEventTouchDown];
    
}
-(void)makesure{
    /*先获取地址信息*/
    LOrderGettingTableViewCell* cell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString* userName = cell.gustName.text;
    NSString* userPhone = cell.gustPhone.text;
    NSString* userAddress = cell.gustAddress.text;
    NSString* locationID = cell.cellId;
    //然后获取用户预约时间和备注
    LOrderGetting2TableViewCell* tempCell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSString* userTime = tempCell.cellLab.text;
    
    LOrderGetting2TableViewCell* tempCell1 = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSString* userBackWords = tempCell1.cellLab.text;
    
    if ([userName isEqualToString:@""]||[userPhone isEqualToString:@""]||[userAddress isEqualToString:@""]||[userTime isEqualToString:@"请选择上门取件时间"]) {
        Alert(@"请先补全信息");
        return;
    }
    
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:@{@"phone":userPhone,@"userAddress":locationID,@"receiveTime":userTime,@"remark":userBackWords} paramarsSite:@"/order/fastOrder" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"验证码信息%@",loginDic);
        if ([loginDic[@"msg"] integerValue] == 1) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"提示" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertView show];
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
    
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

/* Tableview Delegate */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LAddressViewController *tempV = [[LAddressViewController alloc]init:^(NSDictionary *a) {
            LOrderGettingTableViewCell* theFirstCell = [tableView  cellForRowAtIndexPath:indexPath];
            theFirstCell.cellId = a[@"id"];
            theFirstCell.gustName.text = a[@"name"];
            theFirstCell.gustPhone.text  = a[@"phone"];
            theFirstCell.gustAddress.text = a[@"address"];     /*Block回传修改地址单元格信息*/
        }];
        tempV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tempV animated:YES];
    }if (indexPath.section == 1 &&indexPath.row == 0) {
        DZSelectorView *tempView = [[DZSelectorView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT/2, SCREEN_WIDTH,  SCREENH_HEIGHT/2) trans:^(NSString *a) {
            LOrderGetting2TableViewCell* tempCell = [tableView cellForRowAtIndexPath:indexPath];     /*Block回传修改预约时间单元格信息*/

            tempCell.cellLab.text = a;
        }];
        
        [self.view addSubview:tempView];
    }else if(indexPath.section == 1 && indexPath.row == 1){
        //LRemarkViewController
        LRemarkViewController *tempView = [[LRemarkViewController alloc]init:^(NSString *a) {
            LOrderGetting2TableViewCell* tempCell = [tableView cellForRowAtIndexPath:indexPath];
            tempCell.cellLab.text = a;
            NSLog(@"This is your BackWords ----->   : %@",a);    /*Block回传修改备注单元格信息*/
        }];
        [self.navigationController pushViewController:tempView animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* reuseString = @"cellIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString];
    if (!cell) {
        cell = [[NSClassFromString(cellClassArray[indexPath.section]) alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseString];
        if ([cell respondsToSelector:@selector(initData:)]) {
            [cell performSelector:@selector(initData:) withObject:cellDictionnary[indexPath.section][indexPath.row]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 72;
    }else{
        return 40;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
