//
//  LMapSelectViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/2/23.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LMapSelectViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "LUserInputTextField.h"
#import "BaseRequest.h"
@interface LMapSelectViewController ()<AMapNearbySearchManagerDelegate,AMapSearchDelegate,MAMapViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) AMapSearchAPI *search;
@end

@implementation LMapSelectViewController{
    MAMapView *_mapView ;
    AMapNearbySearchManager *_nearbyManager;
   // AMapNearbySearchRequest *request;
    AMapPOIKeywordsSearchRequest *request;
    LUserInputTextField *searchTextField ;
    UIButton* addClassificationBtn,*searchBtn;
    UITableView *tab;
    NSMutableArray *dataArray;
}
-(instancetype)init :(void (^) (NSDictionary* a)) transData{
   self = [super init];
    if (self) {
        self.trans = transData;
    }
    return self;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [NSMutableArray array];
    [AMapServices sharedServices].apiKey = @"2ddddd87e03ef92ae7692f30506cf84a";
    [AMapServices sharedServices].enableHTTPS = YES;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;//设置导航栏右按键
    
    tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    //request.keywords            = @"北京大学";
    //request.city                = @"北京";
    //request.types               = @"高等院校";
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [self createTitleView];
    // Do any additional setup after loading the view.
    
}
- (void)createTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    //搜索框
    searchTextField = [[LUserInputTextField alloc]initWithFrame:CGRectMake(15, 7, SCREEN_WIDTH-60-15, 30)];
    searchTextField.backgroundColor = RGB(221, 221, 221);
    searchTextField.placeholder = @"输入关键字";
    searchTextField.font = FONT(14);
    searchTextField.layer.cornerRadius = 2;
    searchTextField.delegate = self;
    //  [searchTextField addTarget:self action:@selector(ifCouldSearch:) forControlEvents:UIControlEventEditingChanged];
    //[searchTextField addTarget:self action:@selector(searchProblem) forControlEvents:UIControlEventTouchDown];
    UIImageView *searchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 15, 15)];
    searchIcon.image = [UIImage imageNamed:@"搜索.png"];
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.leftView = searchIcon;
    [titleView addSubview:searchTextField];
    //发布按钮
    searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 7, 60, 30)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = FONT(14);
    [searchBtn setTitleColor:[UIColor whiteColor
                              ] forState:UIControlStateNormal];
    [titleView addSubview:searchBtn];
    [searchBtn setBackgroundColor:MAINCOLOR];
    [searchBtn addTarget:self action:@selector(searchMap) forControlEvents:UIControlEventTouchDown];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView);
        make.right.equalTo(titleView);
        make.size.sizeOffset(CGSizeMake(60, 30));
    }];
    //searchBtn.hidden = YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@,%ld",@"cellIdentifier",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = FONT(14);
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.textLabel.text = dataArray[indexPath.row][@"name"];
    cell.detailTextLabel.text = dataArray[indexPath.row][@"address"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tempCell = [tableView cellForRowAtIndexPath:indexPath];
    self.trans(@{@"street":tempCell.textLabel.text,@"detailLocation":tempCell.detailTextLabel.text,@"longitude":dataArray[indexPath.row][@"longitude"],@"latitude":dataArray[indexPath.row][@"latitude"]});
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchMap{
    if (searchTextField.text.length) {
        dataArray = [NSMutableArray array];
        NSString* keyWords = searchTextField.text;
        request.keywords            = keyWords;
        request.city                = @"成都";
        //request.types               = @"高等院校";
        [self.search AMapPOIKeywordsSearch:request];
    }
}

/* POI 搜索回调. */

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        [dataArray removeAllObjects];
        [tab reloadData];
        return;
    }else{
        for (AMapPOI* pOI in response.pois) {
            NSLog(@"%@ ++++%@",pOI.name,pOI);
            [dataArray addObject:@{@"name":pOI.name,@"address":pOI.address,@"latitude":[NSString stringWithFormat:@"%f",pOI.location.latitude],@"longitude":[NSString stringWithFormat:@"%f",pOI.location.longitude]}];
        }
        [tab reloadData];
    }
    //解析response获取POI信息，具体解析见 Demo
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fanHui{
    [self.navigationController popViewControllerAnimated:YES];
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
