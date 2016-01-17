//
//  CellForNormalNews.m
//  UI25_网易首页
//
//  Created by dllo on 16/1/17.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import "CellForNormalNews.h"
#import "ModelOfData.h"
#import "UIImageView+WebCache.h"

@interface CellForNormalNews ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (weak, nonatomic) IBOutlet UILabel *labelFotTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelForGiest;

@end


@implementation CellForNormalNews

- (void)passModel:(ModelOfData *)model {
    
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.labelFotTitle.text = model.title;
    self.labelForGiest.text = model.digest;
}


- (void)awakeFromNib {
    // Initialization code
    
    self.labelFotTitle.numberOfLines = 0;
    self.labelForGiest.numberOfLines = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
