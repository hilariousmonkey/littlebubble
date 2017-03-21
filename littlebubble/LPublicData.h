//
//  LPublicData.h
//  PetroleumBridge
//
//  Created by 罗海峰 on 16/9/2.
//  Copyright © 2016年 Aivard. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ConversationListController.h"
@interface LPublicData : NSObject


@property (strong,nonatomic) NSString* userId; //用户id

@property (nonatomic,strong) NSString *username;//用户名
@property (nonatomic,strong) NSString *password;//密码

@property (nonatomic,strong) NSString *huanxinUserName;//环信username  当前用户的手机号

@property (nonatomic,strong) NSString *userResumeNo;//用户当前默认简历号
@property (nonatomic,strong) NSString *userResumeName;//用户当前默认简历名

@property (nonatomic,strong) NSString *userLocation;//用户当前位置


//@property (nonatomic,strong) ConversationListController* HuanXinVc;
@property (nonatomic) Boolean ifChatOutDate;   //畅聊过期
@property (nonatomic) Boolean ifConsulationOutDate;   //咨询过期
@property (nonatomic) Boolean ifProjectOutDate;    //项目过期
@property (nonatomic) Boolean ifRecruitOutDate;   //招聘过期
@property (nonatomic) Boolean ifRentalOutDate;   //二手过期


+(instancetype)sharedUserInfo;
-(void)setValuesByDictionary:(NSDictionary *)dataDictionary;
-(void)saveUserInfoToSandBoxInDictionary:(NSDictionary*)dataDictionary;
-(void)loadUserInfoFromSandBox;
-(void)setLogout;
@end
