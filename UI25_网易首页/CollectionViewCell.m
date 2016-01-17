//
//  CollectionViewCell.m
//  UI25_网易首页
//
//  Created by dllo on 16/1/17.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *button;


@end


@implementation CollectionViewCell


- (void)passArrTitle:(NSString *)buttonTitle {

    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
}



- (void)awakeFromNib {
    // Initialization code
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor colorWithRed:100 / 255.f green:100 / 255.f blue:100 / 255.f alpha:0.2];
    self.button.layer.cornerRadius = 10;

    
    
    
}

@end
