//
//  LAddressTableViewCell.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/15.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LAddressTableViewCell : UITableViewCell
@property(nonatomic,strong) void(^ transData )(NSString *a) ;
@property(nonatomic,strong) void(^ transData1)(NSString *a);
@property(nonatomic,strong) NSString *cellId;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *userPhone;
@property(nonatomic,strong) NSString *userAddress;

@property float lat;//纬度
@property float lng;//经度
@property int ifDefaultLocation; //是否为默认地址
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier trans:(void(^)(NSString *))d trans1:(void(^)(NSString *))d1;
@end
