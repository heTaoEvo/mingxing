//
//  YLSeminarTableViewCell.h
//  明星衣橱
//
//  Created by jokerYL on 16/6/29.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSeminary.h"
@interface YLSeminarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UIButton *collectionCount;
@property (weak, nonatomic) IBOutlet UIButton *commentCount;
@property (weak, nonatomic) IBOutlet UIButton *v;

@property (nonatomic,strong) YLSeminary *seminary;

@end
