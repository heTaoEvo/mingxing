//
//  LXYcollectionTableViewCell.m
//  明星衣橱
//
//  Created by joker on 16/6/27.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYcollectionTableViewCell.h"
#import <UIView+SDAutoLayout.h>
@implementation LXYcollectionTableViewCell

- (void)awakeFromNib {
    //  code
  
    self.leftView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,0.5);
    
    self.rightView.sd_layout
    .rightSpaceToView(self.contentView,0)
    
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,0.5);
    
    self.leftBtn = [[UIButton alloc]init];
   self.leftBtn.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview: self.leftBtn];
    self.leftBtn.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,0.5);
    [self.leftBtn addTarget:self action:@selector(leftbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBtn = [UIButton new];
    [self.contentView addSubview:self.rightBtn];
    self.rightBtn.backgroundColor = [UIColor blueColor];
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.sd_layout
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,0.5);
    
    [self.contentView sendSubviewToBack:self.leftBtn];
    [self.contentView sendSubviewToBack:self.rightBtn];
    [self.contentView bringSubviewToFront:self.rightView];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)leftbtn:(UIButton *)sender {
    NSLog(@"11111111111111");
}
- (void)rightBtn:(UIButton *)sender {
    NSLog(@"222222222222");
}
@end



