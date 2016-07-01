//
//  LXYcollectionTableViewCell.h
//  明星衣橱
//
//  Created by joker on 16/6/27.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXYShouYeCollectionView.h"
#import "LXYScrollBtn.h"
@interface LXYcollectionTableViewCell : UITableViewCell

@property (weak, nonatomic)IBOutlet  LXYShouYeCollectionView *rightView;

@property (weak, nonatomic) IBOutlet LXYShouYeCollectionView *leftView;
@property (strong ,nonatomic) LXYScrollBtn *leftBtn;
@property (strong ,nonatomic) LXYScrollBtn *rightBtn;



@end
