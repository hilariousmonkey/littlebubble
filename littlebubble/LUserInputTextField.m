//
//  LUserInputTextField.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/10/19.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import "LUserInputTextField.h"

@implementation LUserInputTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    button.layer.borderColor = MAINCOLOR.CGColor;
    button.layer.borderWidth =1;
    button.layer.cornerRadius =3;
    [bar addSubview:button];
    self.inputAccessoryView = bar;
    [button addTarget:self action:@selector(print)forControlEvents:UIControlEventTouchUpInside];
}
- (void) print {
    [self endEditing:YES];
    [self.superview endEditing:YES];

}
@end
