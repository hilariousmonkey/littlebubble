//
//  LAddressViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/12.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LAddressViewController.h"
#import "LAddressTableViewCell.h"
#import "LInsertLocationViewController.h"
#import "BaseRequest.h"
#import "LPublicData.h"
@interface LAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray* dataArray;
@end

@implementation LAddressViewController{
    UITableView *tab;
    UIButton* addressAdd;
    NSString *userIdNo;
    NSInteger willDelete;
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
/*
 每次返回页面时请求数据
 */
-(instancetype)init:(void(^)(NSDictionary*))a{
    self = [super init];
    if (self) {
        self.trans = a;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self getUserAddress:userIdNo];
}
-(void)getUserAddress:(NSString*)userNo{
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:@{@"userId":userNo} paramarsSite:@"/address/addressGetAll" sucessBlock:^(id content) {
        NSError* error;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",result);
        if ([result[@"msg"] isEqualToString:@"1"]) {
        [self handleDic:result[@"list"]];
        }
    } failure:^(NSError *error) {
        Alert(@"请求失败");
    }];
}
-(void)handleDic:(NSDictionary*)tempArray{
    [self.dataArray removeAllObjects];
    for (NSDictionary* tempDic in tempArray) {
        [self.dataArray addObject:@{@"id":tempDic[@"id"],@"lat":tempDic[@"lat"],@"lng":tempDic[@"lng"],@"userName":tempDic[@"username"],@"userPhone":tempDic[@"phone"],@"userAddress":tempDic[@"content"],@"ifDefault":tempDic[@"state"]}];
    }
    [tab reloadData];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    userIdNo = [LPublicData sharedUserInfo].userId;
    self.view.backgroundColor = [UIColor whiteColor];
    tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    tab.tableFooterView = [ UIView new];
    [self.view addSubview:tab];
    self.title = @"地址管理";
    tab.delegate = self;
    tab.dataSource = self;
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[leftBtn setTitle:@"测试" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"QQ20170103-151146.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键
    self.view.backgroundColor = RGB(221, 221, 221);
    
    addressAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT-50, SCREEN_WIDTH, 50)];
    [addressAdd setTitle:@"添加地址" forState:UIControlStateNormal];
    [addressAdd setBackgroundColor:RGB(221, 221, 221)];
    [addressAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:addressAdd];
    [addressAdd addTarget:self action:@selector(changeVC) forControlEvents:UIControlEventTouchDown];
    [addressAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 50));
        make.left.equalTo(self.view);
    }];
    UIImageView *btnView = [[UIImageView alloc] init];
    [addressAdd addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView);;
        make.centerX.equalTo(btnView).offset(-20);
        make.size.sizeOffset(CGSizeMake(20, 20));
    }];
   // btnView.image = [UIImage imageNamed:@"QQ20170103-151146.png"];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = [NSString stringWithFormat:@"%lduserIdentifier",indexPath.row];
    LAddressTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier trans:^(NSString *a) {
            LInsertLocationViewController *tempVC = [[LInsertLocationViewController alloc]init];
            tempVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tempVC animated:YES];
        } trans1:^(NSString *a1) {
        }];
    }
    if ([cell respondsToSelector:@selector(initData:)]) {
        [cell performSelector:@selector(initData:) withObject:self.dataArray[indexPath.row]];
    }
     return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count) {
        return [self.dataArray count];
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//删除按钮动作
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction* deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"确认删除吗" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alertView.delegate = self;
        willDelete = indexPath.row;
        [alertView show];
        //   [self deleteView:tableView deleteAry:tempAry deleteRow:indexPath.row];
    }];
    return @[deleteAction];
}

/*
        TableView Delegate
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LAddressTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary* willTransData = @{@"id":cell.cellId,@"name":cell.userName,@"phone":cell.userPhone,@"address":cell.userAddress};
    self.trans(willTransData);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.dataArray removeObjectAtIndex:0];
        [tab reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeVC{
    LInsertLocationViewController *tempVC = [[LInsertLocationViewController alloc]init];
    tempVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tempVC animated:YES];
    
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
