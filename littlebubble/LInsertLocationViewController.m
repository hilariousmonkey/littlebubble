//
//  LInsertLocationViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/22.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LInsertLocationViewController.h"
#import "LMapSelectViewController.h"
#import "LChooseSexTableViewCell.h"
#import "LTextFieldTableViewCell.h"
#import "LSelectLocationTableViewCell.h"
#import "BaseRequest.h"
#import "LPublicData.h"
@interface LInsertLocationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView* tab;
    UIButton* saveBtn;
    NSString* userName,*userSex,*userPhone,*userLocation,*userDetailLocation;
    NSMutableDictionary* userDetailDic;
    BOOL ifLocationSuccess;
}
@end

@implementation LInsertLocationViewController
/*
设置导航栏
 */

-(NSArray*)cellPlaceholder{
    if (!_cellPlaceholder) {
        _cellPlaceholder = [NSArray arrayWithObjects:@[@{@"cellLab":@"姓名",@"cellTxt":@"请输入你的姓名"},@{@"sex":@"男"},@{@"cellLab":@"联系电话",@"cellTxt":@"请输入你的电话号"}], @[@{@"cellLab":@"所在小区",@"cellTxt":@"请选择您所在的小区"},@{@"cellLab":@"详细地址",@"cellTxt":@"请输入你的详细住址"}],nil];
    }
    return _cellPlaceholder;
}
/*
 cell的类数组
 */
-(NSArray*)classArray{
    if (!_classArray) {
        _classArray = @[@[@"LTextFieldTableViewCell",@"LChooseSexTableViewCell",@"LTextFieldTableViewCell"],@[@"LSelectLocationTableViewCell",@"LTextFieldTableViewCell"]];
    }
    return _classArray;
}

-(void)initUI{
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    ifLocationSuccess = NO;
    // Do any additional setup after loading the view.
    self.title = @"填写地址";
    self.view.backgroundColor = [UIColor grayColor];
    userDetailDic = [NSMutableDictionary dictionary];
    tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    tab.tableFooterView = [UIView new];
    //tab.scrollEnabled = NO;
    [self.view addSubview:tab];

    saveBtn = [[UIButton alloc]init];
    [tab addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(tab).offset(-20);
        make.size.sizeOffset(CGSizeMake(300, 40));
    }];
    saveBtn.layer.cornerRadius = 4;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:MAINCOLOR];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(makeSureOrder) forControlEvents:UIControlEventTouchDown];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld cellIdentifier",indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(self.classArray[indexPath.section][indexPath.row])alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([cell respondsToSelector:@selector(initData:)]) {
        [cell performSelector:@selector(initData:) withObject:self.cellPlaceholder[indexPath.section][indexPath.row]];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        lab.text = @"联系地址";
        lab.font = FONT(14);
        lab.backgroundColor = RGB(221, 221, 221);
        return lab;
    }
    else{
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        lab.text = @"联系人";
        lab.font = FONT(14);
        lab.backgroundColor = RGB(221, 221, 221);
        return lab;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1 && indexPath.row==0) {
        LMapSelectViewController* nextVc = [[LMapSelectViewController alloc]init:^(NSDictionary *a) {
            userDetailDic = @{@"name":a[@"street"],@"address":a[@"detailLocation"],@"longitude":a[@"longitude"],@"latitude":a[@"latitude"]}.copy;
            LSelectLocationTableViewCell* cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            cell.cellTxt.text = [NSString stringWithFormat:@"%@——%@",a[@"street"],a[@"detailLocation"]];
            userLocation = cell.cellTxt.text;
            ifLocationSuccess = YES;
        }];
        nextVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makeSureOrder{
    LTextFieldTableViewCell* nameCell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    userName = nameCell.cellTxt.text; //获取用户名称
    
    LTextFieldTableViewCell* phoneCell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    userPhone = phoneCell.cellTxt.text;//获取用户手机
    
    LTextFieldTableViewCell* userDetailLocationCell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    userDetailLocation = userDetailLocationCell.cellTxt.text;//获取用户详细位置
    
    LChooseSexTableViewCell* sex = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];  //获取用户性别
    if (sex.userSelecSex == 0) {
        userSex = @"男";
    }else{
        userSex = @"女";
    }
    if (userName.length == 0 || userPhone.length == 0 || userDetailLocation.length == 0 || userSex==nil || !ifLocationSuccess) {
        Alert(@"请先填入完整信息");
        return;
    }
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:@{@"userId":[LPublicData sharedUserInfo].userId,@"address":userDetailLocation,@"phone":userPhone,@"name":userName,@"lng":userDetailDic[@"longitude"],@"lat":userDetailDic[@"latitude"]} paramarsSite:@"/address/addressAdd" sucessBlock:^(id content) {
        NSError* error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dic);
        [self goBack];
    } failure:^(NSError *error) {
    }];

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
