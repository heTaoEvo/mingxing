//
//  ZYScrollView.m
//  ScaleScrollView
//
//  Created by Shuaiqi Xue on 14-7-10.
//  Copyright (c) 2014年 www.zhiyou100.com 智游3G培训学院. All rights reserved.
//

#import "ZYScrollView.h"

@implementation ZYScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

//触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount==2)
    {   
        CGFloat zoomScale = self.zoomScale;
        //三木运算符  <表达式1>?<表达式2>:<表达式3>; "?"运算符的含义是: 先求表达式1的值, 如果为真, 则执行表达式2，并返回表达式2的结果 ; 如果表达式1的值为假, 则执行表达式3 ，并返回表达式3的结果.
        zoomScale = zoomScale==1.0?2.0:1.0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        //改变缩放比例
        self.zoomScale = zoomScale;
        [UIView commitAnimations];
    }
}

//- (void)setImage:(UIImage *)image
//{
//    _imageView.image = image;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
