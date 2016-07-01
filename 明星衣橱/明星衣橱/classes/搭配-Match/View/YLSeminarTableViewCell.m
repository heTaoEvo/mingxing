//
//  YLSeminarTableViewCell.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/29.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLSeminarTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation YLSeminarTableViewCell

- (void)setSeminary:(YLSeminary *)seminary {
    _seminary = seminary;
    self.titleLab.text = seminary.title;
    self.tagLab.text = [NSString stringWithFormat:@"#%@#",seminary.category];
    NSArray *arr = [seminary.picUrl componentsSeparatedByString:@"?"];
    
    [self.pic sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    
    self.timeLab.text = [NSString stringWithFormat:@"%@.%@.%@",seminary.year,seminary.month,seminary.day];
    [self.v setTitle:seminary.v forState:UIControlStateNormal];
    [self.collectionCount setTitle:seminary.collectionCount forState:UIControlStateNormal];
    [self.commentCount setTitle:seminary.commentCount forState:UIControlStateNormal];
    
}
- (void)awakeFromNib {
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.height -=10;
    self.contentView.y = 5;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
