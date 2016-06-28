//
//  YLWaterFlowCell.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLWaterFlowCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
// 边距
#define kWaterFlowCellMargin 2.0
// 文本字体
#define kWaterFlowCellFont [UIFont systemFontOfSize:11.0]
@implementation YLWaterFlowCell
- (void)setMatchModel:(YLMatchModel *)matchModel {
    _matchModel = matchModel;
    
    YLLog(@"%@",matchModel.picUrl);
    NSArray *arr = [matchModel.picUrl componentsSeparatedByString:@"?"];
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"AppIcon40x40"]];
    YLLog(@"%@------%@",self.imageView,self.imageView.image);
    
    self.textLabel.text = self.matchModel.description;    
}

#pragma mark 实例化视图
- (id)initWithResueIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    
    if (self) {
        // 使用属性记录可重用标示符
        self.reuseIdentifier = reuseIdentifier;
        
        [self setBackgroundColor:[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]];
    }
    
    return self;
}

// 以下是在自定义视图中实现懒加载的方式
// 可以用控件的getter
#pragma mark - imageView getter方法
- (UIImageView *)imageView
{
    // 懒加载imageView
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        
        // 保证图像按比例显示
        //[_imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:_imageView];
    }
    
    return _imageView;
}

#pragma mark - textLabel getter方法
- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        
        // 设置文本标签的其他属性
        // 1) 设置背景颜色
        [_textLabel setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5]];
        // 2) 设置对齐方式，居中对齐
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        
        // 3) 设置文本自动换行
        [_textLabel setNumberOfLines:0];
        
        // 4) 设置文字颜色
        [_textLabel setTextColor:[UIColor whiteColor]];
        
        // 将文本标签放置在图像之上
        [self insertSubview:_textLabel aboveSubview:self.imageView];
    }
    
    return _textLabel;
}

#pragma mark - 视图重新布局
- (void)layoutSubviews
{
    // 因为本视图继承自UIView，UIView本身内部不包含任何控件
    // 因此，在此可以省略layoutSubviews
    [super layoutSubviews];
    
    // 1. 设置imageView大小和位置
    [self.imageView setFrame:CGRectInset(CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-30), kWaterFlowCellMargin, kWaterFlowCellMargin)];
//    [self.imageView setFrame:CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height-10)];
    
    // 2. 设置textLabel大小和位置
    // 1) 当前文本的内容
    self.textLabel.font = kWaterFlowCellFont;
    NSString *str = self.textLabel.text;
    // 2) 计算文本需要的大小
    CGFloat w = self.imageView.bounds.size.width;
    
    CGSize textSize = [str sizeWithFont:kWaterFlowCellFont constrainedToSize:CGSizeMake(w, 10000)];
    
    CGFloat h = textSize.height;
    
    // 3) 如果文本高度超过图像的一半，限定只显示一半高度
    if (h > self.bounds.size.height / 2.0) {
        h = self.bounds.size.height / 2.0;
    }
    CGFloat y = self.bounds.size.height - h - kWaterFlowCellMargin;
    
    //[self.textLabel setFrame:CGRectMake(kWaterFlowCellMargin, y, w, h)];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.equalTo(self.imageView.mas_left);
        make.width.mas_equalTo(self.imageView);
        make.height.mas_equalTo(h);
    }];
    
    
}


@end
