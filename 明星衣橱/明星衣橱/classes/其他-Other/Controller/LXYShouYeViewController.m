//
//  LXYShouYeViewController.m
//  明星衣橱
//
//  Created by joker on 16/6/24.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "LXYShouYeViewController.h"
#import <UIView+SDAutoLayout.h>
#import <UITableView+SDAutoTableViewCellHeight.h>
#import "LXYshouYeScrollTableViewCell.h"
#import "LXYcollectionTableViewCell.h"
#import <AFNetworking.h>
#import "LXYPingPai.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "LXYScrollBtn.h"
#import <YYModel.h>
#import "LXYShangPing.h"
#import <UIKit+AFNetworking.h>
#import <MJRefresh.h>
#import "LXYfenlei.h"
#import "LXYShangPingXiangQingViewController.h"
#import "LXYXdata.h"
#import "LXYDaoJiShi.h"


@interface LXYShouYeViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *guoJia,*guoJiaTuPian;
@property (nonatomic, strong) NSMutableArray *Pingpai,*sc,*items;
@property (nonatomic ,retain) NSTimer *time;
@property (nonatomic ,strong) LXYShangPing *shangping;
@property (nonatomic ,strong) LXYfenlei *fenLei;
@end

@implementation LXYShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guoJia = @[@"韩国馆",@"欧美馆",@"日本馆",@"中国馆",@"全球精选",@"精品美妆",];
    self.guoJiaTuPian = @[@"icon_korea",@"icon_america",@"icon_my_notice_num",@"icon_france",@"icon_Italy",@"icon_france",];
    self.items = [[NSMutableArray alloc]init];
    [self downloadPingPaiShuJu];
    [self downloadShangPingShuJu];
    [self dnowloadFenLei];
    self.sc = [[NSMutableArray alloc]init];
    self.time=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(play) userInfo:nil repeats:YES];
   self.automaticallyAdjustsScrollViewInsets = NO;
    self.table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:UITrackingRunLoopMode];
    self.table.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadPingPaiShuJu];
    }];
   self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [self downloadShangPingShuJu];
       
   }];
    
  
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - table协议

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 6;
    }
    return self.items.count/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
#pragma mark -设置上面带scrollview的cell
    if (indexPath.section == 0) {
     LXYshouYeScrollTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn setTitle:self.guoJia[indexPath.row] forState:UIControlStateNormal];
    NSString *str = self.guoJiaTuPian[indexPath.row];
        [cell.btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        //第一个scoll
       
        if (self.Pingpai.count==6) {
            
      
       LXYPingPai *pingpai = self.Pingpai[indexPath.row];
       NSArray *brand =  pingpai.data.region_brands;
        
        if (brand.count>0) {
            
            
            cell.Scroll1.contentSize = CGSizeMake((brand.count+1)*50, 50);
            cell.Scroll1.delegate = self;
            for (UIView *ui in cell.Scroll1.subviews) {
                [ui removeFromSuperview];
            }
        for (int i=0; i<brand.count+1; i++) {
            
            UIImageView *iv = [[UIImageView alloc]init];
            //iv.backgroundColor = [UIColor whiteColor];
            if (i==brand.count) {
                [iv setImage:[UIImage imageNamed:@"button_more"]];
                iv.frame = CGRectMake(50*i, 0, 50, 50);
                [cell.Scroll1 addSubview:iv];
            }else if (i<brand.count){
                NSDictionary *brands = brand[i];
                
              
            
                NSURL *url = [NSURL URLWithString:brands[@"component"][@"picUrl"]];
               
            [iv sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"button_more"]];
            iv.frame = CGRectMake(50*i, 0, 50, 50);
            [cell.Scroll1 addSubview:iv];
               
            }
        }
        }
        }
        //第二个scroll
        
        if (self.Pingpai.count==6) {
            
            
            LXYPingPai *pingpai = self.Pingpai[indexPath.row];
            NSArray *brand =  pingpai.data.region_pictures;
           
            if (brand.count>0) {
                
                
                cell.SCroll2.contentSize = CGSizeMake((brand.count+2)*(Screen_Width), 200);
                cell.SCroll2.delegate = self;
                cell.SCroll2.contentOffset = CGPointMake(Screen_Width, 0);
                for (UIView *ui in cell.SCroll2.subviews) {
                    [ui removeFromSuperview];
                }
                for (int i=0; i<brand.count; i++) {
                    UIImageView *iv = [[UIImageView alloc]init];
                   
                        NSDictionary *brands = brand[i];
                  
                    
                        NSURL *url = [NSURL URLWithString:brands[@"component"][@"picUrl"]];
                        
                        [iv sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"button_more"]];
                        iv.frame = CGRectMake(Screen_Width*i+Screen_Width, 0, Screen_Width, 200);
                        [cell.SCroll2 addSubview:iv];
                    
                   
                }
                
                //第一张图
                UIImageView *iv0 = [[UIImageView alloc]init];
                
                NSDictionary *first = brand[brand.count-1];
                
                
                
                NSURL *url0 = [NSURL URLWithString:first[@"component"][@"picUrl"]];
                
                [iv0 sd_setImageWithURL:url0  placeholderImage:[UIImage imageNamed:@"button_more"]];
                iv0.frame = CGRectMake(0, 0, Screen_Width, 200);
                [cell.SCroll2 addSubview:iv0];
                
                //最后一张图
                
                UIImageView *iv1 = [[UIImageView alloc]init];
                
                NSDictionary *last = brand[0];
                
                
                
                NSURL *url1 = [NSURL URLWithString:last[@"component"][@"picUrl"]];
                
                [iv1 sd_setImageWithURL:url1  placeholderImage:[UIImage imageNamed:@"button_more"]];
                iv1.frame = CGRectMake((brand.count+1)*Screen_Width, 0, Screen_Width, 200);
                [cell.SCroll2 addSubview:iv1];
               cell.SCroll2.tag=12345;
                cell.SCroll2.ArrCount = brand.count;
                
               
            }
        }
        [self.sc addObject:cell.SCroll2];
#pragma mark - 第三个Scroll
        if (self.Pingpai.count==6) {
            
            
            LXYPingPai *pingpai = self.Pingpai[indexPath.row];
            NSArray *brand =  pingpai.data.region_skus;
            
            if (brand.count>0) {
                
                
                cell.Scroll3.contentSize = CGSizeMake((brand.count+1)*50, 50);
                cell.Scroll3.delegate = self;
                for (UIView *ui in cell.Scroll3.subviews) {
                    [ui removeFromSuperview];
                }
                for (int i=0; i<brand.count+1; i++) {
                    LXYScrollBtn *iv = [[LXYScrollBtn alloc]init];
                                       if (i==brand.count) {
                       
                        [iv sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"button_more"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [iv layoutIfNeeded];
                        }];
                        
                        iv.frame = CGRectMake(50*i, 0, 50, 300);
                        [cell.Scroll3 addSubview:iv];
                    }else if (i<brand.count){
                        NSDictionary *brands = brand[i];
                        
                        
                        
                        NSURL *url = [NSURL URLWithString:brands[@"component"][@"picUrl"]];
                        NSString *title = brands[@"component"][@"title"];
                        NSString *price = brands[@"component"][@"price"];
                        NSString *origin_price = brands[@"component"][@"origin_price"];
                        
                        NSDictionary *action = brands[@"component"][@"action"];
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//                        dic.main_image = ;
//                        dic.source_id = action[@"sourceId"];
                        [dic setObject:action[@"main_image"] forKey:@"main_image"];
                        [dic setObject:action[@"sourceId"] forKey:@"source_id"];
                    
                        iv.Xdata = dic;
                        
                       
                        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        
                        [iv sd_setImageWithURL:url forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                           [iv layoutIfNeeded];
                            [iv setTitle:title forState:UIControlStateNormal];
                            iv.oldPrice1 = origin_price;
                            iv.Price1 = price;

                        }];
                        iv.frame = CGRectMake(50*i, 0, 50, 300);
                        [cell.Scroll3 addSubview:iv];
                        [iv addTarget:self action:@selector(SHANGPING:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }
        }

        
        
        
        
        
        
        return cell;
    }
#pragma mark -设置下面的商品cell
    if (indexPath.section == 1) {
       
        LXYcollectionTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        NSDictionary *left =  self.items[indexPath.row*2];
        NSDictionary *right = self.items[indexPath.row*2+1];
        NSDictionary *leftCom = left[@"component"];
        NSDictionary *rightCom = right[@"component"];
        
         NSString *strr1 = leftCom[@"picUrl"];
            NSString *strr2 = rightCom[@"picUrl"];
        
        NSURL *lefturl = [NSURL URLWithString:[strr1 componentsSeparatedByString:@"?"][0]];
        
         NSURL *righturl = [NSURL URLWithString:[strr2 componentsSeparatedByString:@"?"][0]];
        
       
       
        
        NSString *leftname = leftCom[@"description"];
        NSString *leftprice = leftCom[@"price"];
        NSString *leftoldprice = leftCom[@"origin_price"];
        NSString *leftcountry = leftCom[@"country"];
        
        NSString *rightname = rightCom[@"description"];
        NSString *rightprice = rightCom[@"price"];
        NSString *rightoldprice = rightCom[@"origin_price"];
         NSString *rightcountry = rightCom[@"country"];
      
        cell2.leftView.name.text = leftname;
        cell2.leftView.Jiage.text = leftprice;
        cell2.leftView.oldJiage.text = leftoldprice;
        cell2.leftView.guojia.text = leftcountry;
        
        
        cell2.rightView.name.text = rightname;
        cell2.rightView.Jiage.text = rightprice;
        cell2.rightView.oldJiage.text = rightoldprice;
        cell2.rightView.guojia.text = rightcountry;
        [cell2.leftView.pic sd_setImageWithURL:lefturl placeholderImage:[UIImage imageNamed:@"button_more"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell2.leftView layoutIfNeeded];
         
          
        }];
     
        
        [cell2.rightView.pic sd_setImageWithURL:righturl placeholderImage:[UIImage imageNamed:@"button_more"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell2.rightView layoutIfNeeded];
           
        }];
        
        
        return cell2;
    }
    
   
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
    }
    return 400;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        header.backgroundColor = [UIColor whiteColor];
        UIView *gundongTiao = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width/4, 6)];
         gundongTiao.backgroundColor = [UIColor redColor];
        gundongTiao.tag = 1000000;
        [header addSubview:gundongTiao];
        
        //创建btn
        for (int i=0; i<4; i++) {
            UIButton *fenlei = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*(i), 0, [UIScreen mainScreen].bounds.size.width/4, 44)];
            NSDictionary * dic =self.fenLei.data.items[i];
            fenlei.tag = i;
            [fenlei setTitle:dic[@"nav_name"] forState:UIControlStateNormal];
            [fenlei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [fenlei setTitleColor:[UIColor colorWithRed:220/255.0 green:56/255.0 blue:122/255.0 alpha:1] forState:UIControlStateSelected];
            [fenlei addTarget:self action:@selector(moveGunDong:) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:fenlei];

    }
   
    return header;
        
        
    }
    return nil;
}


- (void)moveGunDong:(UIButton *)fenlei
{

    
    UIView *vi = [self.table viewWithTag:1000000];
    [UIView animateWithDuration:0.5 animations:^{
                vi.frame = CGRectMake(fenlei.frame.origin.x, 44-6, fenlei.frame.size.width, 6);
            }];
    
    
    
}

#pragma mark - 滚动的协议方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    if (scrollView.tag==12345) {
        [self.time setFireDate:[NSDate distantFuture]];
    }
    
    
}

//测试

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
 //
 //  targetContentOffset = CGPointMake(10, 0);
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


{
    if (scrollView.tag==12345) {
        [self.time setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.tag==12345) {
        UIPageControl *pg=[self.view viewWithTag:1234567890];
        
        pg.currentPage=(scrollView.contentOffset.x)/Screen_Width-1;
    }
    
}
- (void)play{
    
    for (LXYshouYeScrollTableViewCell *cell in self.table.visibleCells) {
       
        if ([cell isMemberOfClass:[LXYshouYeScrollTableViewCell class]]) {
           [cell.SCroll2 setContentOffset:CGPointMake(cell.SCroll2.contentOffset.x+Screen_Width, 0) animated:YES];
           
        }

    }
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    if (scrollView.tag==12345) {
        UIPageControl *pg=[self.view viewWithTag:1234567890];
        
        pg.currentPage=(scrollView.contentOffset.x)/Screen_Width-1;
    }
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    if (scrollView.tag==12345) {
        LXYShouYePic *scroll = (LXYShouYePic *)scrollView;
        float a=scrollView.contentOffset.x;
        if (a>=0&&a<Screen_Width) {
            scrollView.contentOffset=CGPointMake(a+Screen_Width*(scroll.ArrCount), 0);
        }
        if (a>=Screen_Width*(scroll.ArrCount+1)&&Screen_Width*(scroll.ArrCount+2)) {
            scrollView.contentOffset=CGPointMake(a-Screen_Width*(scroll.ArrCount), 0);
        }
    }
    
    
}


#pragma mark - 网络部分
- (void)downloadPingPaiShuJu
{
    self.Pingpai = [[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        LXYPingPai *pingpai = [LXYPingPai new];
        [self.Pingpai addObject:pingpai];
        
    }
    for (int i=1; i<7; i++) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *str = [NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=%d&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=",i];
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"下载进度%f",downloadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
            self.Pingpai[i-1] = [LXYPingPai yy_modelWithDictionary:responseObject];
          
          
            ;
            [self.table.mj_header endRefreshing];
        [self.table reloadData];
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }

}

- (void)downloadShangPingShuJu
{   NSString *flag = nil;
    if (self.shangping==nil) {
        
    }else
    {
        flag = self.shangping.data.flag;
    }
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *str = [NSString stringWithFormat:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=%@&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=",flag];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.shangping = [LXYShangPing yy_modelWithDictionary:responseObject];
       
         [self.items addObjectsFromArray:self.shangping.data.items];
   
       [self.table.mj_footer endRefreshing];
        [self.table reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)dnowloadFenLei
{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api-v2.mall.hichao.com/region/detail/goods-nav?region=0&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=F6094B15-6418-42A0-9FFD-4EB1F2139FEB&gs=640x1136&gos=10.0&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        self.fenLei = [LXYfenlei yy_modelWithDictionary:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 进入商品详情页
- (void)SHANGPING:(LXYScrollBtn *)btn
{
 
    UIStoryboard *lxystory=[UIStoryboard storyboardWithName:@"LXY" bundle:nil];

    LXYShangPingXiangQingViewController *xiangQiang = [lxystory instantiateViewControllerWithIdentifier:@"xiangqing"];
    xiangQiang.dic = btn.Xdata;
    [self.navigationController pushViewController:xiangQiang animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
