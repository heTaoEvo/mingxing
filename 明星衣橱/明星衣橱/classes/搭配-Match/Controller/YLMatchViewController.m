//
//  YLMatchViewController.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLMatchViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Masonry.h>
#import "YLWaterFlowView.h"
#import "YLWaterFlowCell.h"
#import <AFNetworking.h>
#import "YLMatchModel.h"
#import <MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "YLMatchScrollButton.h"
#import "UIBarButtonItem+YLUIBarButtonItem.h"
#import <MJRefresh.h>
#import "YLMatchDetailController.h"
@interface YLMatchViewController () <YLWaterFlowViewDataSource,YLWaterFlowViewDelegate>
@property (strong, nonatomic) YLWaterFlowView *waterFlowView;
@property (strong, nonatomic) NSMutableArray *images;

@property (nonatomic,strong) UIScrollView *categoryScr;
@property (nonatomic,copy) NSArray *modelDicArr;
@property (nonatomic,copy) NSDictionary *categoryDic;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,copy) NSArray *keyArr;
@property (nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,strong) NSMutableArray *btArr;

@end

@implementation YLMatchViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
//- (UIScrollView *)categoryScr {
//    if (!_categoryScr) {
//        _categoryScr = [[UIScrollView alloc] init];
//    }
//    return _categoryScr;
//}
#pragma mark - 实例化视图

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modelArr = [NSMutableArray array];
    [self setCategoryDic];
    //[self setRefresh];
    [self setUpDataSource];
    [self setUpCategoryScrollView];
    [self setUpNaviTitleItem];
    
}
- (void)setRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        YLLog(@"1111");
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header.ignoredScrollViewContentInsetTop = 30;
    self.waterFlowView.mj_header = header;
    [self.waterFlowView.mj_header beginRefreshing];
}


#pragma mark ----发送请求
- (void)sendReqWithCategoryBt:(YLMatchScrollButton *)button{
    
    [self.manager GET:button.categeryUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        self.modelDicArr = responseObject[@"data"][@"items"];
        //请求成功初始化对应模型数组
        [self initModelArr:button];
        //请求成功，刷新数据
        [_waterFlowView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YLLog(@"error------%@",error);
    }];
}
- (void)setCategoryDic {
    _categoryDic = @{@"最新":@"http://api-v2.mall.hichao.com/star/list?category=%E5%85%A8%E9%83%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"热门":@"http://api-v2.mall.hichao.com/star/list?category=%E7%83%AD%E9%97%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"欧美":@"http://api-v2.mall.hichao.com/star/list?category=%E6%AC%A7%E7%BE%8E&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"日韩":@"http://api-v2.mall.hichao.com/star/list?category=%E6%97%A5%E9%9F%A9&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"本土":@"http://api-v2.mall.hichao.com/star/list?category=%E6%97%A5%E9%9F%A9&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"型男":@"http://api-v2.mall.hichao.com/star/list?category=%E5%9E%8B%E7%94%B7&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"清新":@"http://api-v2.mall.hichao.com/star/list?category=%E6%B8%85%E6%96%B0&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=",
                     @"OL":@"http://api-v2.mall.hichao.com /star/list?category=OL&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token="};
    _keyArr = @[@"最新",@"热门",@"欧美",@"日韩",@"本土",@"型男",@"清新",@"OL"];
}
- (void)initModelArr:(YLMatchScrollButton *)button {
    [button.matchModel removeAllObjects];
    [self.modelArr removeAllObjects];
    for (int i = 0; i<self.modelDicArr.count; i++) {
        NSDictionary *dic = self.modelDicArr[i];
        [self.modelArr addObject:[YLMatchModel mj_objectWithKeyValues:dic[@"component"]]];
    }
    [button.matchModel addObjectsFromArray:self.modelArr];
    
}
#pragma mark ----初始化分类ScrollView
- (void)setUpCategoryScrollView {
    self.btArr = [NSMutableArray array];
    self.categoryScr = [[UIScrollView alloc] init];
    [self.view addSubview:self.categoryScr];
    [self.categoryScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(30);
    }];
    [self.categoryScr layoutIfNeeded];
    //UIButton *last = nil;
    for (int i = 0; i<_keyArr.count; i++) {
        NSString *str =_keyArr[i];
        YLMatchScrollButton *button = [YLMatchScrollButton buttonWithCategoryUrl:_categoryDic[str] title:str target:self action:@selector(click:)];
        //UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        //[button setBackgroundColor:[UIColor redColor]];
        button.frame = CGRectMake(50*i,64, 50, 30);
//        [self.categoryScr addSubview:button];
//        if (!last) {
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.categoryScr.mas_top);
//                make.leading.equalTo(@0);
//                make.width.mas_equalTo(50);
//                make.height.mas_equalTo(30);
//            }];
//        }else {
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.categoryScr.mas_top);
//                make.leading.equalTo(last.mas_trailing);
//                make.width.mas_equalTo(50);
//                make.height.mas_equalTo(30);
//            }];
//        }
        //last = button;
        [self.view addSubview:button];
        [self.btArr addObject:button];
    }
    YLMatchScrollButton *bt = self.btArr[0];
    bt.selected = YES;
    [self sendReqWithCategoryBt:bt];
//    self.categoryScr.backgroundColor = [UIColor redColor];
//    self.categoryScr.contentSize = CGSizeMake(_keyArr.count*30, 30);
}
- (void)click:(YLMatchScrollButton *)sender {
    YLLog(@"点击了button");
    if (sender.selected) {
        return;
    }
    for (YLMatchScrollButton *button in self.btArr) {
        button.selected = NO;
    }
    sender.selected = YES;
    if (sender.matchModel.count != 0) {
        [self.modelArr removeAllObjects];
        [self.modelArr addObjectsFromArray:sender.matchModel];
        [_waterFlowView reloadData];
    }
    [self sendReqWithCategoryBt:sender];
}
#pragma mark ------设置瀑布流数据源
- (void)setUpDataSource {
    // 如此做法是为了保证视图控制器能够嵌套使用！
    // 1. 实例化一个没有大小的瀑布流视图
    _waterFlowView = [[YLWaterFlowView alloc] init];
    [self.view addSubview:_waterFlowView];
    [_waterFlowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(94);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
    }];
    [_waterFlowView layoutIfNeeded];
    //YLLog(@"%@----%@",_waterFlowView,self.view);
    // 2. 要保证当前视图与父视图同样大小
    // 如果看到头文件中的枚举类型有位移符号，就可以使用 | “并”操作，可以同时使用多个选项！
    [_waterFlowView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    // 3. 设置代理和数据源
    [_waterFlowView setDataSource:self];
    [_waterFlowView setDelegate:self];
    
}
#pragma mark - 数据源方法
#pragma mark - 列数
- (NSInteger)numberOfColumnsInWaterFlowView:(YLWaterFlowView *)waterFlowView
{
    return 2;
}
#pragma mark - 瀑布流中图片的个数
- (NSInteger)waterFlowView:(YLWaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns
{
    return self.modelDicArr.count;
}

- (YLWaterFlowCell *)waterFlowView:(YLWaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyCell";
    YLWaterFlowCell *cell = [waterFlowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YLWaterFlowCell alloc] initWithResueIdentifier:ID];
    }
    // 异步加载图像
    /*
     提示，如果是下载图片 使用SDWebImage可以指定缓存策略，包括内存缓存 并 磁盘缓存
     */
//    cell.imageView.image = _images[indexPath.row];
//    cell.textLabel.text = @"测试lab在哪儿";
    cell.matchModel = self.modelArr[indexPath.row];
    
    return cell;
}
#pragma mark - 每个单元格的高度
//- (CGFloat)waterFlowView:(YLWaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIImage *image = _images[indexPath.row];
//    NSInteger column = [self numberOfColumnsInWaterFlowView:waterFlowView];
//    CGFloat colWidth = waterFlowView.bounds.size.width / column;
//    // 计算图像的高度
//    // 例如：h = 275 w = 200 目前的宽度是 320 / 3 = 106.667
//    float newHeigth = image.size.height / image.size.width * colWidth;
//    return newHeigth+(arc4random()%20+10);
//}
#pragma mark - 点击单元格
- (void)waterFlowView:(YLWaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return;
    }
    YLMatchModel *model = self.modelArr[indexPath.row];
    YLMatchDetailController *detail = [[YLMatchDetailController alloc] init];
    detail.id = model.id;
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"选中单元格： %@", indexPath);
    
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
    UIButton *seminarBt = [self creatBtTitle:@"专题" NormalColor:[UIColor grayColor] selectedColor:[UIColor redColor] target:self action:@selector(test)];
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
#pragma mark -----添加子视图控制器
- (void)test {
    
}
@end
