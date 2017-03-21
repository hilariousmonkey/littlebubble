//
//  LPublicData.m
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/9/2.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import "LPublicData.h"

@implementation LPublicData
/**用户信息单例*/
LPublicData *userInfo = nil;
+(instancetype)sharedUserInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[self alloc]init];
        //userInfo.userId = @"7";
        userInfo.ifProjectOutDate = YES;
        userInfo.ifRentalOutDate = YES;
        userInfo.ifRecruitOutDate = YES;
        userInfo.ifConsulationOutDate = YES;
        userInfo.ifChatOutDate = YES;
    });
    return userInfo;
}

/**请求到的用户信息数据*/
-(void)setValuesByDictionary:(NSDictionary *)dataDictionary
{
    [self saveUserInfoToSandBoxInDictionary:dataDictionary];
    self.userId = dataDictionary[@"id"];
    self.username = dataDictionary[@"username"];
    self.password = dataDictionary[@"password"];
}

/**保存账号和密码, 以及信息*/
-(void)saveUserInfoToSandBoxInDictionary:(NSDictionary*)dataDictionary{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:self.password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:dataDictionary forKey:@"userInfo"];
}

/**从userdefaults里读取数据*/
-(void)loadUserInfoFromSandBox
{
    NSDictionary *dataDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
   [self setValuesByDictionary:dataDictionary];
}


/**设置退出登录, 数据清空*/
-(void)setLogout
{   self.userId = nil;
    self.username = nil;
    self.password = nil;
    self.userResumeName = nil;
    self.userResumeNo = nil;
    self.userLocation = nil;
    userInfo.ifProjectOutDate = YES;
    userInfo.ifRentalOutDate = YES;
    userInfo.ifRecruitOutDate = YES;
    userInfo.ifConsulationOutDate = YES;
    userInfo.ifChatOutDate = YES;
//    if (_HuanXinVc) {
  //      [_HuanXinVc removeAllConversation];
  //  }
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userInfo"];
}


@end
