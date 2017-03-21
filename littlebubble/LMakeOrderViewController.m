//
//  LMakeOrderViewController.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/17.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LMakeOrderViewController.h"
#import "LMakeOrderButton.h"
#import "LUserTopView.h"
#import "LMakeOrderCollectionViewCell.h"

@interface LMakeOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) NSArray* YI;
@property (strong,nonatomic) NSArray* XIE;
@property (strong,nonatomic) NSArray* BAO;
@property (strong,nonatomic) NSArray* SHE;
@property (strong,nonatomic) NSArray* JU;

@end

@implementation LMakeOrderViewController{
    UIScrollView *bigScrollview,*yiScrollView,*xieScrollView,*baoScrollView,*sheScrollView,*juScrollView;
    UIView* topView ,* selectedView,*line1,*line2;
    NSArray* array;
    UIButton* selectedBtn;
    CGFloat tabHeigh;
    NSMutableArray* TT,*collectionArray,*initDataYi,*initDataXie,*initDataBao,*initDataShe,*initDataJU;
    NSArray* titleArray ;
    NSMutableArray *scrollViewArray,*topScrollView;
    
    int userCurrentSelectIndex;//用户当前选择的collectionviewBtn序号
    int laji;
}

-(NSArray*)YI{
    if (!_YI) {
        _YI =@[@"上衣1",@"大衣",@"裤子",@"配件"];
    }
    return _YI;
}
-(NSArray*)XIE{
    if (!_XIE) {
        _XIE =@[@"上衣2",@"大衣",@"裤子",@"配件"];
    }
    return _XIE;
}
-(NSArray*)BAO{
    if (!_BAO) {
        _BAO =@[@"上衣3",@"大衣",@"裤子",@"配件"];
    }
    return _BAO;
}
-(NSArray*)SHE{
    if (!_SHE) {
        _SHE =@[@"上衣4",@"大衣",@"裤子",@"配件"];
    }
    return _SHE;
}
-(NSArray*)JU{
    if (!_JU) {
        _JU =@[@"上衣5",@"大衣",@"裤子",@"配件"];
    }
    return _JU;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单";
    titleArray = @[self.YI,self.XIE,self.BAO,self.SHE,self.JU];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTopView];
    [self initUI];
    
  //  [self topBtnClick:[self.view viewWithTag:100]];
}

//初始化顶部标题view
- (void)initTopView
{
    TT = [NSMutableArray array];
    collectionArray = [NSMutableArray array];
    initDataYi = [NSMutableArray array];
    initDataXie = [NSMutableArray array];
    initDataBao = [NSMutableArray array];
    initDataShe = [NSMutableArray array];
    initDataJU = [NSMutableArray array];
    topScrollView = [NSMutableArray array];
    initDataYi = [NSMutableArray arrayWithObjects: @{@"imgName":@"IMG_2201",@"imgTitle":@"衣",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"衣1",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"衣2",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"衣3",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"衣4",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"衣5",@"imgPrice":@"200.0"} ,nil];
    initDataXie = [NSMutableArray arrayWithObjects: @{@"imgName":@"IMG_2201",@"imgTitle":@"鞋",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"鞋1",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"鞋2",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"鞋3",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"鞋4",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"鞋5",@"imgPrice":@"200.0"} ,nil];
    initDataBao = [NSMutableArray arrayWithObjects: @{@"imgName":@"IMG_2201",@"imgTitle":@"包",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"包1",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"包2",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"包3",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"包4",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"包5",@"imgPrice":@"200.0"} ,nil];
    initDataShe = [NSMutableArray arrayWithObjects: @{@"imgName":@"IMG_2201",@"imgTitle":@"奢",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"奢1",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"奢2",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"奢3",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"奢4",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"奢5",@"imgPrice":@"200.0"} ,nil];
    initDataJU = [NSMutableArray arrayWithObjects: @{@"imgName":@"IMG_2201",@"imgTitle":@"居",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"居1",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"居2",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"居3",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"居4",@"imgPrice":@"200.0"},@{@"imgName":@"IMG_2201",@"imgTitle":@"居5",@"imgPrice":@"200.0"} ,nil];
    TT = [NSMutableArray arrayWithObjects:initDataYi,initDataXie,initDataBao,initDataShe,initDataJU,nil];
    float topScrollHeight = 40;
    userCurrentSelectIndex = 0;
    self.navigationController.navigationBar.backgroundColor = MAINCOLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"专业洗护";
    
    [self.navigationController.navigationBar setTintColor:MAINCOLOR];
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, topScrollHeight)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topView];
    array = [[NSArray alloc]initWithObjects:@"衣",@"鞋",@"包",@"奢",@"居",nil];
    float width = SCREEN_WIDTH/array.count;
    selectedView = [[UIView alloc]initWithFrame:CGRectMake((width-[array[0] length]*14)/2, 64+40-3, [array[0] length]*14, 2)];                     //下方滑动的横线
    selectedView.backgroundColor = MAINCOLOR;
    [self.view addSubview:selectedView];
    line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];  //顶部view两条横线
    //[topView addSubview:line1];
    line1.backgroundColor = [UIColor blueColor];
    line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40-1, SCREEN_WIDTH, 1)];
    //[topView addSubview:line2];
    line2.backgroundColor = [UIColor blueColor];
    /*********往topview里添加按钮*********/
    for (int i = 0; i<array.count; i++) {
        NSString *title = [array objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width*i,0 , width, topScrollHeight);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT(14);
        [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [topView addSubview:btn];
        if (i==0) {
            selectedBtn = btn;
            selectedBtn.selected = YES;
        }
    }
}
/*********初始化scrollview*********/
-(void)initUI
{
    bigScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64+40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    yiScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    xieScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    baoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2,40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    sheScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3,40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    juScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*4,40, SCREEN_WIDTH, SCREENH_HEIGHT)];
    yiScrollView.tag = 200;
    xieScrollView.tag = 201;
    baoScrollView.tag = 202;
    sheScrollView.tag = 203;
    juScrollView.tag = 204;
    
    scrollViewArray = [NSMutableArray array];
    scrollViewArray = [NSMutableArray arrayWithObjects:yiScrollView,xieScrollView,baoScrollView,sheScrollView,juScrollView, nil];      //  嵌套ScrollView的队列
    bigScrollview.contentSize = CGSizeMake(SCREEN_WIDTH *4, 0);
    bigScrollview.backgroundColor =COLOR(245, 246, 247, 1);
    bigScrollview.pagingEnabled = YES;
    bigScrollview.bounces = NO;
    bigScrollview.delegate = self;
    bigScrollview.scrollEnabled = NO;
    [self.view addSubview:bigScrollview];
    for (int i = 0; i<5; i++) {
        int t;
            LUserTopView* topSelecView = [[LUserTopView alloc] init:titleArray [i] trans:^(NSString *a) {     //  [i]是几号titleArray
                [self btnClick:i btnIndex:[a intValue]];
            }];
            [bigScrollview addSubview:topSelecView];
            [topSelecView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, 80));
                make.top.equalTo(bigScrollview);
                make.left.equalTo(bigScrollview).offset(SCREEN_WIDTH*i);
            }];
            t++;
        [topScrollView addObject:topSelecView];
        //添加内部滑动式图
        UIScrollView* tempView = scrollViewArray[i];                     // 从队列里一次取一个
        tempView.contentSize = CGSizeMake(SCREEN_WIDTH *4, 0);
        tempView.backgroundColor =COLOR(245, 246, 247, 1);
        tempView.pagingEnabled = YES;
        tempView.bounces = NO;
        tempView.delegate = self;
        tempView.scrollEnabled = YES;
     //   tempView.backgroundColor = [UIColor blackColor];
        [bigScrollview addSubview:tempView];
        //添加内部collectionView
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/3-3, SCREEN_WIDTH/3);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        int countNum = 0;
        for (NSString* c in titleArray[i]) {
            UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *countNum, 40, SCREEN_WIDTH, SCREENH_HEIGHT) collectionViewLayout:layout];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.tag = i+300;
            collectionView.showsVerticalScrollIndicator = YES;
            collectionView.scrollEnabled = YES;
            [collectionArray addObject:collectionView];  //collectionview的数组
            [tempView addSubview:collectionView];
            [collectionView registerClass:[LMakeOrderCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
            countNum++;
        }
    }        //滑动页面
     [bigScrollview setContentOffset:CGPointMake(0, 0)];
}

#pragma  mark--ScrollView数据源协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:bigScrollview]) {
        int contentoffset = scrollView.contentOffset.x;
        int numOfTable = contentoffset/SCREEN_WIDTH;
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+numOfTable];
        [self topBtnClick:btn];
    }else{
        int contentoffset = scrollView.contentOffset.x;
        int numOfTable = contentoffset/SCREEN_WIDTH;
        int scrollViewNo = scrollView.frame.origin.x/SCREEN_WIDTH;
        
        LUserTopView* userTopView = topScrollView[scrollViewNo];
        [userTopView changeColor:numOfTable];
        userCurrentSelectIndex = numOfTable;

      //  [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*numOfTable, 0) animated:YES];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LMakeOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(initData:)])
    {
        [cell performSelector:@selector(initData:) withObject:TT[collectionView.tag - 300][userCurrentSelectIndex]];
    }
    cell.layer.borderColor=RGB(221, 221, 221).CGColor;
    cell.layer.borderWidth=0.1;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)topBtnClick:(UIButton *)sender
{
    selectedBtn.selected = NO;
    selectedBtn = sender;
    selectedBtn.selected = YES;
    float width = SCREEN_WIDTH/5;
    [bigScrollview setContentOffset:CGPointMake(SCREEN_WIDTH*(sender.tag-100), 0) animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        selectedView.frame = CGRectMake(width*(sender.tag-100)+(width-[array[sender.tag-100] length]*14)/2, 64+40-3, [array[sender.tag-100] length]*14, 1); //根据顶部button标题字数调整selectedview的长短
    }];
}

-(void)btnClick:(int)c btnIndex:(int)index{
    UICollectionView* tempColletionView = [self.view viewWithTag:300+c];
    UIScrollView* tempScroll = (UIScrollView*)scrollViewArray[c];
    [tempScroll setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
    NSLog(@"%d,,,,,%d",c,index);
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
