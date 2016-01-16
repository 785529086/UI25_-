//
//  CellForScrollView.m
//  UI25_网易首页
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import "CellForScrollView.h"
#import "ModelOfData.h"
#import "UIImageView+WebCache.h"

@interface CellForScrollView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (nonatomic, retain) NSMutableArray *arr;

@end

@implementation CellForScrollView

- (void)awakeFromNib {
    // Initialization code
    
    // 注意此处.只要将self.scroll的contentSize属性的高设置为小于cell的高度值,可以解决scrollView上下晃动.
    
    self.scroll.backgroundColor = [UIColor cyanColor];
    self.scroll.pagingEnabled = YES;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)heightForCellScrollView {
    
    return [UIScreen mainScreen].bounds.size.width *3 /4;
}


- (void)passModel:(ModelOfData *)model {
    
    self.arr = [NSMutableArray arrayWithArray:model.arrAds];
    [self.arr addObject:[model.arrAds firstObject]];
    [self.arr insertObject:[self.arr objectAtIndex:(self.arr.count - 2)] atIndex:0];
    
     self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * self.arr.count,0);
    
    for (int i = 0; i < self.arr.count; i++) {
  
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[self.arr[i] objectForKey:@"imgsrc"]];
        imageView.frame = CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, ([UIScreen mainScreen].bounds.size.width - 20) *3 /4);
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






@end
