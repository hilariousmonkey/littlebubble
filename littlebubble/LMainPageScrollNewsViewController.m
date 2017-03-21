//
//  LMainPageScrollNewsViewController.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/9/14.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import "LMainPageScrollNewsViewController.h"
#import "BaseRequest.h"
#import "LPublicData.h"
@implementation LMainPageScrollNewsViewController{
    NSString* newsIdNo;
}

-(instancetype)initWithString:(NSString*)newsId {
    self = [super init];
    if (self) {
        self.navigationController.navigationBarHidden = NO;
        [self setNav];
        newsIdNo = newsId;
     //  [self creatWebView];

    }
    return  self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWebView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor = COLOR(255, 255, 255, 1);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden=NO;
}
-(void)setNav{
    


    self.navigationItem.title = @"新闻详情";
    UIButton* tempBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 17)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(fanHui) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem* goBack = [[UIBarButtonItem alloc]initWithCustomView:tempBtn];
    self.navigationItem.leftBarButtonItem = goBack;
 /*   if ([LPublicData sharedUserInfo].userId != nil) {
        UIButton* tempBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        [tempBtn1 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [tempBtn1 addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem* goBack1 = [[UIBarButtonItem alloc]initWithCustomView:tempBtn1];
        self.navigationItem.rightBarButtonItem = goBack1;
    }*/    //该页面不能收藏
  
    
}

-(void)creatWebView{
    UIWebView* webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview: webView];
   // webView.backgroundColor  = [UIColor redColor];
    //webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.dataDetectorTypes = YES;//自动检测网页上的电话号码，单击可以拨打
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.76.97.20/syqapp/index.php/home/Headlines/carousel/?id=%@",newsIdNo]];//创建URL
    NSLog(@"%@",url);
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}

-(void)collection{
    //招聘接口
    NSDictionary* c = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"type",[LPublicData sharedUserInfo].userId,@"uid",newsIdNo,@"id",nil];
    [BaseRequest requestWithMethodResponseStringResult:BASEURL paramars:c paramarsSite:@"/login/collection" sucessBlock:^(id content) {
        NSError *error;
        NSDictionary *indexDic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
        NSNumber* msg = indexDic[@"msg"];
        if ([msg  isEqual:@"1"]) {
            NSLog(@"收藏成功");
            
        }
        else if([msg  isEqual:@"2"]){
            NSLog(@"收藏失败");
        }else{
            NSLog(@"已收藏");
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alertView show];
        
    }];
    
    
}


-(void)fanHui
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
