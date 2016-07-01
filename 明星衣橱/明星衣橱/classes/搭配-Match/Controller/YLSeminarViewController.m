//
//  YLSeminarViewController.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/29.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLSeminarViewController.h"
#import <AFNetworking.h>
#import "YLSeminarTableViewCell.h"
#import "YLSeminary.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "YLSeminaryDetailController.h"

@interface YLSeminarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) NSMutableArray *dicArr;
@property (nonatomic,strong) NSMutableArray *seminaryArr;
@property (weak, nonatomic) IBOutlet UITableView *myTab;
@property (nonatomic,copy) NSString *flag;

@end

@implementation YLSeminarViewController
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.seminaryArr = [NSMutableArray array];
    self.dicArr = [NSMutableArray array];
    [self.myTab registerNib:[UINib nibWithNibName:@"YLSeminarTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellID"];
    self.myTab.rowHeight = 300;
    
    [self setMJRefresh];
    [self sendSeq];
}
#pragma mark -----设置刷新头和尾
- (void)setMJRefresh {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    UIImage *img = [self OriginImage:[UIImage imageNamed:@"mascot_1"] scaleToSize:CGSizeMake(50, 50)];
    UIImage *img1 = [self OriginImage:[UIImage imageNamed:@"mascot_2"] scaleToSize:CGSizeMake(50, 50)];
    NSArray *arr = @[img];
    NSArray *arr1 = @[img,img1];
    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr1 forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉即可刷新.." forState:MJRefreshStateIdle];
    [header setTitle:@"松开即可刷新.." forState:MJRefreshStatePulling];
    [header setTitle:@"奋力加载中.." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.myTab.mj_header = header;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"奋力加载中.." forState:MJRefreshStateIdle];
    [footer setTitle:@"奋力加载中.." forState:MJRefreshStatePulling];
    [footer setTitle:@"奋力加载中.." forState:MJRefreshStateRefreshing];
    self.myTab.mj_footer = footer;
    [self.myTab.mj_header endRefreshing];
    
}
#pragma mark -----缩放加载图片
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
#pragma mark -----下拉
- (void)loadNewData {
    if (self.dicArr.count>0) {
        [self.dicArr removeAllObjects];
    }
    [self.manager GET:@"http://api-v2.mall.hichao.com/mix_topics?flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.dicArr addObjectsFromArray:responseObject[@"data"][@"items"]];
        
        self.flag = responseObject[@"data"][@"flag"];
        
        [self initModelArr];
        [self.myTab reloadData];
        [self.myTab.mj_header endRefreshing];
        [self.myTab.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark -----上拉
- (void)loadMoreData {
//    NSArray *arr = [self.flag componentsSeparatedByString:@" "];
//    YLLog(@"%@",arr);
//    NSString *str = @"%20";
//    [self.manager GET:[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mix_topics?flag=%@%@%@&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=",arr[0],str,arr[1]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSArray *arr = responseObject[@"data"][@"items"];
//        YLLog(@"%@",self.dicArr);
//        [self.dicArr addObjectsFromArray:arr];
//        YLLog(@"------%ld",self.dicArr.count);
//        self.flag = responseObject[@"data"][@"flag"];
//        
//        [self initModelArr];
//        [self.myTab reloadData];
//        [self.myTab.mj_footer endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    [self sendSeq];
}
#pragma mark -----发送请求
- (void)sendSeq {
    static NSString *url = @"http://api-v2.mall.hichao.com/mix_topics?flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=";
    if (self.flag != nil) {
        NSArray *arr = [self.flag componentsSeparatedByString:@" "];
        
        NSString *str = @"%20";
        url = [NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mix_topics?flag=%@%@%@&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=",arr[0],str,arr[1]];
    }
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YLLog(@"%@",responseObject);
        [self.dicArr addObjectsFromArray:responseObject[@"data"][@"items"]];
        
        self.flag = responseObject[@"data"][@"flag"];
        
        [self initModelArr];
        [self.myTab reloadData];
        [self.myTab.mj_header endRefreshing];
        [self.myTab.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)initModelArr {
    [self.seminaryArr removeAllObjects];
    for (int i = 0; i < self.dicArr.count; i++) {
        YLSeminary *seminary = [YLSeminary mj_objectWithKeyValues:self.dicArr[i][@"component"]];
        [self.seminaryArr addObject:seminary];
    }
    YLLog(@"%ld",self.seminaryArr.count);
   
}
#pragma mark ----UITable数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dicArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSeminarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell.seminary = self.seminaryArr[indexPath.row];
    return cell;
    
}
#pragma mark -----UITable代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLSeminary *seminary = self.seminaryArr[indexPath.row];
    
    [self.manager GET:[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/topic/view?more_items=1&width=768&topic_id=%@&twm=1&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=4E7C6D2F-865D-44C4-BC68-F7871DBB6295&gs=1536x2048&gos=9.3.1&access_token=qGSrKUmdHPQeQ6Ugv6amf9scRLeCcxDL_vdwNYMaoHo",seminary.id] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YLLog(@"success-----%@",responseObject);
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YLLog(@"error------%@",error);
    
    }];
}
@end
