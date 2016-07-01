//
//  YLMatchScrollButton.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/28.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLMatchScrollButton.h"

@implementation YLMatchScrollButton
- (NSMutableArray *)matchModel {
    if (!_matchModel) {
        _matchModel = [NSMutableArray array];
    }
    return _matchModel;
}
+(YLMatchScrollButton *)buttonWithCategoryUrl:(NSString *)url title:(NSString *)title target:(id)target action:(SEL)action {
    YLMatchScrollButton *button = [YLMatchScrollButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.categeryUrl = url;
   
    return button;
}

@end
