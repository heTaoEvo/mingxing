//
//  LXYScrollBtn.h
//  明星衣橱
//
//  Created by joker on 16/6/28.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIView+SDAutoLayout.h>
#import "LXYXdata.h"
@interface LXYScrollBtn : UIButton
@property (nonatomic ,strong) UILabel *oldPrice,*Price;
@property (nonatomic ,copy) NSString *oldPrice1,*Price1;
@property (nonatomic ,strong) NSMutableDictionary *Xdata;
@end
