//
//  LSettingViewController.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/8/10.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import "LSettingViewController.h"

#import "LAboutUsViewController.h"
#import "UIImage+color.h"
@interface LSettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    LLoginViewController* logVc;
}

@end

@implementation LSettingViewController

-(LSettingViewController*)init :(void(^) (NSInteger))logView{
    self = [super init];
    if(self){
        _popLoginVc = logView;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    UIButton* tempBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10  , 17)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(fanHui) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem* goBack = [[UIBarButtonItem alloc]initWithCustomView:tempBtn];
    self.navigationItem.leftBarButtonItem = goBack;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = COLOR(255, 255, 255, 1);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MAINCOLOR] forBarMetrics:(UIBarMetricsDefault)];


    UITableView* tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview: tab];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tab.scrollEnabled = NO;
    //self.navigationController.navigationBar.backgroundColor = COLOR(255, 255, 255, 1);
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [self addOfFooterView];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellindentifier = @"cellindentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellindentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellindentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"关于我们";
                cell.textLabel.font = FONT(12);
                cell.imageView.image = [UIImage imageNamed:@"guanyuwomen"];
                [cell.imageView setFrame:CGRectMake(0, 0, 30, 30)];
                break;
            case 1:
                cell.textLabel.text = @"意见反馈";
                cell.textLabel.font = FONT(12);
                cell.imageView.image = [UIImage imageNamed:@"yijianfangui"];
                [cell.imageView setFrame:CGRectMake(0, 0, 30, 30)];
                break;
//            case 2:
//                cell.textLabel.text = @"清除缓存";
//                cell.textLabel.font = FONT(12);
//                cell.imageView.image = [UIImage imageNamed:@"qingchuhuancun"];
//                [cell.imageView setFrame:CGRectMake(0, 0, 30, 30)];
//                break;
//            default:
//                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        LAboutUsViewController* view = [[LAboutUsViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }
//    if (indexPath.row ==1) {
//        LFeedBackViewController* view = [[LFeedBackViewController alloc]init];
//        [self.navigationController pushViewController:view animated:YES];
//    }
//    if (indexPath.row ==2) {
//        [self clearCache];
//    }

}
-(void)fanHui{
    [self.navigationController popViewControllerAnimated:YES];

    
}

#pragma mark - FooterView
- (void)addOfFooterView
{
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    _footerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_footerView];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    UIButton *exitLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitLoginBtn.titleLabel.font = FONT(17);
    exitLoginBtn.backgroundColor = MAINCOLOR;
    [self.view addSubview:exitLoginBtn];
    [exitLoginBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(_footerView);
        make.top.equalTo(_footerView).with.offset(30);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    [exitLoginBtn setTitleColor:RGB(75, 75, 75) forState:UIControlStateNormal];
    [exitLoginBtn addTarget:self action:@selector(exitLogin1) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)exitLogin1
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定退出" message:@"" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView show];
}

#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*   if (buttonIndex == 1) {
           LPublicData* pubData = [LPublicData sharedUserInfo];
           [pubData setLogout];  //从沙盒加载数据
           NSString* c = [LPublicData sharedUserInfo].userId;
           //  [LPublicData sharedUserInfo].userId = nil;
           NSLog(@"%@  %@",[LPublicData sharedUserInfo].userId,c);
           [[NSNotificationCenter defaultCenter] postNotificationName:@"userHaveLogined" object:nil];
           EMError *error = [[EMClient sharedClient] logout:YES];
           [[UMSocialManager defaultManager] cancelAuthWithPlatform:1 completion:^(id result, NSError *error) {
           }];
           [[UMSocialManager defaultManager] cancelAuthWithPlatform:4 completion:^(id result, NSError *error) {
               
           }];
           if (!error) {
               UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"退出成功" message:@"" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
               [alertView show];
               NSLog(@"退出成功");
           }
        [self.navigationController popViewControllerAnimated:NO];
           _popLoginVc(1);
        
     } */

}

-(void)clearCache{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];

                   });
}

-(void)clearCacheSuccess
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"清理成功" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
    [alert show];
    NSLog(@"清理成功");
}
@end
