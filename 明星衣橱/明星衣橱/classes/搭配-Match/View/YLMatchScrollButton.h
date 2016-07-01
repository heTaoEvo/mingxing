//
//  YLMatchScrollButton.h
//  明星衣橱
//
//  Created by jokerYL on 16/6/28.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLMatchScrollButton : UIButton
@property (nonatomic,strong) NSString *categeryUrl;
@property (nonatomic,strong) NSMutableArray *matchModel;
+(YLMatchScrollButton *)buttonWithCategoryUrl:(NSString *)url title:(NSString *)title target:(id)target action:(SEL)action;
@end
