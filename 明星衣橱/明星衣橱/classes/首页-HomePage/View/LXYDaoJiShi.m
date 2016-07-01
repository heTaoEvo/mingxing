//
//  LXYDaoJiShi.m
//  明星衣橱
//
//  Created by joker on 16/7/1.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYDaoJiShi.h"

@implementation LXYDaoJiShi

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}



+ (instancetype)view
{
    
    
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LXYDaoJiShi" owner:nil options:nil] lastObject];
}

@end
