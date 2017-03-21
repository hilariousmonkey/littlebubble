//
//  LMainViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/3.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LMainViewController.h"
#import "LFirstTableViewCell.h"
#import "LSecondTableViewCell.h"
#import "LThirdTableViewCell.h"
#import "LMakeOrderViewController.h"
#import "BaseRequest.h"
#import "LOrderGettingViewController.h"

@interface LMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray* imgArray;
@end

@implementation LMainViewController{
    UITableView* tab;
    UIScrollView* scrollView;
    UIPageControl* pageControl;
    NSDictionary* topScrollViewDataGroup;
}
-(NSArray*)imgArray{
    if (!_imgArray) {
        _imgArray = @[@"IMG_2201",@"IMG_2202",@"IMG_2203",@"IMG_2204",@"IMG_2205"];
    }
    return _imgArray;
}
-(void)viewWillAppear:(BOOL)animated{
    //wsssssss
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:nil paramarsSite:@"/clientData/bannerImg" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"登录认证信息%@",loginDic);
        if (loginDic.count) {
            topScrollViewDataGroup = [NSDictionary dictionary];
            topScrollViewDataGroup = loginDic;
            [tab reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor purpleColor];
    tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    [self.view addSubview:tab]; 
    tab.delegate = self;
    tab.dataSource = self;
    tab.tableFooterView = [UIView new];
    [self initUI];
}

-(void)initUI{
    UIButton* rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    [rightBtn setTitle:@"测试" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"QQ20170103-151146.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //self.navigationItem.rightBarButtonItem = rightBarBtn;//设置导航栏右按键
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    [leftBtn setTitle:@"测试" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"QQ20170103-151146.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键

}
#pragma mark Tabview初始化
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 2) {
//        return 5;
//    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cellIdentifier";
    
    UITableViewCell* cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld",cellIdentifier,indexPath.row]];
   /* 
    }*/
    if (!cell) {
        if (indexPath.section==0) {
            cell = [[LFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"%@%ld",cellIdentifier,indexPath.row]];
        }else if (indexPath.section == 1){
            cell = [[LSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"%@%ld",cellIdentifier,indexPath.row]];
        }else{
            cell = [[LThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"%@%ld",cellIdentifier,indexPath.row]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        if ([cell respondsToSelector:@selector(initData:)]&&topScrollViewDataGroup.count>=1) {
            [cell performSelector:@selector(initData:) withObject:topScrollViewDataGroup];
        }
    }
       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    switch (indexPath.section) {
        case 0:
            return 150*SCREENSCAL;
            break;
        case 1:
            return 73*SCREENSCAL;
            break;
        default:
            break;
    }
    return 320*SCREENSCAL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   /* if (indexPath.section ==1) {
       LMakeOrderViewController* c = [[LMakeOrderViewController alloc]init];
        c.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:c animated:YES];
    }*/
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
