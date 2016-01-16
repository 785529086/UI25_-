//
//  NetworkHandler.h
//  UI19_网络封装(delegate回调)
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkHandlerDelegate <NSObject>

- (void)handlerDidComplete:(id)result;

@end

@interface NetworkHandler : NSObject

@property (nonatomic, assign) id<NetworkHandlerDelegate>delegate;

- (void)networkHandlerJSONWithURL:(NSString *)urlString;

+ (void)handlerJSONWithURL:(NSString *)urlString delegate:(id<NetworkHandlerDelegate>)delegate;


@end
