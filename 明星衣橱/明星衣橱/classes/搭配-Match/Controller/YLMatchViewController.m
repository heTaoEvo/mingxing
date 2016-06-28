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
@interface YLMatchViewController () <YLWaterFlowViewDataSource,YLWaterFlowViewDelegate>
@property (strong, nonatomic) YLWaterFlowView *waterFlowView;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) ALAssetsLibrary *library;

@property (strong, nonatomic) NSMutableArray *images;

@property (nonatomic,strong) UIScrollView *categoryScr;
@property (nonatomic,copy) NSArray *modelDicArr;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@property (nonatomic,strong) NSMutableArray *modelArr;
@end

@implementation YLMatchViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UIScrollView *)categoryScr {
    if (!_categoryScr) {
        _categoryScr = [[UIScrollView alloc] init];
    }
    return _categoryScr;
}
#pragma mark - 实例化视图

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpNaviTitleItem];
    
    [self setUpCategoryScrollView];
    [self sendReq];
   

}
- (void)sendReq {
    [self.manager GET:@"http://api-v2.mall.hichao.com/star/list?category=%E5%85%A8%E9%83%A8&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=993B54FE-6FF3-4A86-BC4A-2D3991478F6B&gs=1536x2048&gos=9.3.2&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _modelDicArr = responseObject[@"data"][@"items"];
        //请求成功才初始化模型数组
        self.modelArr = [NSMutableArray array];
        self.images = [NSMutableArray array];
        
        [self testMethod];
        
        //请求成功才设置瀑布流
        [self setUpDataSource];
        //YLLog(@"success-------%@",responseObject[@"data"][@"items"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        YLLog(@"error------%@",error);
    }];
}
- (void)testMethod {
    for (int i = 0; i<self.modelDicArr.count; i++) {
        NSDictionary *dic = self.modelDicArr[i];
        
        [self.modelArr addObject:[YLMatchModel mj_objectWithKeyValues:dic[@"component"]]];
        YLMatchModel *model = self.modelArr[i];
        NSArray *arr = [model.picUrl componentsSeparatedByString:@"?"];
        YLLog(@"%@-----%@",arr[0],model.picUrl);
        UIImageView *vi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [vi sd_setImageWithURL:[NSURL URLWithString:@"http://s5.pimg.cn/group5/M00/04/7B/wKgBf1dpIzyARhzvAAaWxYUyZ4w096.jpg?imageMogr2/format/WEBP/thumbnail/314x%3E"] placeholderImage:[UIImage imageNamed:@"1024-768-4"]];
        [self.images addObject:vi.image];
    }
    
}

- (void)setUpCategoryScrollView {
    self.categoryScr.frame = CGRectMake(0, 64, self.navigationController.navigationBar.frame.size.width, 30);
    
    
//    for (int i = 0; i<10; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_categoryScr addSubview:button];
//        
//    }
    [self.view addSubview:_categoryScr];
}
//设置瀑布流数据源
- (void)setUpDataSource {
    // 如此做法是为了保证视图控制器能够嵌套使用！
    // 1. 实例化一个没有大小的瀑布流视图
    
    _waterFlowView = [[YLWaterFlowView alloc] initWithFrame:CGRectMake(0, 94, 375, 623)];
    [self.view addSubview:_waterFlowView];
    
    [_waterFlowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryScr.mas_bottom);
        make.width.mas_equalTo(_categoryScr.mas_width);
        make.left.equalTo(_categoryScr.mas_left);
        make.height.mas_equalTo(self.view.mas_height);
    }];
    
    
    _waterFlowView.backgroundColor = [UIColor yellowColor];
    // 2. 要保证当前视图与父视图同样大小
    // 如果看到头文件中的枚举类型有位移符号，就可以使用 | “并”操作，可以同时使用多个选项！
    [_waterFlowView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    // 3. 设置代理和数据源
    [_waterFlowView setDataSource:self];
    [_waterFlowView setDelegate:self];
    [_waterFlowView reloadData];
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
    YLMatchModel *model = self.modelArr[indexPath.row];
    cell.matchModel = model;
    
    return cell;
}

#pragma mark - 每个单元格的高度
- (CGFloat)waterFlowView:(YLWaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = _images[indexPath.row];
    NSInteger column = [self numberOfColumnsInWaterFlowView:waterFlowView];
    CGFloat colWidth = waterFlowView.bounds.size.width / column;
    
    // 计算图像的高度
    // 例如：h = 275 w = 200 目前的宽度是 320 / 3 = 106.667
    float newHeigth = image.size.height / image.size.width * colWidth;
    
    return newHeigth+(arc4random()%20+10);
}

#pragma mark - 选中单元格
- (void)waterFlowView:(YLWaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中单元格： %@", indexPath);
    
    //    MGJData *data = self.dataList[indexPath.row];
    // 取大图URL，异步加载并显示相册
    
}
#pragma mark ----设置导航titleView
- (void)setUpNaviTitleItem {
    UIView *bgVi = [[UIView alloc] init];
    UIView *redVi = [[UIView alloc] init];
    redVi.frame = CGRectMake(0, 30, 40, 8);
    bgVi.bounds = CGRectMake(0, 0, 200, 40);
    bgVi.backgroundColor = [UIColor greenColor];
    UIButton *matchBt = [self creatBtTitle:@"搭配" NormalColor:[UIColor grayColor] selectedColor:[UIColor redColor] target:self action:@selector(test)];
    UIButton *seminarBt = [self creatBtTitle:@"专题" NormalColor:[UIColor grayColor] selectedColor:[UIColor redColor] target:self action:@selector(test)];
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
    
    self.navigationItem.titleView = bgVi;
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
- (void)test {
    YLLog(@"111");
}
@end
