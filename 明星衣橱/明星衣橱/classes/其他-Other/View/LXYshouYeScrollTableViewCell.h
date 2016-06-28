//
//  LXYshouYeScrollTableViewCell.h
//  明星衣橱
//
//  Created by joker on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXYshouYeNaviBarButton.h"
#import "LXYShouYePic.h"
@interface LXYshouYeScrollTableViewCell : UITableViewCell


@property (strong ,nonatomic) UIButton *btn;
@property (weak, nonatomic) IBOutlet UIScrollView *Scroll1;
@property (weak, nonatomic) IBOutlet LXYShouYePic *SCroll2;
@property (weak, nonatomic) IBOutlet UIScrollView *Scroll3;
@end
