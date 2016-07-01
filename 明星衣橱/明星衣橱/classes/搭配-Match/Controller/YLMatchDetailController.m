//
//  YLMatchDetailController.m
//  明星衣橱
//
//  Created by jokerYL on 16/6/30.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "YLMatchDetailController.h"
#import "YLScrollTableViewCell.h"
#import "YLButtonTableViewCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YLUser.h"
@interface YLMatchDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTab;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) YLUser *user;

@end

@implementation YLMatchDetailController
- (AFHTTPSessionManager *)manager {
    if(!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTab registerNib:[UINib nibWithNibName:@"YLScrollTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScrollCell"];
    [self.myTab registerNib:[UINib nibWithNibName:@"YLButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"ButtonCell"];
    self.myTab.rowHeight = 300;
    [self sendReq];
}
#pragma mark -----网络请求
- (void)sendReq {
    [self.manager GET:[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/star/detail?id=%@&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=",self.id] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [YLUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        _user = [YLUser mj_objectWithKeyValues:responseObject[@"data"]];
        
        [self.myTab reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -----UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScrollCell"];
        YLScrollTableViewCell *scrollCell = (YLScrollTableViewCell *)cell;
        scrollCell.user = _user;
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        YLButtonTableViewCell *buttonCell = (YLButtonTableViewCell *)cell;
    }
    return cell;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section != 1) {
//        return nil;
//    }
//    UIView *vi = [[UIView alloc] init];
//}
@end
