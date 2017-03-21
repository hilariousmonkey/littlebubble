//
//  BaseRequest.m
//  ShinePhone
//
//  Created by LinKai on 15/5/19.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "BaseRequest.h"
#import <AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <UIKit+AFNetworking.h>

@implementation BaseRequest

+ (void)requestWithMethodResponseStringResult:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"url:%@", url);
    [manager POST:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}

+ (void)requestWithMethodResponseJsonByGet:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"url:%@", url);
    [manager GET:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}

+ (void)requestWithMethodForFile:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site fileDict:(NSMutableDictionary *)dataDict successBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"url:%@", url);
    [manager POST:url parameters:paramars constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *keys = dataDict.allKeys;
        for (NSString *key in keys) {
            if ([dataDict[key] class]==[UIImage class]) {
                UIImage *image=dataDict[key];
                if (image.size.width>500) {
                    float i=image.size.width/image.size.height;
                    UIGraphicsBeginImageContext(CGSizeMake(500, 500/i));  //size 为CGSize类型，即你所需要的图片尺寸
                    [image drawInRect:CGRectMake(0, 0, CGSizeMake(500, 500/i).width, CGSizeMake(500, 500/i).height)];
                    image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                }
                NSData *data=UIImageJPEGRepresentation(image, 0.5);
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:data];
                [formData appendPartWithInputStream:inputStream name:key fileName:@"image.jpg" length:data.length mimeType:@"image/jpg"];
            }else {
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[key]];
                [formData appendPartWithInputStream:inputStream name:key fileName:@"video.mp4" length:[dataDict[key] length] mimeType:@"video/mp4"];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        NSLog(@"successBlock:%@",successBlock);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        failure(error);
    }];
}

+ (void)requestWithMethodForAudio:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site fileDict:(NSMutableDictionary *)dataDict successBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"url:%@", url);
    [manager POST:url parameters:paramars constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *keys = dataDict.allKeys;
        for (NSString *key in keys) {
            if ([dataDict[key] class]==[UIImage class]) {
                UIImage *image=dataDict[key];
                if (image.size.width>500) {
                    float i=image.size.width/image.size.height;
                    UIGraphicsBeginImageContext(CGSizeMake(500, 500/i));  //size 为CGSize类型，即你所需要的图片尺寸
                    [image drawInRect:CGRectMake(0, 0, CGSizeMake(500, 500/i).width, CGSizeMake(500, 500/i).height)];
                    image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                }
                NSData *data=UIImageJPEGRepresentation(image, 0.5);
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:data];
                [formData appendPartWithInputStream:inputStream name:key fileName:@"image.jpg" length:data.length mimeType:@"image/jpg"];
            }else {
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[key]];
                [formData appendPartWithInputStream:inputStream name:key fileName:@"audio.aac" length:[dataDict[key] length] mimeType:@"audio/aac"];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        NSLog(@"successBlock:%@",successBlock);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        failure(error);
    }];
}

+ (void)requestWithMethodForFile:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site fileDict:(NSMutableDictionary *)dataDict withProgress:(UIProgressView *)progressView successBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"url:%@", url);
    AFHTTPRequestOperation *operation=[manager POST:url parameters:paramars constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *keys = dataDict.allKeys;
        for (NSString *key in keys) {
            if ([dataDict[key] class]==[UIImage class]) {
                UIImage *image=dataDict[key];
                if (image.size.width>500) {
                    float i=image.size.width/image.size.height;
                    UIGraphicsBeginImageContext(CGSizeMake(500, 500/i));  //size 为CGSize类型，即你所需要的图片尺寸
                    [image drawInRect:CGRectMake(0, 0, CGSizeMake(500, 500/i).width, CGSizeMake(500, 500/i).height)];
                    image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                }
                NSData *data=UIImageJPEGRepresentation(image, 0.5);
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:data];
                [formData appendPartWithInputStream:inputStream name:key fileName:@"image.jpg" length:data.length mimeType:@"image/jpg"];
            }else {
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[key]];
                [formData appendPartWithInputStream:inputStream name:key fileName:@"video.mp4" length:[dataDict[key] length] mimeType:@"video/mp4"];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        [progressView removeFromSuperview];
        NSLog(@"successBlock:%@",successBlock);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progressView removeFromSuperview];
        NSLog(@"error:%@",error);
        failure(error);
    }];
    
    [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
    [operation start];
}

+ (void)requestWithMethodForAudio:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site fileDict:(NSMutableDictionary *)dataDict withProgress:(UIProgressView *)progressView successBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"url:%@", url);
    AFHTTPRequestOperation *operation=[manager POST:url parameters:paramars constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *keys = dataDict.allKeys;
        if ([keys count]>1) {
            if ([keys containsObject:@"file1"]) {
                NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[@"file1"]];
                [formData appendPartWithInputStream:inputStream name:@"file1" fileName:@"audio.aac" length:[dataDict[@"file1"] length] mimeType:@"audio/aac"];
                for (NSString *key in keys) {
                    if ([dataDict[key] class]==[UIImage class]) {
                        UIImage *image=dataDict[key];
                        if (image.size.width>500) {
                            float i=image.size.width/image.size.height;
                            UIGraphicsBeginImageContext(CGSizeMake(500, 500/i));  //size 为CGSize类型，即你所需要的图片尺寸
                            [image drawInRect:CGRectMake(0, 0, CGSizeMake(500, 500/i).width, CGSizeMake(500, 500/i).height)];
                            image = UIGraphicsGetImageFromCurrentImageContext();
                            UIGraphicsEndImageContext();
                        }
                        NSData *data=UIImageJPEGRepresentation(image, 0.5);
                        NSInputStream *inputStream=[NSInputStream inputStreamWithData:data];
                        [formData appendPartWithInputStream:inputStream name:key fileName:@"image.jpg" length:data.length mimeType:@"image/jpg"];
                    }else{
                        if (![key isEqualToString:@"file1"]) {
                            NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[key]];
                            [formData appendPartWithInputStream:inputStream name:key fileName:@"audio.aac" length:[dataDict[key] length] mimeType:@"audio/aac"];
                        }
                    }
                }
            }else{
                for (NSString *key in keys) {
                    if ([dataDict[key] class]==[UIImage class]) {
                        UIImage *image=dataDict[key];
                        if (image.size.width>500) {
                            float i=image.size.width/image.size.height;
                            UIGraphicsBeginImageContext(CGSizeMake(500, 500/i));  //size 为CGSize类型，即你所需要的图片尺寸
                            [image drawInRect:CGRectMake(0, 0, CGSizeMake(500, 500/i).width, CGSizeMake(500, 500/i).height)];
                            image = UIGraphicsGetImageFromCurrentImageContext();
                            UIGraphicsEndImageContext();
                        }
                        NSData *data=UIImageJPEGRepresentation(image, 0.5);
                        NSInputStream *inputStream=[NSInputStream inputStreamWithData:data];
                        [formData appendPartWithInputStream:inputStream name:key fileName:@"image.jpg" length:data.length mimeType:@"image/jpg"];
                    }else {
                        NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[key]];
                        [formData appendPartWithInputStream:inputStream name:key fileName:@"audio.aac" length:[dataDict[key] length] mimeType:@"audio/aac"];
                        
                    }
                }
            }            
        }else{
            for (NSString *key in keys) {
                if ([dataDict[key] class]==[UIImage class]) {
                    UIImage *image=dataDict[key];
                    if (image.size.width>500) {
                        float i=image.size.width/image.size.height;
                        UIGraphicsBeginImageContext(CGSizeMake(500, 500/i));  //size 为CGSize类型，即你所需要的图片尺寸
                        [image drawInRect:CGRectMake(0, 0, CGSizeMake(500, 500/i).width, CGSizeMake(500, 500/i).height)];
                        image = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                    }
                    NSData *data=UIImageJPEGRepresentation(image, 0.5);
                    NSInputStream *inputStream=[NSInputStream inputStreamWithData:data];
                    [formData appendPartWithInputStream:inputStream name:key fileName:@"image.jpg" length:data.length mimeType:@"image/jpg"];
                }else {
                    NSInputStream *inputStream=[NSInputStream inputStreamWithData:dataDict[key]];
                    [formData appendPartWithInputStream:inputStream name:key fileName:@"audio.aac" length:[dataDict[key] length] mimeType:@"audio/aac"];
                    
                }
            }
        }
       
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        [progressView removeFromSuperview];
        NSLog(@"successBlock:%@",successBlock);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progressView removeFromSuperview];
        NSLog(@"error:%@",error);
        failure(error);
    }];
    
    [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
    [operation start];

}

@end
