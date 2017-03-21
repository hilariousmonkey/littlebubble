//
//  LLoaddingViewController.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/9/12.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import "LLoaddingViewController.h"
//#import "BaseRequest.h"
@implementation LLoaddingViewController{
    NSString *time;
    UILabel* timerLabel;
    __block int timeout;
    UIImageView *imageView;
    BOOL ifHandEnd;
  }
-(id)initWithString:(NSString*)string
{
    if ([super init]) {
        _imgUrlString = string;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    [self.view addSubview:imageView];
    imageView.contentMode= UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //获取广告图片展示
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"]];
    time = @"5";
    
    //广告展示时间结束, block回调
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(change)];
    
    
    
    UIImageView *btnBackGround = [[UIImageView alloc]init];
    btnBackGround.backgroundColor = RGBA(221, 221, 221, 0.8);
    [self.view addSubview: btnBackGround];
    btnBackGround.layer.cornerRadius = 6;
    [btnBackGround addGestureRecognizer:tap];
    [btnBackGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(80, 30));
    }];
    timerLabel = [[UILabel alloc]init];
    [btnBackGround addSubview:timerLabel ];
    [timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(btnBackGround);
        make.size.sizeOffset(CGSizeMake(80, 30));
    }];
    timerLabel.font = FONT(10);
    timerLabel.textColor = [UIColor whiteColor];
    [timerLabel addGestureRecognizer:tap];
    timerLabel.userInteractionEnabled = YES;
    timerLabel.superview.userInteractionEnabled = YES;
    timerLabel.textAlignment = NSTextAlignmentCenter;
    [self timerSet];
    
}
/**数秒钟后, 更换根视图,跳转到主页*/
-(void)change
{
    ifHandEnd = YES;
    timeout = 0;
    _changeRoot();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)timerSet{
    /*******  验证码倒计时   *******/
    timeout= [time intValue]; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                timerLabel.text = @"完成";
                if (!ifHandEnd) {
                    [self change];
                }
             });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                timerLabel.text = [NSString stringWithFormat:@"%@秒  跳过",strTime];
                [UIView commitAnimations];
                if (timeout == 1) {
                    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
                }
                //hqBtn.backgroundColor = [UIColor grayColor];
            });
            timeout--;
          
        }
    });
    dispatch_resume(_timer);
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        imageView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
     // [imageView removeFromSuperview];
    }];
}

@end
