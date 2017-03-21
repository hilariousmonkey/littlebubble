//
//  LMineViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/3.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LMineViewController.h"
#import "LHeaderCell.h"
#import "LDounbleButtonTableViewCell.h"
#import "LLoginViewController.h"
#import "LUserInfoViewController.h"
#import "LAddressViewController.h"
#import "UIImage+color.h"
#import "LAboutUsViewController.h"
#import "LSettingViewController.h"
#import "LInsertLocationViewController.h"
#import "LPublicData.h"
#import "BaseRequest.h"

#define topCellHeigh 214
@interface LMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray* classArray;
@property (nonatomic,strong) NSArray* cellImgArray;
@property (nonatomic,strong) NSArray* cellNameArray;

@end

@implementation LMineViewController{
    UITableView* tab;
    NSMutableDictionary* userDic;
}
-(NSArray*)classArray{
    if (!_classArray) {
        _classArray = @[@"LHeaderCell",@"UITableViewCell",@"LDounbleButtonTableViewCell"];
    }
    return _classArray;
}

-(NSArray*)cellImgArray{
    if (!_cellImgArray) {
        _cellImgArray = @[@[],@[@"个人信息.png",@"常用地址.png",@"关于我们.png",@"推荐有奖.png",@"意见反馈.png",@"设置.png"],@[@"客服电话.png",@"在线客服.png"]];
    }
    return _cellImgArray;
}

-(NSArray*)cellNameArray{
    if (!_cellNameArray) {
        _cellNameArray = @[@[],@[@"个人信息",@"常用地址",@"关于我们",@"推荐有奖",@"意见反馈",@"设置"],@[@"客服电话",@"在线客服"]];
    }
    return _cellNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    userDic = [NSMutableDictionary dictionary];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    [self getUserInfo];
}
-(void)initData{
    tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    tab.tableFooterView = [UIView new];
//    xuling1314
    
}

//DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSString* classKey = self.classArray[indexPath.section];
        cell = [[NSClassFromString(classKey) alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1) {
            cell.imageView.image = [UIImage imageNamed:self.cellImgArray[indexPath.section][indexPath.row]];
            cell.textLabel.text = self.cellNameArray[indexPath.section][indexPath.row];
        }else if(indexPath.section == 2){
            if ([(LDounbleButtonTableViewCell*)cell respondsToSelector:@selector(initData:)]) {
                [(LDounbleButtonTableViewCell*)cell performSelector:@selector(initData:) withObject:@{@"leftBtnView":@"客服电话.png",@"rightBtnView":@"在线客服.png",@"leftTitle":@"客服电话",@"rightTitle":@"在线客服"}];
            }
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section!=0) {
        return 20;

    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 6;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return topCellHeigh;
    }else{
        return 40;
    }
}
//TableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([LPublicData sharedUserInfo].userId == nil) {
            LLoginViewController* login = [[LLoginViewController alloc] init];
            login.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:login animated:YES];
        }else{
            LUserInfoViewController* tempVC = [[LUserInfoViewController alloc]init];
            tempVC.view.backgroundColor = [UIColor whiteColor];
            tempVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tempVC animated:YES];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([LPublicData sharedUserInfo].userId == nil) {
            Alert(@"请您先登录");
        }else{
            LUserInfoViewController* tempVC = [[LUserInfoViewController alloc]init];
            tempVC.view.backgroundColor = [UIColor whiteColor];
            tempVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tempVC animated:YES];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        //LInsertLocationViewController
       // LAddressViewController* tempVC = [[LAddressViewController alloc]init];
        if ([LPublicData sharedUserInfo].userId == nil) {
            Alert(@"请您先登录");
        }else{
        LInsertLocationViewController* tempVC = [[LInsertLocationViewController alloc]init];

        tempVC.view.backgroundColor = [UIColor whiteColor];
        tempVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tempVC animated:YES];
        }
    }
    //LAboutUsViewController
    if (indexPath.section == 1 && indexPath.row == 2) {
        LAboutUsViewController* tempVC = [[LAboutUsViewController alloc]init];
        tempVC.view.backgroundColor = [UIColor whiteColor];
        tempVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tempVC animated:YES];
    }
    //LSettingViewController
    if (indexPath.section == 1 && indexPath.row == 5) {
        LSettingViewController* tempVC = [[LSettingViewController alloc]init];
        tempVC.view.backgroundColor = [UIColor whiteColor];
        tempVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tempVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.y < 0) {
        CGRect rect = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].frame;
        //point.y<0?point.y+64:64
//        rect.origin.y = point.y;
//        rect.size.height = -point.y+topCellHeigh-64>=topCellHeigh?-point.y+topCellHeigh-64:topCellHeigh;
        rect.origin.y = point.y;
        rect.size.height = -point.y+topCellHeigh;
        [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].frame = rect;
        
    }
}
#pragma mark 用户信息刷新
-(void)getUserInfo{
    NSString* userID = [LPublicData sharedUserInfo].userId;
    if (userID != nil) {
        [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:@{@"user_id":userID} paramarsSite:@"/user/getUserInfo" sucessBlock:^(id content) {
            NSError *error;
            NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"获取用户信息%@",loginDic);
            [self handleValue:loginDic];
        } failure:^(NSError *error) {
            
        }];
        
    }
}
-(void)handleValue:(NSDictionary*)tempDic{
    if (tempDic) {
        LHeaderCell *topCell = [tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        topCell.loginOrNickName.text = tempDic[@"username"];
        topCell.selfDescription.text = tempDic[@"username"];
        //topCell.userIcon.image = [UIImage imageNamed:tempDic[@"img"]];
        [topCell.userIcon sd_setImageWithURL:tempDic[@"img"] placeholderImage:[UIImage imageNamed:@""]];
    }
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
