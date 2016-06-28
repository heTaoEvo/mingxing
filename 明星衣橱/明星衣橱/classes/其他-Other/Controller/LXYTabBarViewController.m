//
//  LXYTabBarViewController.m
//  明星衣橱
//
//  Created by joker on 16/6/24.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYTabBarViewController.h"
#import "LXYshouYeNaviBarButton.h"
#import "LXYShouYeViewController.h"
#import "YLMatchViewController.h"
#import "YLMeTableViewController.h"
@interface LXYTabBarViewController ()

@end

@implementation LXYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //查找story
    UIStoryboard *lxystory=[UIStoryboard storyboardWithName:@"LXY" bundle:nil];
    UIViewController *denglu=[lxystory instantiateViewControllerWithIdentifier:@"denglu"];
    LXYShouYeViewController *shouye= [lxystory instantiateViewControllerWithIdentifier:@"shouye"];
  
    
    //建立5个NavigationControlle
    
    //首页控制器
    UINavigationController *homeNavigationController = [[UINavigationController alloc]init];
    

    [homeNavigationController pushViewController:shouye animated:YES];
    //创建分类按钮
    LXYshouYeNaviBarButton *fenlei = [self tabBarItemWithFrame:CGRectMake(0, 0, 30, 30) title:@"分类" normalImageName:@"botton_head_sort"selectedImageName:@"botton_head_sort"];
    [fenlei addTarget:self action:@selector(shuchu:) forControlEvents:UIControlEventTouchUpInside];
    //创建信息按钮
    LXYshouYeNaviBarButton *message = [self tabBarItemWithFrame:CGRectMake(0, 0, 30, 30) title:@"分类" normalImageName:@"button_massage"selectedImageName:@"button_massage"];
    
    //创建搜索栏
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 30)   ];
    tf.placeholder=@"222222222222";
    //添加到navigationbar
    UIBarButtonItem *tfx=[[UIBarButtonItem alloc]initWithCustomView:tf];
    UIBarButtonItem *fenleix = [[UIBarButtonItem alloc]initWithCustomView:fenlei];
    UIBarButtonItem *messagex = [[UIBarButtonItem alloc]initWithCustomView:message];
//    qq.navigationItem.leftBarButtonItems=@[fenleix,tfx];
//    qq.navigationItem.rightBarButtonItem=messagex;
    
  
    
    
    
    

    //搭配视图控制器
    UINavigationController *dapeiNavigationController = [[UINavigationController alloc] initWithRootViewController:[[YLMatchViewController alloc] init]];
    //社区视图控制器
    UINavigationController *bbsNavigationController = [[UINavigationController alloc]init];
    
  
    //购物车控制器
    UINavigationController *shoppingNavigationController = [[UINavigationController alloc]init];
    
    shoppingNavigationController.navigationBarHidden=NO;
    [shoppingNavigationController pushViewController:denglu animated:YES];
    //个人视图控制
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"YL" bundle:nil];
    YLMeTableViewController *me = [story instantiateViewControllerWithIdentifier:@"me"];
    UINavigationController *likeNavigationController = [[UINavigationController alloc] initWithRootViewController:me];
    
    
    
   self.viewControllers=@[homeNavigationController,dapeiNavigationController,bbsNavigationController,shoppingNavigationController,likeNavigationController];
    //创建5个TabBarItem
    UITabBarItem *homeItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"bottom_home_icon"] selectedImage:[UIImage imageNamed:@"bottom_home_icon_on"]];
    
    UITabBarItem *dapeiItem = [[UITabBarItem alloc]initWithTitle:@"搭配" image:[UIImage imageNamed:@"bottom_dapei_icon"] selectedImage:[UIImage imageNamed:@"bottom_dapei_icon_on"]];
    
    UITabBarItem *bbsItem = [[UITabBarItem alloc]initWithTitle:@"社区" image:[UIImage imageNamed:@"bottom_bbs_icon"] selectedImage:[UIImage imageNamed:@"bottom_bbs_icon_on"]];
    
    UITabBarItem *shoppingItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"bottom_shopping_icon"] selectedImage:[UIImage imageNamed:@"bottom_shopping_icon_on"]];
    
    
    
    
    UITabBarItem *likeItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"bottom_like_icon"] selectedImage:[UIImage imageNamed:@"bottom_like_icon_on"]];
    
    //设置tabBarItem的文字属性 220 56 122
    NSMutableDictionary *seletedDic = [NSMutableDictionary dictionary];
    seletedDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:220/255.0 green:56/255.0 blue:122/255.0 alpha:1];
    UITabBarItem *item = [UITabBarItem appearance];
   [item setTitleTextAttributes:seletedDic forState:UIControlStateSelected];
    
    
    //关联TabBar
    homeNavigationController.tabBarItem = homeItem;
    dapeiNavigationController.tabBarItem = dapeiItem;
    bbsNavigationController.tabBarItem = bbsItem;
    shoppingNavigationController.tabBarItem = shoppingItem;
    likeNavigationController.tabBarItem = likeItem;
    

    
    
}

- (void)shuchu:(LXYshouYeNaviBarButton *)btn
{
    NSLog(@"1111111");
}
- (LXYshouYeNaviBarButton *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName
{
    LXYshouYeNaviBarButton *item = [[LXYshouYeNaviBarButton alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    
    
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    
    
    return item;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
