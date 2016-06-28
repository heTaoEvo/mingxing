//
//  YLWaterFlowView.h
//  明星衣橱
//
//  Created by jokerYL on 16/6/26.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
@class YLWaterFlowView;
@class YLWaterFlowCell;
#pragma mark - 数据源协议方法
@protocol YLWaterFlowViewDataSource <NSObject>

// 在每一列中的数据行数
- (NSInteger)waterFlowView:(YLWaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns;

// 指定indexPath位置的单元格视图
- (YLWaterFlowCell *)waterFlowView:(YLWaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// 使用@optional描述符，可以指定方法不一定被实现
@optional
// 指定列数
- (NSInteger)numberOfColumnsInWaterFlowView:(YLWaterFlowView *)waterFlowView;

@end

#pragma mark - 代理协议方法

/*
 1. <NSObject>表示继承自NSObject对象都可以遵守代理协议
 2. 如果当前对象的父类有delegate属性，会自动合并
 */
@protocol YLWaterFlowViewDelegate <NSObject, UIScrollViewDelegate>

@optional
/// 1. 选中单元格
- (void)waterFlowView:(YLWaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/// 2. 指定indexPath单元格的行高
- (CGFloat)waterFlowView:(YLWaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

// 3. 刷新数据
- (void)waterFlowViewRefreshData:(YLWaterFlowView *)waterFlowView;

@end

@interface YLWaterFlowView : UIScrollView
@property (weak, nonatomic) id<YLWaterFlowViewDataSource>dataSource;
@property (weak, nonatomic) id<YLWaterFlowViewDelegate>delegate;

#pragma mark 刷新数据
- (void)reloadData;
#pragma mark 查询可重用单元格
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;


@end
