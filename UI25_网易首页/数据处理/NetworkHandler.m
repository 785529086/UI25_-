//
//  NetworkHandler.m
//  UI19_网络封装(delegate回调)
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import "NetworkHandler.h"



@implementation NetworkHandler

// 通过NSURLSession实现网络请求.
- (void)networkHandlerJSONWithURL:(NSString *)urlString {

    // 将字符串进行转码(URL中不能含有中文等字符).
    NSString *tempString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"%@",tempString);
    
    // URL
    NSURL *url = [NSURL URLWithString:tempString];
    
    // session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // add Task.
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 返回主线程.
        dispatch_async(dispatch_get_main_queue(), ^{
                   id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if ([self.delegate respondsToSelector:@selector(handlerDidComplete:)]) {
            
            [self.delegate handlerDidComplete:result];
        }
            
        });
    }];
    
    // 开始任务.
    [task resume];

}


+ (void)handlerJSONWithURL:(NSString *)urlString delegate:(id<NetworkHandlerDelegate>)delegate {

    NetworkHandler *handler = [[NetworkHandler alloc]init];
     handler.delegate = delegate;
    [handler networkHandlerJSONWithURL:urlString];
   
}

@end
