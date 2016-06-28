//
//  LXYShangPing.h
//  明星衣橱
//
//  Created by joker on 16/6/28.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class Data,Items,Component,Action;
@interface LXYShangPing : JSONModel

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) Data *data;

@end












