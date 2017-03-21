//
//  BaseRequest.h
//  ShinePhone
//
//  Created by LinKai on 15/5/19.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock) (id content);

@interface BaseRequest : NSObject

+ (void)requestWithMethodResponseStringResult:(NSString *)method
                                     paramars:(NSDictionary *)paramars
                                 paramarsSite:(NSString *)site
                                  sucessBlock:(successBlock)successBlock
                                      failure:(void (^)(NSError * error))failure;

+ (void)requestWithMethodResponseJsonByGet:(NSString *)method
                                  paramars:(NSDictionary *)paramars
                              paramarsSite:(NSString *)site
                               sucessBlock:(successBlock)successBlock
                                   failure:(void (^)(NSError * error))failure;

+ (void)requestWithMethodForFile:(NSString *)method
                        paramars:(NSDictionary *)paramars
                    paramarsSite:(NSString *)site
                        fileDict:(NSMutableDictionary *)dataDict
                    successBlock:(successBlock)successBlock
                         failure:(void (^)(NSError *))failure;

+ (void)requestWithMethodForAudio:(NSString *)method
                         paramars:(NSDictionary *)paramars
                     paramarsSite:(NSString *)site
                         fileDict:(NSMutableDictionary *)dataDict
                     successBlock:(successBlock)successBlock
                          failure:(void (^)(NSError *))failure;

//+ (void)requestWithMethodForFile:(NSString *)method
//                        paramars:(NSDictionary *)paramars
//                    paramarsSite:(NSString *)site
//                        fileDict:(NSMutableDictionary *)dataDict
//                    withProgress:(UIProgressView *)progressView
//                    successBlock:(successBlock)successBlock
//                         failure:(void (^)(NSError *))failure;
//
//+ (void)requestWithMethodForAudio:(NSString *)method
//                         paramars:(NSDictionary *)paramars
//                     paramarsSite:(NSString *)site
//                         fileDict:(NSMutableDictionary *)dataDict
//                     withProgress:(UIProgressView *)progressView
//                     successBlock:(successBlock)successBlock
//                          failure:(void (^)(NSError *))failure;

@end
