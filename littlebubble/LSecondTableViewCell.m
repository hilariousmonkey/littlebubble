//
//  LSecondTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LSecondTableViewCell.h"
#import "LSecondTableCollectionViewCell.h"
#import "LMakeOrderViewController.h"
@implementation LSecondTableViewCell{
    UICollectionView* collectionViewer; //容器
    UIViewController* tempViewcontroller;
 }
-(NSArray*)cellNameAndImg{
    if (!_cellNameAndImg) {
        _cellNameAndImg = @[@{@"imageName":@"衣.png",@"labText":@"衣"},@{@"imageName":@"鞋.png",@"labText":@"鞋"},@{@"imageName":@"包.png",@"labText":@"包"},@{@"imageName":@"奢.png",@"labText":@"奢"},@{@"imageName":@"居.png",@"labText":@"居"}];
    }
     return _cellNameAndImg;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self layout];
    return self;
}

-(void)layout{
     //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumInteritemSpacing = 50;
    collectionViewer = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) collectionViewLayout:layout];
    collectionViewer.delegate = self;
    collectionViewer.dataSource = self;
    collectionViewer.contentInset = UIEdgeInsetsMake(10, 20, 0, 0);
    collectionViewer.backgroundColor = [UIColor whiteColor];
    [collectionViewer registerClass:[LSecondTableCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self addSubview:collectionViewer];

}
/*- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // 注意，这里默认会在top有+64的边距，因为状态栏+导航栏是64.
    // 因为我们常常把[[UIScreen mainScreen] bounds]作为CollectionView的区域，所以苹果API就默认给了+64的EdgeInsets，这里其实是一个坑，一定要注意。
    // 这里我暂时不用这个边距，所以top减去64
    // 所以这是就要考虑你是把Collection从屏幕左上角(0,0)开始放还是(0,64)开始放。
    return UIEdgeInsetsMake(0, 30, 0, 0);
}*/
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cellIdentifier";
    LSecondTableCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
//    UIImageView* image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    image.image = [UIImage imageNamed:_cellNameAndImg[indexPath.row][@"imageName"]];
//    [cell.contentView addSubview:image];
  BOOL isRespond =  [cell respondsToSelector:@selector(setImageName:)];
    if (isRespond) {
        [cell performSelector:@selector(setImageName:)withObject:self.cellNameAndImg[indexPath.row]];
    }
    
    return cell;
    
}
-(void)didMoveToSuperview{

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"you selected NO.%ld",indexPath.row);
    LMakeOrderViewController* c = [[LMakeOrderViewController alloc]init];
    c.hidesBottomBarWhenPushed = YES;
   // [tempViewcontroller = [self findVC:self];
    NSLog(@"%@",tempViewcontroller);
    tempViewcontroller = [self findVC:self];

    [tempViewcontroller.navigationController pushViewController:c animated:YES];

}
-(UIViewController*)findVC:(UIView*)tempView{
    UIViewController* findView = [[UIViewController alloc]init];
    while (tempView) {
        if ([tempView.nextResponder isKindOfClass:[UIViewController class]]) {
            findView = (UIViewController*)tempView.nextResponder;
            return findView;
        }else{
            tempView =(UIView*) tempView.nextResponder;
        }
    }
    return findView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
