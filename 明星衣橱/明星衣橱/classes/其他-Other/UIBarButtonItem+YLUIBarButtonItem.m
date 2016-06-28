//
//  UIBarButtonItem+YLUIBarButtonItem.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "UIBarButtonItem+YLUIBarButtonItem.h"

@implementation UIBarButtonItem (YLUIBarButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highliahtedImage:(NSString *)highlightImage target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGSize size =button.currentBackgroundImage.size;
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, size.width, size.height);
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
