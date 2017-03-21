//
//  LUserTopView.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/19.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LUserTopView.h"
#import "LMakeOrderButton.h"
@implementation LUserTopView{
    UIButton* lastBtn;
    NSMutableArray* btnArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(LUserTopView*)init:(NSArray*)btnName trans:(void (^)(NSString* a ))trans{
    self = [super init];
    btnArray = [NSMutableArray array];
    self.trans = trans;
    int t = 0;
    for (NSString* title in btnName) {
        LMakeOrderButton* btn = [[LMakeOrderButton alloc] init:title];
        [self addSubview:btn];
        btn.tag = 100+t;
        [btnArray addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.size.sizeOffset(CGSizeMake(50, 25));
            if (t == 0) {
                make.left.equalTo(self).offset(((SCREEN_WIDTH/btnName.count)-60)/2);
            }else{
                make.left.equalTo(self).offset((SCREEN_WIDTH/btnName.count)*t+((SCREEN_WIDTH/btnName.count)-60)/2);
            }
        }];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        t++;
    }
    UIButton* tempBtn = [self viewWithTag:100];
    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempBtn setBackgroundColor:MAINCOLOR];
    lastBtn = tempBtn;
    return self;
}
-(void)btnClick:(UIButton*)btn{
    if (lastBtn) {
        [lastBtn setBackgroundColor:[UIColor whiteColor]];
        [lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [btn setBackgroundColor:MAINCOLOR];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lastBtn = btn;
    self.trans([NSString stringWithFormat:@"%ld",btn.tag-100]);
}


-(void)changeColor:(int)btnNum{
    UIButton* btn = (UIButton*)btnArray[btnNum];
    if (lastBtn) {
        [lastBtn setBackgroundColor:[UIColor whiteColor]];
        [lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [btn setBackgroundColor:MAINCOLOR];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lastBtn = btn;
}



@end
