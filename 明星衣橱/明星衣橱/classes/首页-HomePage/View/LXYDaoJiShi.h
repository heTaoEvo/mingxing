//
//  LXYDaoJiShi.h
//  明星衣橱
//
//  Created by joker on 16/7/1.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXYDaoJiShi : UIView
{
    dispatch_source_t _timer;
}

@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UILabel *min;
@property (weak, nonatomic) IBOutlet UILabel *second;
+(instancetype)view;
@end
