//
//  LXYshouYeScrollTableViewCell.m
//  明星衣橱
//
//  Created by joker on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYshouYeScrollTableViewCell.h"
#import <UIView+SDAutoLayout.h>
@implementation LXYshouYeScrollTableViewCell

- (void)awakeFromNib {
    // Initialization
    self.btn = [UIButton new];
 [self.contentView addSubview:self.btn];
 
  
    

    
    self.btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.btn.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView,10)
    .heightIs(100);
    
     //设置button的图片的约束
    self.btn.imageView.sd_layout
    .widthRatioToView(self.btn, 0.3)
    .topSpaceToView(self.btn, 10)
    .centerXEqualToView(self.btn)
    .heightRatioToView(self.btn, 0.3);
    
    // 设置button的label的约束
    self.btn.titleLabel.sd_layout
    .topSpaceToView(self.btn.imageView, 10)
    .leftEqualToView(self.btn.imageView)
    .rightEqualToView(self.btn.imageView)
    .bottomSpaceToView(self.btn, 10);
    
    
    self.Scroll1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.btn,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(50);
    
    self.SCroll2.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.Scroll1,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(200);
    
    self.Scroll3.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.SCroll2,0)
    .rightSpaceToView(self.contentView,0)
     .heightIs(200);
    
    
    [self setupAutoHeightWithBottomView:self.Scroll3 bottomMargin:0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
