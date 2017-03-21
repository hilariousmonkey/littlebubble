//
//  LMakeOrderButton.m
//  littlebubble
//
//  Created by  罗海峰 on 2017/1/17.
//  Copyright © 2017年  罗海峰. All rights reserved.
//

#import "LMakeOrderButton.h"

@implementation LMakeOrderButton

-(instancetype)init :(NSString*) buttonName{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 4;
        [self setTitle:buttonName forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
