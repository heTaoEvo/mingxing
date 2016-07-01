//
//  LXYShangPingXiangQingViewController.m
//  明星衣橱
//
//  Created by joker on 16/6/29.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYShangPingXiangQingViewController.h"
#import "LoadMoreView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZYScrollView.h"

@interface LXYShangPingXiangQingViewController () <UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UIView * topBar,*selectedImage;
@property(nonatomic,strong)UIVisualEffectView * ChiMa;
@property(nonatomic,strong)UILabel * secPageHeaderLabel;
@property(nonatomic,strong)SDCycleScrollView *sv;


@end

@implementation LXYShangPingXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   ;
    [self downloadShuJu];
    self.firstScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
     self.firstScroll.contentSize = CGSizeMake(0, 700);
    self.firstScroll.tag = 100;
    self.firstScroll.delegate=self;
    self.firstScroll.backgroundColor = [UIColor greenColor];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, Screen_Height)];
    [self.view addSubview:self.firstScroll];
    [self.view addSubview:self.webView];
    self.topBar.backgroundColor = [UIColor blueColor];
    NSURL *url = [NSURL URLWithString:@"http://m.hichao.com/lib/interface.php?m=goodsdetail&sid=2543585"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scrollView.tag =200;
    self.webView.scrollView.delegate=self;
    _webView.scalesPageToFit = YES;
    self.navigationController.navigationBarHidden = YES;
   
     [self.view bringSubviewToFront:self.topBar];
    [self addUIvew];
    
    //加载更多
    UIView * loadMoreView=[LoadMoreView view];
    loadMoreView.backgroundColor = [UIColor blueColor];
    loadMoreView.frame=CGRectMake(0, self.firstScroll.contentSize.height-44, Screen_Width, 44);
    [self.firstScroll addSubview:loadMoreView];
   
    //self.secPageHeaderLabel.frame=CGRectMake(0, 50, Screen_Width, 21);

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

#pragma mark - 懒加载
- (void)addUIvew
{
    
    self.sv = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 200, 300, 300) delegate:nil    placeholderImage:nil];
    self.sv.imageURLStringsGroup = @[@"http://mxycsku.qiniucdn.com/group5/M00/04/9C/wKgBfVdwnMKAXbVRAAEIfrAZtLM27.jpeg?imageMogr2/thumbnail/600x%3E/quality/80",@"http://mxycsku.qiniucdn.com/group5/M00/06/89/wKgBf1dwnMeAQz7CAADfI_s_4R0150.jpg"];
    [self.firstScroll addSubview:self.sv];
    self.sv.delegate = self;
    
  
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(0, 0, 100, 111);
    
   
    [btn1 addTarget:self action:@selector(chooseChiMa:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.firstScroll addSubview:btn1];
    [self.firstScroll bringSubviewToFront:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.backgroundColor = [UIColor blackColor];
    btn2.frame = CGRectMake(100, 0, 100, 111);
    
    
    
    [btn2 addTarget:self action:@selector(chooseChiMa2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstScroll addSubview:btn2];
    [self.firstScroll bringSubviewToFront:btn2];
    
}
-(UILabel*)secPageHeaderLabel{
    if (_secPageHeaderLabel==nil) {
        _secPageHeaderLabel=[[UILabel alloc]init];
        _secPageHeaderLabel.frame=CGRectMake(0, 50, Screen_Width, 21);
        _secPageHeaderLabel.textColor=[UIColor whiteColor];
        _secPageHeaderLabel.font=[UIFont systemFontOfSize:12];
        _secPageHeaderLabel.alpha=0;
        _secPageHeaderLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:_secPageHeaderLabel];
    }
    return _secPageHeaderLabel;
}

-(UIVisualEffectView*)ChiMa{
    if (_ChiMa==nil) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _ChiMa = [[UIVisualEffectView alloc]initWithEffect:blur];
        _ChiMa.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
     
        
        _ChiMa.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height, Screen_Height, Screen_Height/2)];
        vi.backgroundColor= [UIColor redColor];
        
        [_ChiMa.contentView addSubview:vi];
     [self.view addSubview:_ChiMa];
        
    }
    return _ChiMa;
}
-(UIView *)topBar
{
    if (_topBar==nil)
    {
        self.topBar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height, [UIScreen mainScreen].bounds.size.width, 44)];
        self.topBar.backgroundColor = [UIColor whiteColor];
        UIView *gundongTiao = [[UIView alloc]initWithFrame:CGRectMake(0, self.topBar.frame.size.height-6, [UIScreen mainScreen].bounds.size.width/4, 6)];
        gundongTiao.backgroundColor = [UIColor redColor];
        gundongTiao.tag = 1000000;
        [self.topBar addSubview:gundongTiao];
        
        //创建btn
        for (int i=0; i<4; i++)
        {
            UIButton *fenlei = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*(i), 0, [UIScreen mainScreen].bounds.size.width/4, 44)];
           // NSDictionary * dic =self.fenLei.data.items[i];
            fenlei.tag = i;
          //  [fenlei setTitle:dic[@"nav_name"] forState:UIControlStateNormal];
            [fenlei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [fenlei setTitleColor:[UIColor colorWithRed:220/255.0 green:56/255.0 blue:122/255.0 alpha:1] forState:UIControlStateSelected];
            [fenlei addTarget:self action:@selector(moveGunDong:) forControlEvents:UIControlEventTouchUpInside];
            [self.topBar addSubview:fenlei];
      //  _topBar.frame=CGRectMake(0, NaviBarH, Screen_Width, TopTabBarH);
      
     
    }
        [self.view addSubview:_topBar];
        // [self.view bringSubviewToFront:self.topBar];
    }
  // [self.view bringSubviewToFront:self.topBar];
    
    return _topBar;
}


#pragma mark - 按钮方法
- (void)chooseChiMa:(UIButton *)btn
{
   
   // [self.view bringSubviewToFront:self.ChiMa];
   [UIView animateWithDuration:3 animations:^{
       //self.ChiMa.alpha =0.5;
     
       UIView *vi =  self.ChiMa.contentView.subviews[0];
     vi .frame = CGRectMake(0, Screen_Height/2, Screen_Width, Screen_Height/2);
   }];
    
}


- (void)chooseChiMa2:(UIButton *)btn
{
    NSLog(@"11111");
  
}

- (void)moveGunDong:(UIButton *)fenlei
{
   
    
    UIView *vi = [self.view viewWithTag:1000000];
    [UIView animateWithDuration:0.5 animations:^{
        vi.frame = CGRectMake(fenlei.frame.origin.x, 44-6, fenlei.frame.size.width, 6);
    }];
  
    
    
}


#pragma mark - 图片滚动协议方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    static BOOL orKai =NO;
    if (!orKai) {
        
    
    UIView *vi =[[UIView alloc]initWithFrame:CGRectMake(Screen_Width/2, Screen_Height/2, 0, 0)];
   ;

    
    vi.backgroundColor = [UIColor blackColor];
   
    NSArray *arr = @[@"http://mxycsku.qiniucdn.com/group5/M00/04/9C/wKgBfVdwnMKAXbVRAAEIfrAZtLM27.jpeg?imageMogr2/thumbnail/600x%3E/quality/80",@"http://mxycsku.qiniucdn.com/group5/M00/06/89/wKgBf1dwnMeAQz7CAADfI_s_4R0150.jpg"];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
    NSString *str1 = arr[index];
    NSURL *str =[NSURL URLWithString:str1];
    [image1 setImageWithURL:str placeholderImage:nil];
         image1.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image1];
           self.sv.autoScroll = NO;
   [self.view addSubview:vi];
    [self.view addSubview:image1];
   
   
  //  NSLog(@"%@",scroll);
 
    
    [UIView animateWithDuration:0.5 animations:^{
        vi.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        vi.alpha =1;
        vi.backgroundColor = [UIColor blackColor];
        image1.center = CGPointMake(self.view.center.x, self.view.center.y);
        image1.bounds = CGRectMake(0, 0, Screen_Width , Screen_Height);
  
    } completion:^(BOOL finished) {
        [image1 removeFromSuperview];
        [vi removeFromSuperview];
//        [self.sv removeFromSuperview];
////        self.sv.center = CGPointMake(self.view.center.x, self.view.center.y);
////       self.sv.bounds = CGRectMake(0, 0, Screen_Width , 300);
        UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        scroller.contentSize = CGSizeMake(Screen_Width*4, 0);
        scroller.pagingEnabled = YES;
        scroller.backgroundColor = [UIColor blackColor];
        scroller.tag =9999;
        for (int i =0; i<4; i++) {
            ZYScrollView *ZYsv = [[ZYScrollView alloc]init];
            ZYsv.frame = CGRectMake(Screen_Width*i, 0, Screen_Width, Screen_Height);
            UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
            NSString *str1 = arr[i%2];
            NSURL *str =[NSURL URLWithString:str1];
            //[im setImageWithURL:str placeholderImage:nil];
            im.image = [UIImage imageNamed:@"1242-2208-3"];
            im.backgroundColor = [UIColor redColor];
           ZYsv.imageX = im;
            
            im.contentMode = UIViewContentModeScaleAspectFit;
            [ZYsv addSubview:im];
            NSLog(@"%@",im);
            ZYsv.delegate = self;
            ZYsv.backgroundColor = [UIColor blackColor];
            //设置内容视图的大小
            ZYsv.contentSize = ZYsv.frame.size;
            //设置缩放最小比例 CGFloat类型 默认为1.0
            ZYsv.minimumZoomScale = 0.2;
            //设置缩放最大比例 CGFloat类型 默认为1.0
            ZYsv.maximumZoomScale = 2.0;
            ZYsv.bounces = NO;
            ZYsv.tag = 1000+i;
             ZYsv.zoomScale = 1.0;
            [scroller addSubview:ZYsv];
        }
        
           [self.view addSubview:scroller];
        
        
     //   [vi addSubview:ZYsv];
                              
        //[self.view addSubview: self.sv];
        orKai = YES;
    }];
     
    }
    
}



#pragma mark - scroll协议方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[ZYScrollView class]]) {
        return;
    }
    if (scrollView.tag==9999) {
        return;
    }
    
    if(scrollView.tag == 100)
    {
        if(scrollView.contentOffset.y<0)
        {
            scrollView.contentOffset = CGPointMake(0, 0);//限制不能下拉
        }
    }
    
    
    
    
    if (scrollView.tag == 200)
    {
        CGFloat min = 0;
        CGFloat max = -130;
        self.secPageHeaderLabel.alpha=scrollView.contentOffset.y/max;
        
        
        if (scrollView.contentOffset.y>max && scrollView.contentOffset.y<min)
        {
            self.secPageHeaderLabel.text = @"下拉，回到宝贝详情";
            self.secPageHeaderLabel.frame = CGRectMake(0, 50-scrollView.contentOffset.y/10.0, Screen_Width, 41);
        }
        if (scrollView.contentOffset.y<max)
        {
            self.secPageHeaderLabel.text = @"释放，回到宝贝详情";
            
        }
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if ([scrollView isMemberOfClass:[ZYScrollView class]]) {
        return;
    }
    if (scrollView.tag==9999) {
        return;
    }
    //上拉
    if (scrollView.tag == 100)
    {
        
        
        CGFloat min = self.firstScroll.contentSize.height-Screen_Height+50;
        if (scrollView.contentOffset.y>min) {
            [UIView animateWithDuration:0.5 animations:^{
                //将第二个scroll放到主屏幕
                self.webView.frame = CGRectMake(0, 44, Screen_Width, Screen_Height);
                //将第二个顶部的控件放到主屏幕
                self.topBar.frame = CGRectMake(0, 0, Screen_Width, 44);
                //将第一个scroll放到屏幕外
                self.firstScroll.frame = CGRectMake(0, -self.firstScroll.frame.size.height, Screen_Width, Screen_Height);
//                self.topBar.sd_layout
//                .leftSpaceToView(self.view,0)
//                .rightSpaceToView(self.view,0)
//                .topSpaceToView(self.view,0)
//                .heightIs(44);
//                
//                self.firstScroll.sd_layout
//                .leftSpaceToView(self.view,0)
//                .rightSpaceToView(self.view,0)
//                .bottomSpaceToView(self.view,0)
//                .heightIs(Screen_Height);
//                
//                
//                self.webView.sd_layout
//                .leftSpaceToView(self.view,0)
//                .rightSpaceToView(self.view,0)
//                .topSpaceToView(self.topBar,0)
//                .heightIs(Screen_Height);
//                
                
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    //下拉
   
    if (scrollView.tag == 200)
    {
        
        if (scrollView.contentOffset.y < -130)
        {
            [UIView animateWithDuration:0.5 animations:^{
                //将第一个scroll放到主屏幕
                self.webView.frame = CGRectMake(0, Screen_Height, Screen_Width, Screen_Height);
                //将第二个顶部的控件放到主屏幕外
                self.topBar.frame = CGRectMake(0, Screen_Height, Screen_Width, 44);
                //将
                self.firstScroll.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
}


#pragma mark - UIScrollViewDelegate 缩放常用四方法
//缩放过程中会一直调用 即只要zoomScale值改变就调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidZoom");
}

//返回要缩放的UIView对象 如果return nil 什么都不发生 要执行多次
- (UIView *)viewForZoomingInScrollView:(ZYScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[ZYScrollView class]]) {
        ZYScrollView *sc =(ZYScrollView *)scrollView;
       
    NSLog(@"viewForZoomingInScrollView----%@", NSStringFromCGRect(sc.imageX.frame));
    
    return sc.imageX;
     }
    return nil;
}

//在滚动视图开始缩放内容前调用  一次有效缩放 只执行一次
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming---%@", view);
}

//当缩放结束后，并且在缩放大小回到min和max之间的弹射动画完成后 调用该方法
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

#pragma mark - 网络部分
- (void)downloadShuJu
{
    AFHTTPSessionManager *manger =  [AFHTTPSessionManager manager];
// &source=mxyc_ios&token=&version=6.6.3
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.dic options:NSJSONWritingPrettyPrinted error:nil];
    NSData *dataaaa = [data base64EncodedDataWithOptions:0];
    
    NSString *str = [[NSString alloc]initWithData:dataaaa encoding:NSUTF8StringEncoding];
   
    NSDictionary *dic = @{@"data":str,@"method":@"/goods",@"sign":@"ab18b70f17eb23820846e3c5a713ba3d",@"source":@"mxyc_ios",@"version":@"6.6.3"};
    [manger POST:@"http://api-v2.mall.hichao.com/goods?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@#",error);
    }];
}
@end
