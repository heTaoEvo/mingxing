//
//  YLMatchAndSeminarViewController.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/30.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLMatchAndSeminarViewController.h"
#import "UIBarButtonItem+YLUIBarButtonItem.h"
#import <Masonry.h>
#import "YLMatchViewController.h"
#import "YLSeminarViewController.h"
@interface YLMatchAndSeminarViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic,strong) UIViewController *currentController;
@end

@implementation YLMatchAndSeminarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNaviTitleItem];
    [self setChildViewController];
}
- (void)setChildViewController {
    YLMatchViewController *match = [[YLMatchViewController alloc] init];
    [self addChildViewController:match];
    [match didMoveToParentViewController:self];
    match.view.frame = self.view.bounds;
    self.currentController = match;
    [self.view addSubview:match.view];
}

#pragma mark ----设置导航titleView
- (void)setUpNaviTitleItem {
    UIView *bgVi = [[UIView alloc] init];
    UIView *redVi = [[UIView alloc] init];
    redVi.frame = CGRectMake(0, 30, 40, 8);
    bgVi.bounds = CGRectMake(0, 0, 200, 40);
    bgVi.backgroundColor = [UIColor greenColor];
    UIButton *matchBt = [self creatBtTitle:@"搭配" NormalColor:[UIColor grayColor] selectedColor:[UIColor redColor] target:self action:@selector(test)];
    [matchBt setBackgroundColor:[UIColor redColor]];
    UIButton *seminarBt = [self creatBtTitle:@"专题" NormalColor:[UIColor grayColor] selectedColor:[UIColor redColor] target:self action:@selector(addChildController)];
    [seminarBt setBackgroundColor:[UIColor blueColor]];
    self.navigationItem.titleView = bgVi;
    [bgVi addSubview:matchBt];
    [bgVi addSubview:seminarBt];
    [bgVi addSubview:redVi];
    [matchBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgVi.mas_top);
        make.left.equalTo(bgVi.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    [seminarBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgVi.mas_top);
        make.right.equalTo(bgVi.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [redVi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(matchBt.mas_centerX);
        make.top.equalTo(matchBt.mas_bottom);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(8);
    }];
    [redVi layoutIfNeeded];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"bottom_head_shezhi" highliahtedImage:@"icon_my_shezhi" target:self action:@selector(test)];
 
}
- (UIButton *)creatBtTitle:(NSString *)title NormalColor:(UIColor *)norColor selectedColor:(UIColor *)selectedColor target:(id)target action:(SEL)action {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:norColor forState:UIControlStateNormal];
    [bt setTitleColor:selectedColor forState:UIControlStateSelected];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    bt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    return bt;
}
- (void)addChildController {
    
    if (self.currentController.class == [YLSeminarViewController class]) {
        return;
    }
    YLSeminarViewController *seminar = nil;
    if (self.childViewControllers.count == 1) {
       seminar = [[YLSeminarViewController alloc] init];
        [self addChildViewController:seminar];
        [seminar didMoveToParentViewController:self];
        [self.view addSubview:seminar.view];
        seminar.view.frame =self.view.bounds;
        //因为之前已经将一个子视图控制器的view添加到contentView上,所以,当调用此方法的时候,系统会自动将子视图控制器的view添加的contentView的相同位置上,不需要再去写[self.contentView addSubView:other.view]
        
    }else {
        seminar = self.childViewControllers[1];
    }
    [self transitionFromViewController:_currentController toViewController:seminar duration:.5 options:UIViewAnimationOptionCurveLinear animations:^{
    } completion:^(BOOL finished) {
        self.currentController=seminar;
    }];
}
- (void)test {
    if (self.currentController.class == [YLMatchViewController class]) {
        return;
    }
    YLMatchViewController *match = self.childViewControllers[0];
    [self transitionFromViewController:_currentController toViewController:match duration:.5 options:UIViewAnimationOptionCurveLinear animations:^{
    } completion:^(BOOL finished) {
        self.currentController= match;
    }];
}
@end
