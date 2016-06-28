//
//  LXYShouYeCollectionView.m
//  明星衣橱
//
//  Created by joker on 16/6/27.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYShouYeCollectionView.h"
#import <UIView+SDAutoLayout.h>
@implementation LXYShouYeCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"111");
     self.guojia.font = [UIFont systemFontOfSize:5];
    self.Jiage.font = [UIFont systemFontOfSize:5];
    self.oldJiage.font = [UIFont systemFontOfSize:5];
    self.name.font = [UIFont systemFontOfSize:5];
    self.pic.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .heightIs(200);
}

@end
