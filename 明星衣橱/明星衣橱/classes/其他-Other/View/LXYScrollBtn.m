//
//  LXYScrollBtn.m
//  明星衣橱
//
//  Created by joker on 16/6/28.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYScrollBtn.h"

@implementation LXYScrollBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)layoutSubviews {
    [super layoutSubviews];
    
  
    [self addSubview:self.oldPrice];
 
    [self addSubview:self.Price];
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:5];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.oldPrice.textAlignment = NSTextAlignmentCenter;
    self.oldPrice.font = [UIFont systemFontOfSize:5];
    self.Price.textAlignment = NSTextAlignmentCenter;
    self.Price.font = [UIFont systemFontOfSize:5];

    self.oldPrice.text = self.oldPrice1;
    self.Price.text = self.Price1;
    
    // 设置button的图片的约束
    self.imageView.sd_layout
    .widthRatioToView(self, 1)
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(50);
    
    // 设置button的label的约束
    self.titleLabel.sd_layout
    .topSpaceToView(self.imageView, 10)
    .leftEqualToView(self.imageView)
    .rightEqualToView(self.imageView)
    .heightIs(30);
    
    self.oldPrice.sd_layout
    .topSpaceToView(self.titleLabel, 5)
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .heightIs(30);
    
    self.Price.sd_layout
    .topSpaceToView(self.oldPrice, 5)
    .leftEqualToView(self.oldPrice)
    .rightEqualToView(self.oldPrice)
    .heightIs(30);
    
}

- (UILabel *)oldPrice
{
    if (!_oldPrice) {
        _oldPrice = [[UILabel alloc]init];
    }
    return _oldPrice;
}

- (UILabel *)Price
{
    if (!_Price) {
        _Price = [[UILabel alloc]init];
    }
    return _Price;
}
@end
