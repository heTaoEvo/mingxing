//
//  YLScrollTableViewCell.m
//  明星衣橱
//
//  Created by jokerYL on 16/7/1.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLScrollTableViewCell.h"
#import <Masonry.h>
@interface YLScrollTableViewCell()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
@implementation YLScrollTableViewCell

- (void)awakeFromNib {
    self.scroll.contentSize = CGSizeMake(self.scroll.bounds.size.width, 1000);
    self.scroll.backgroundColor = [UIColor redColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setUser:(YLUser *)user {
    _user = user;
    self.desc.text = user.desc;
    self.desc.preferredMaxLayoutWidth = 200;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scroll.mas_top);
        make.left.equalTo(self.scroll.mas_left);
    }];
    [self.desc layoutIfNeeded];
}
@end
