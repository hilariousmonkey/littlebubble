//
//  LUserTopView.h
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/19.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUserTopView : UIView
@property(strong,nonatomic) void(^trans)(NSString* c);
-(LUserTopView*)init:(NSArray*)btnName trans:(void (^)(NSString*a ))trans;
-(void)changeColor:(int)btnNum;
@end
