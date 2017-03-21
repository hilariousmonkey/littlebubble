//
//  LOrderViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/3.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LOrderViewController.h"
#import "LOrderDetailViewController.h"
#import "BaseRequest.h"
@interface LOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation LOrderViewController{
    UIScrollView *bigScrollview;
    UIView* topView ,* selectedView,*line1,*line2;
    NSArray* array,*cellClassArray;
    UIButton* selectedBtn;
    CGFloat tabHeigh;
    NSMutableArray* TT,*cellInitDataArray,*receiveCellDataArray,*sendCellDataArray,*verifyDataArray,*allOderArray;  //cellInitDataArray-各个cell数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTopView];
    [self initUI];
}

//初始化顶部标题view
-(void)initTopView
{
    float topScrollHeight = 40;
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, topScrollHeight)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topView];
    array = [[NSArray alloc]initWithObjects:@"全部",@"待收货",@"待发货",@"待确认",nil];
    cellClassArray = [NSArray arrayWithObjects:@"LWaitReceiveCell",@"LWaitReceiveCell",@"LWaitSendCell",@"LWaitVerifyCell", nil];
    allOderArray = [[NSMutableArray alloc]initWithObjects:@{@"cellIcon":@"短信.png",@"cellImg":@"店铺图片.png",@"cellName":@"测试订单号1",@"orderDate":@"2017-02-20",@"orderNo":@"2700111000041",@"orderState":@"当前状态：待接单"}, nil];
    receiveCellDataArray = [[NSMutableArray alloc]initWithObjects:@{@"cellIcon":@"短信.png",@"cellImg":@"店铺图片.png",@"cellName":@"测试订单号2",@"orderDate":@"2017-02-20",@"orderNo":@"2700111000041",@"orderState":@"当前状态：待接单"}, nil];
    sendCellDataArray = [[NSMutableArray alloc]initWithObjects:@{@"cellIcon":@"短信.png",@"cellImg":@"店铺图片.png",@"cellName":@"测试订单号3",@"orderDate":@"2017-02-20",@"orderNo":@"2700111000041",@"orderState":@"当前状态：待接单"}, nil];
    verifyDataArray = [[NSMutableArray alloc]initWithObjects:@{@"cellIcon":@"短信.png",@"cellImg":@"店铺图片.png",@"cellName":@"测试订单号4",@"orderDate":@"2017-02-20",@"orderNo":@"2700111000041",@"orderState":@"当前状态：待接单"}, nil];
    cellInitDataArray = [[NSMutableArray alloc]initWithObjects:allOderArray,receiveCellDataArray,sendCellDataArray,verifyDataArray, nil];
    float width = SCREEN_WIDTH/array.count;
    selectedView = [[UIView alloc]initWithFrame:CGRectMake((width-[array[0] length]*14)/2, 64+40-3, [array[0] length]*14, 1)]; //下方滑动的横线
    selectedView.backgroundColor = MAINCOLOR;
    [self.view addSubview:selectedView];
    line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];  //顶部view两条横线
    line1.backgroundColor = RGB(221, 221, 221);
    line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40-1, SCREEN_WIDTH, 1)];
    line2.backgroundColor = RGB(221, 221, 221);
    /*********往topview里添加按钮*********/
    for (int i = 0; i<array.count; i++) {
        NSString *title = [array objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width*i,0 , width, topScrollHeight);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        btn.titleLabel.font = FONT(14);
        [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [topView addSubview:btn];
        if (i==0) {
            selectedBtn = btn;
            selectedBtn.selected = YES;
        }
    }
    
    [topView addSubview:line1];
    [topView addSubview:line2];
/*
    首次加载点击按钮
 */
    UIButton *btn = [self.view viewWithTag:100];
    [self topBtnClick:btn];

}

/*********初始化scrollview*********/
-(void)initUI
{
    TT = [NSMutableArray array];
    bigScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64+40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    bigScrollview.contentSize = CGSizeMake(SCREEN_WIDTH *4, SCREENH_HEIGHT);
    bigScrollview.backgroundColor =COLOR(245, 246, 247, 1);
    bigScrollview.pagingEnabled = YES;
    bigScrollview.bounces = NO;
    bigScrollview.delegate = self;
    bigScrollview.scrollEnabled = NO;
    [self.view addSubview:bigScrollview];
    [bigScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT));
        make.left.equalTo(self.view);
    }];
    //插入tableview
    for (int i = 0; i<4; i++) {
        tabHeigh = bigScrollview.frame.size.height;
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *i,0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
        [TT addObject:tableView];   //往可变数组TT里添加数据，方便后面查找tableview的序号；
        tableView.tag = i+500;
        tableView.delegate = self;
        tableView.dataSource = self;
       // tableView.tableFooterView = [[UIView alloc]init];
        [bigScrollview addSubview:tableView];
       /* [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bigScrollview);
            make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT));
            make.left.equalTo(self.view).offset(SCREEN_WIDTH*i);
        }];*/
       // tab = tableView;    //记录最近一次新建的tableview
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator  = YES;
    }
}

#pragma  mark--ScrollView数据源协议
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:bigScrollview]) {
        int contentoffset = scrollView.contentOffset.x;
        int numOfTable = contentoffset/SCREEN_WIDTH;
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+numOfTable];
        [self topBtnClick:btn];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        return;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y<0) {
        return;
    }
}

#pragma mark -- TableView 数据源协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tabNo = [TT indexOfObject:tableView];
    NSString* cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%ld%ld",tabNo,indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(cellClassArray[tabNo]) alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([cell respondsToSelector:@selector(initData:)]) {
        [cell performSelector:@selector(initData:) withObject:cellInitDataArray[tabNo][indexPath.row]];
    }
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tabNo = [TT indexOfObject:tableView];
    return [cellInitDataArray[tabNo] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)topBtnClick:(UIButton *)sender
{
    selectedBtn.selected = NO;
    selectedBtn = sender;
    selectedBtn.selected = YES;
    float width = SCREEN_WIDTH/4;
    [bigScrollview setContentOffset:CGPointMake(SCREEN_WIDTH*(sender.tag-100),0) animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        selectedView.frame = CGRectMake(width*(sender.tag-100)+(width-[array[sender.tag-100] length]*14)/2, 64+40-3, [array[sender.tag-100] length]*14, 1); //根据顶部button标题字数调整selectedview的长短
    }];
    if (sender.tag-100 == 0) {
        [self getUserAllOrder];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LOrderDetailViewController* tempVC = [[LOrderDetailViewController alloc]init];
    tempVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tempVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUserAllOrder{
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:@{@"userId":[LPublicData sharedUserInfo].userId,@"type":@"1",@"page":@"1"} paramarsSite:@"/order/orderAll" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",loginDic);

        if (loginDic) {
            [allOderArray removeAllObjects];
            for (NSDictionary* tempDic in loginDic[@"list"]) {
                [allOderArray addObject:@{@"cellIcon":@"短信.png",@"cellImg":tempDic[@"img"],@"cellName":tempDic[@"shop_name"],@"orderDate":tempDic[@"start_time"],@"orderNo":tempDic[@"id"],@"orderState":@"当前状态：待接单"}];
            }
            UITableView* tempTab = TT[0];
            [tempTab reloadData];
        }
        
    } failure:^(NSError *error) {
        Alert(@"获取订单信息失败");
        
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
