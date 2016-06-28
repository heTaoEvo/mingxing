//
//  UIBarButtonItem+YLUIBarButtonItem.h
//  明星衣橱
//
//  Created by jokerYL on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YLUIBarButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highliahtedImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
