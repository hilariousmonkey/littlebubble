//
//  LFirstTableViewCell.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/4.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LFirstTableViewCell.h"
#import "LMainPageScrollNewsViewController.h"
@implementation LFirstTableViewCell{
    SDCycleScrollView *cycleScrollView;
    NSMutableArray* imageArray,*idArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self layout];
    return self;
}

-(void)layout{
    //cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) imageNamesGroup:imageArray];
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) imageURLStringsGroup:imageArray];
    cycleScrollView.delegate = self;
    cycleScrollView.backgroundColor = [UIColor blackColor];
    cycleScrollView.showPageControl = YES;
   // cycleScrollView.contentMode =UIViewContentModeScaleAspectFill;
    [self addSubview:cycleScrollView];
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"you selected NO.%ld",(long)index);
    if (idArray.count > index) {
        LMainPageScrollNewsViewController* tempVC = [[LMainPageScrollNewsViewController alloc]initWithString:idArray[index]];
        NSLog(@"%@",idArray);
        tempVC.hidesBottomBarWhenPushed = YES;
       // [(UINavigationController*)tempC pushViewController:tempVC animated:NO];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)initData:(NSArray*)initData{
    if (initData) {
        imageArray = [NSMutableArray array];
        idArray = [NSMutableArray array];
        if ( initData.count >= 1 ) {
            for (NSDictionary* tempDic in initData)
            {
                NSString* compleUrl = [NSString stringWithFormat:@"%@",tempDic[@"img"]];
                [imageArray addObject:compleUrl];
                [idArray addObject:tempDic[@"id"]];
            }
            //[imgAry addObject:imgAry[1]];
            if (imageArray.count >0) {
                NSLog(@"%@",imageArray);
                cycleScrollView.imageURLStringsGroup = imageArray;
            }
        }
      }
}
@end
