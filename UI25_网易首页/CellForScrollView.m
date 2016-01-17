//
//  CellForScrollView.m
//  UI25_网易首页
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 lanou.com. All rights reserved.
//


#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "CellForScrollView.h"
#import "ModelOfData.h"
#import "UIImageView+WebCache.h"

@interface CellForScrollView ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSTimer *timer;

@end

@implementation CellForScrollView


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self createScrollView];
        
    }
    return self;

}


- (void)createScrollView {
    
    self.scroll = [[UIScrollView alloc]init];
    [self.contentView addSubview:self.scroll];
    self.scroll.delegate = self;
//    self.scroll.backgroundColor = [UIColor cyanColor];
    self.scroll.pagingEnabled = YES;
    self.scroll.contentOffset = CGPointMake(self.frame.size.width + 16, 0);

}
- (void)layoutSubviews {

    self.scroll.frame = CGRectMake(0, 10, WIDTH, WIDTH *3 / 4);

}


+ (CGFloat)heightForCellScrollView {
    
    return ([UIScreen mainScreen].bounds.size.width + 32) *3 /4;
}


- (void)passModel:(ModelOfData *)model {
//    NSLog(@"model:=========%@",model.arrAds);
    self.arr = [NSMutableArray arrayWithArray:model.arrAds];
    [self.arr addObject:[model.arrAds firstObject]];
    [self.arr insertObject:[self.arr objectAtIndex:(self.arr.count - 2)] atIndex:0];
//    NSLog(@"arr:============%@",self.arr);
    NSLog(@"%f,%f,%f",self.scroll.frame.size.width,[UIScreen mainScreen].bounds.size.width,self.contentView.frame.size.width);
    
     self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * self.arr.count,0);
    
    for (int i = 0; i < self.arr.count; i++) {
  
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[self.arr[i] objectForKey:@"imgsrc"]];
        
        UILabel *labelForPic = [[UILabel alloc]initWithFrame:CGRectMake(20,  self.scroll.frame.size.width *3 /4 - 50, self.scroll.frame.size.width, 50)];
        labelForPic.text = [self.arr[i] objectForKey:@"title"];
        labelForPic.font = [UIFont systemFontOfSize:20];
        labelForPic.textColor = [UIColor whiteColor];
        [imageView addSubview:labelForPic];
        
        
        imageView.frame = CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.width *3 /4);
        [self.scroll addSubview:imageView];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(self.scroll.frame.size.width * (self.arr.count - 2), 0);
    }

    if (scrollView.contentOffset.x == self.scroll.frame.size.width *(self.arr.count - 1)) {
        scrollView.contentOffset = CGPointMake(self.scroll.frame.size.width, 0);
    }
}




/* 自动轮播 */

- (void)setUpTimer{
    
    self.timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(timerchanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void)timerchanged{
    
    
    
//    NSInteger page = (self.page.currentPage + 1) % ImageCount;
//    self.page.currentPage = page;
//    [self pageAction:self.page];
    
}





- (void)awakeFromNib {
    // Initialization code
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
