//
//  YLWaterFlowCell.h
//  明星衣橱
//
//  Created by jokerYL on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMatchModel.h"
@interface YLWaterFlowCell : UIView

// 可重用标示符，以便可以在缓冲池中找到可重用单元格
@property (strong, nonatomic) NSString *reuseIdentifier;

// 图像视图
@property (strong, nonatomic) UIImageView *imageView;
// 文字标签
@property (strong, nonatomic) UILabel *textLabel;
// 选中标记
@property (assign, nonatomic) BOOL selected;
@property (nonatomic,strong) YLMatchModel *matchModel;
// 使用可重用标示符，实例化单元格
- (id)initWithResueIdentifier:(NSString *)reuseIdentifier;
@end
