//
//  ModelOfData.m
//  UI25_网易首页
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import "ModelOfData.h"

@implementation ModelOfData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (instancetype)init {

    self = [super init];
    if (self) {
        self.arrAds = [NSMutableArray array];
    }
    return self;
}


@end
