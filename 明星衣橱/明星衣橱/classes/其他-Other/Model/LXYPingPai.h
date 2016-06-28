//
//  LXYPingPai.h
//  明星衣橱
//
//  Created by joker on 16/6/27.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@class Data,Region_Skus,Component,Action,Region_Brands,Component,Action,Region_Pictures,Component,Action,Region_Name,Component,Action;
@interface LXYPingPai : JSONModel

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) Data *data;

@end
//修改
@interface Items : NSObject

@property (nonatomic, strong) Component *component;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *height;

@end
//以上
@interface Data : JSONModel

@property (nonatomic, assign) NSInteger region_num;

@property (nonatomic, strong) NSArray<Region_Skus *> *region_skus;

@property (nonatomic, copy) NSString *appApi;

@property (nonatomic, strong) NSArray<Region_Name *> *region_name;

@property (nonatomic, strong) NSArray<Region_Brands *> *region_brands;

@property (nonatomic, strong) NSArray<Region_Pictures *> *region_pictures;

//修改
@property (nonatomic, strong) NSArray<Items *> *items;

@property (nonatomic, copy) NSString *flag;
//以上
@end


@interface Region_Skus : JSONModel

@property (nonatomic, strong) Component *component;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *height;

@end

@interface Component : JSONModel

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *componentType;

@property (nonatomic, strong) Action *action;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *origin_price;

@end

@interface Action : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *tab_id;

@property (nonatomic, copy) NSString *main_image;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *sourceId;

@property (nonatomic, copy) NSString *post_id;

@property (nonatomic, copy) NSString *actionType;

@property (nonatomic, copy) NSString *bannerId;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *banner_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *region_id;

@end

@interface Region_Brands : JSONModel

@property (nonatomic, strong) Component *component;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *height;

@end


@interface Region_Pictures : JSONModel

@property (nonatomic, strong) Component *component;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *height;

@end


@interface Region_Name : JSONModel

@property (nonatomic, strong) Component *component;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *height;

@end


