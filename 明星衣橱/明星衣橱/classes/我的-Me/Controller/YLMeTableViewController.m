//
//  YLMeTableViewController.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/23.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLMeTableViewController.h"
#import "UIBarButtonItem+YLUIBarButtonItem.h"
@interface YLMeTableViewController ()

@end

@implementation YLMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNaviItem];
    
}
- (void)setUpNaviItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"bottom_head_shezhi" highliahtedImage:@"icon_my_shezhi" target:self action:@selector(test)];
    
    UIBarButtonItem *messageItem = [UIBarButtonItem itemWithImage:@"button_head_massage" highliahtedImage:@"button_massage" target:self action:@selector(test)];
    UIBarButtonItem *shoppingItem = [UIBarButtonItem itemWithImage:@"bottom_shopping_icon" highliahtedImage:@"botton_shoppingcart_icon" target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItems = @[messageItem,shoppingItem];
}
- (void)test {
    
}
- (IBAction)click:(UIButton *)sender {
    NSLog(@"1111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
