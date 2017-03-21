//
//  DZSelectorView.h
//  时间选择器
//
//  Created by 代纵纵 on 16/1/20.
//  Copyright (c) 2016年 daizongzong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZSelectorView : UIView
@property(strong,nonatomic) void (^translate)(NSString* c);
- (id)initWithFrame:(CGRect)frame trans:(void (^)(NSString* a))d;
@end
