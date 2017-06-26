//
//  CZ_pickCarScrollView.m
//  狼人小分队
//
//  Created by 陈卓 on 16/10/1.
//  Copyright © 2016年 陈卓. All rights reserved.
//

#import "CZ_pickCarScrollView.h"
#import "CZ_ImageViewForScrollView.h"

#define TIME_INTERVAL 0.1
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface CZ_pickCarScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray<CZ_ImageViewForScrollView*> *allSubViews;
@property(nonatomic,assign) CGFloat widthForSubView;
@property(nonatomic,assign) CGFloat widthForSelect;
@property(nonatomic,assign) CGFloat interval;
@property(nonatomic,assign) CGFloat lastLocation;
@end
@implementation CZ_pickCarScrollView
#pragma mark - 初始化方法
-(id)initWithFrame:(CGRect)frame andImages:(NSArray *)images{
    if(self = [super initWithFrame:frame]){
        if(images.count >=5){
            self.allImages = [images mutableCopy];
                    }
        else{
            self.allImages = [[NSMutableArray alloc]init];
            for(NSInteger i = 0; i<5; i++){
                NSURL *url = [NSURL URLWithString:@(i).stringValue];
                [self.allImages addObject:url];
            }
        }
        [self setUpScrollView];

    }
    return self;
}
#pragma mark - 惰性加载
-(NSMutableArray<CZ_ImageViewForScrollView *> *)allSubViews{
    if(!_allSubViews){
        _allSubViews = [NSMutableArray arrayWithCapacity:5];
        for(NSInteger i=0; i<5; i++){
            CZ_ImageViewForScrollView *subView = [[CZ_ImageViewForScrollView alloc]init];
            subView.layer.borderColor          =  kWhiteColor.CGColor;
            subView.layer.borderWidth          = 1.5;
            [self addSubview:subView];
            [_allSubViews addObject:subView];
        }
    }
    return _allSubViews;
}
-(NSMutableArray<UIImage *> *)allImages{
    if(!_allImages){
        _allImages = [[NSMutableArray alloc]init];
    }
    return _allImages;
}
-(CGFloat)widthForSubView{
    if(!_widthForSubView){
        _widthForSubView = [UIScreen mainScreen].bounds.size.width * 0.40625;
    }
    return _widthForSubView;
}
-(CGFloat)widthForSelect{
    if(!_widthForSelect){
        _widthForSelect = [UIScreen mainScreen].bounds.size.width * 0.46875;
    }
    return _widthForSelect;
}
-(CGFloat)interval{
    if(!_interval){
        _interval = self.widthForSubView*2.5 - [UIScreen mainScreen].bounds.size.width*0.5 -self.widthForSubView;
    }
    return _interval;
}

#pragma mark - ScrollView内容布局
-(void)arrangementForScollView{
    for(NSInteger i = 0 ; i < self.allSubViews.count ; i++){
        self.allSubViews[i].frame = CGRectMake(self.widthForSubView*i, self.widthForSubView/13.0,self.widthForSubView, self.widthForSubView);
    }
}


#pragma mark - 设置ScrollViewn内容
-(void)setUpScrollView{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(self.widthForSubView*5,0);
    [self setContentOffset:CGPointMake((self.widthForSubView *5-[UIScreen mainScreen].bounds.size.width)/2.0, 0)];
    [self arrangementForScollView];
    [self setContentsForAllSubViews];
    self.subviews[2].transform = CGAffineTransformMakeScale(self.widthForSelect/self.widthForSubView, self.widthForSelect/self.widthForSubView);
    [self refreshSizeWithSubView:nil];  //给第3个ImageView初始位置和大小
    [self bringSubviewToFront:self.subviews[2]];
    self.delegate = self;
    
}


//设置Scrollview子视图内容
-(void)setContentsForAllSubViews{
    for(CZ_ImageViewForScrollView *view in self.allSubViews){
        view.layer.shadowOpacity = 0.3;
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(view.frame.size.width/13.0, view.frame.size.width/13.0);
    }
    [self setDefaultImageForAllSubView];
}

//设置ScrollView子第一次默认显示图片
-(void)setDefaultImageForAllSubView{
    [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count -2] placeholderImage:[UIImage imageNamed:@"ph"]];
    self.allSubViews[0].imageUrl = self.allImages[self.allImages.count -2];
    
    [self.allSubViews[1] sd_setImageWithURL:[self.allImages lastObject] placeholderImage:[UIImage imageNamed:@"ph"]];
    self.allSubViews[1].imageUrl = [self.allImages lastObject];
    
    [self.allSubViews[2] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"]];
    self.allSubViews[2].imageUrl = [self.allImages firstObject];
    
    [self.allSubViews[3] sd_setImageWithURL:self.allImages[1] placeholderImage:[UIImage imageNamed:@"ph"]];
    self.allSubViews[3].imageUrl = self.allImages[1];
    
    [self.allSubViews[4] sd_setImageWithURL:self.allImages[2] placeholderImage:[UIImage imageNamed:@"ph"]];
    self.allSubViews[4].imageUrl = self.allImages[2];
    
}



//更换image
-(void)changeImages{
    NSInteger index = [self.allImages indexOfObject:self.allSubViews[2].imageUrl];
    switch (index) {
        case 0:
            [self.allSubViews[1] sd_setImageWithURL:[self.allImages lastObject] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[1].imageUrl = [self.allImages lastObject];
            
            
            [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count - 2] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[0].imageUrl = self.allImages[self.allImages.count - 2];
            
            [self.allSubViews[3] sd_setImageWithURL:self.allImages[index + 1] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[3].imageUrl = self.allImages[index + 1];
            
            [self.allSubViews[4] sd_setImageWithURL:self.allImages[index + 2] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[4].imageUrl = self.allImages[index + 2];
            break;
        case 1:
            [self.allSubViews[1] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[1].imageUrl = [self.allImages firstObject];
            
            [self.allSubViews[0] sd_setImageWithURL:[self.allImages lastObject] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[0].imageUrl = [self.allImages lastObject];
            
            [self.allSubViews[3] sd_setImageWithURL:self.allImages[index + 1] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[3].imageUrl = self.allImages[index + 1];
            
            [self.allSubViews[4] sd_setImageWithURL:self.allImages[index + 2] placeholderImage:[UIImage imageNamed:@"ph"]];
             self.allSubViews[4].imageUrl = self.allImages[index + 2];
            break;
        default:
            if(index == self.allImages.count - 1){
                [self.allSubViews[1] sd_setImageWithURL:self.allImages[self.allImages.count - 2] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[1].imageUrl = self.allImages[self.allImages.count - 2];
                
                [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count - 3] placeholderImage:[UIImage imageNamed:@"ph"]];
                 self.allSubViews[0].imageUrl = self.allImages[self.allImages.count - 3];
                
                [self.allSubViews[3] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[3].imageUrl = [self.allImages firstObject];
                
                [self.allSubViews[4] sd_setImageWithURL:self.allImages[1] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[4].imageUrl = self.allImages[1];
            }
            else if(index == self.allImages.count -2){
                [self.allSubViews[1] sd_setImageWithURL:self.allImages[self.allImages.count - 3] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[1].imageUrl = self.allImages[self.allImages.count - 3];

                [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count - 4] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[0].imageUrl = self.allImages[self.allImages.count - 4];
                
                [self.allSubViews[3] sd_setImageWithURL:self.allImages[index + 1] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[3].imageUrl = self.allImages[index + 1];
                
                [self.allSubViews[4] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[4].imageUrl = [self.allImages firstObject];

            }
            else{
                [self.allSubViews[1] sd_setImageWithURL:self.allImages[index - 1] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[1].imageUrl = self.allImages[index - 1];
                
                [self.allSubViews[0] sd_setImageWithURL:self.allImages[index - 2] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[0].imageUrl = self.allImages[index - 2];
                
                [self.allSubViews[3] sd_setImageWithURL:self.allImages[index + 1] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[3].imageUrl = self.allImages[index + 1];
                
                [self.allSubViews[4] sd_setImageWithURL:self.allImages[index + 2] placeholderImage:[UIImage imageNamed:@"ph"]];
                self.allSubViews[4].imageUrl = self.allImages[index + 2];
                
            }
            break;
    }
}

//图片居中
-(void)returnCenterWithScrollView{
    CGFloat interval = [UIScreen mainScreen].bounds.size.width*0.5;
    if(self.contentOffset.x + interval < self.widthForSubView*2 &&self.contentOffset.x + interval >= self.widthForSubView){
        [self setContentOffset:CGPointMake(self.widthForSubView+self.widthForSubView/2-interval, self.contentOffset.y) animated:YES];
        
        
    }
    if(self.contentOffset.x + interval >= self.widthForSubView*2 && self.contentOffset.x + interval<= self.widthForSubView*3){
        [self setContentOffset:CGPointMake(2*self.widthForSubView+self.widthForSubView/2-interval, self.contentOffset.y) animated:YES];
        
    }
    if(self.contentOffset.x + interval > self.widthForSubView *3  &&self.contentOffset.x <= self.widthForSubView*4){
        
        [self setContentOffset:CGPointMake(3*self.widthForSubView+self.widthForSubView/2-interval, self.contentOffset.y) animated:YES];
    }
    
}
//滚动回弹时刷新控件大小和位置
-(void)refreshSizeWithSubView:(UIImageView*)subView{
    CGFloat ratio = self.widthForSelect/(self.widthForSubView*1.0)-1; //放大的比例差
    CGFloat yForImageView = self.widthForSubView/13.0;                //ImageView的y坐标以及下滑距离
    CGRect  frame;

    subView.transform = CGAffineTransformMakeScale(1, 1);  //回弹时恢复大小
    frame = subView.frame;                                 //回弹时恢复位置
    frame.origin.y = yForImageView;
    subView.frame = frame;

    self.allSubViews[2].transform = CGAffineTransformMakeScale(1+ratio, 1+ratio);  //回弹时恢复大小
    frame = self.allSubViews[2].frame;                                 //回弹时恢复位置
    frame.origin.y = 2*yForImageView;
    self.allSubViews[2].frame = frame;
}
#pragma mark - 代理方法，滚动逻辑

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastLocation = scrollView.contentOffset.x;
}
//scrollView滚动时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"Location:%.2f....",scrollView.contentOffset.x);
    [self.cz_delegate CZ_pickCarScrollView:self hideCountLabelAndButtons:YES];//滚动隐藏计数板
    
    CGFloat halfOfContentsize = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat ratio = self.widthForSelect/(self.widthForSubView*1.0)-1; //放大的比例差
    CGFloat yForImageView = self.widthForSubView/13.0;                //ImageView的y坐标以及下滑距离
    CGRect  frame;
    if((int)scrollView.contentOffset.x < (int)self.interval){  //转换成整形处理误差

        [self.allSubViews[2] setImage:self.allSubViews[1].image];
        self.allSubViews[2].imageUrl = self.allSubViews[1].imageUrl;
        [self changeImages];
        [self setContentOffset:CGPointMake((self.widthForSubView *5-[UIScreen mainScreen].bounds.size.width)/2.0, 0)];
        [self refreshSizeWithSubView:self.allSubViews[1]];

    }
    if((int)scrollView.contentOffset.x > self.widthForSubView*5 - (int)self.interval - halfOfContentsize*2){
        [self.allSubViews[2] setImage:self.allSubViews[3].image];
        self.allSubViews[2].imageUrl = self.allSubViews[3].imageUrl;
        [self changeImages];
        [self setContentOffset:CGPointMake((self.widthForSubView *5-[UIScreen mainScreen].bounds.size.width)/2.0, 0)];
        [self refreshSizeWithSubView:self.allSubViews[3]];


    }
    //设置第2,3个ImageView的缩放
    if(scrollView.contentOffset.x + WIDTH*0.5 >= self.widthForSubView*1.5 && scrollView.contentOffset.x + WIDTH*0.5 < self.widthForSubView*2.5){
        //处理第2个ImageView
        CGFloat zoom = 1+ratio - ratio*((scrollView.contentOffset.x-(1.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[1].transform = CGAffineTransformMakeScale(zoom, zoom);
        frame = self.allSubViews[1].frame;
        frame.origin.y = yForImageView + yForImageView - yForImageView*((scrollView.contentOffset.x-(1.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[1].frame = frame;
        //处理第3个ImageView
        zoom = 1+ratio*((scrollView.contentOffset.x-(1.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[2].transform = CGAffineTransformMakeScale(zoom, zoom);
        frame = self.allSubViews[2].frame;
        frame.origin.y = yForImageView + yForImageView*((scrollView.contentOffset.x-(1.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[2].frame = frame;

        //处理图层
        if(scrollView.contentOffset.x-self.lastLocation>0){
            [self bringSubviewToFront:self.allSubViews[2]];
        }else
             [self bringSubviewToFront:self.allSubViews[1]];
    }
    
     //设置3,4个ImageView的缩放
    if(scrollView.contentOffset.x + WIDTH*0.5 > self.widthForSubView*2.5 && scrollView.contentOffset.x + WIDTH*0.5 <= self.widthForSubView*3.5){
        //处理第4个ImageView
        CGFloat zoom = 1 + ratio*((scrollView.contentOffset.x-(2.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[3].transform = CGAffineTransformMakeScale(zoom, zoom);
        frame = self.allSubViews[3].frame;
        frame.origin.y = yForImageView + yForImageView*((scrollView.contentOffset.x-(2.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[3].frame = frame;
         //处理第3个ImageView
        zoom = 1+ratio - ratio*((scrollView.contentOffset.x-(2.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[2].transform = CGAffineTransformMakeScale(zoom, zoom);
        frame = self.allSubViews[2].frame;
        frame.origin.y = yForImageView + yForImageView - yForImageView*((scrollView.contentOffset.x-(2.5*self.widthForSubView-0.5*WIDTH))/(self.widthForSubView*1.0));
        self.allSubViews[2].frame = frame;
         //处理图层
        if(scrollView.contentOffset.x-self.lastLocation>0){
            [self bringSubviewToFront:self.allSubViews[3]];
        }else
            [self bringSubviewToFront:self.allSubViews[2]];
    }
    

    self.lastLocation = scrollView.contentOffset.x;
}

//scrollView将完成拖动时，带拖动速度
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(velocity.x == 0){
        [self returnCenterWithScrollView];
    }
}
//scrollView减速完成停下时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self returnCenterWithScrollView];
}

//滚动动画完成时
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    if([self getIndexForSelectedImageView] == -1 ){   //错误位置判断
        [self returnCenterWithScrollView];
        return ;
    }
    NSInteger index = [self getIndexForSelectedImageView];
    [self bringSubviewToFront:self.allSubViews[index]];
    [self.cz_delegate CZ_pickCarScrollView:self hideCountLabelAndButtons:NO]; //显示计数板
}

#pragma mark - 返回当前选择的ImageView下标
-(NSInteger)getIndexForSelectedImageView{
    NSInteger x = (NSInteger)(self.contentOffset.x) + (NSInteger)([UIScreen mainScreen].bounds.size.width*0.5);
    NSInteger index = -1;
    if(x>self.widthForSubView*1.5-3 && x<self.widthForSubView*1.5+3){
        index =  1;
    }
    else if(x>self.widthForSubView*2.5-3 && x<self.widthForSubView*2.5+3){
        index =  2;
    }
    else if(x>self.widthForSubView*3.5-3 && x<self.widthForSubView*3.5+3){
        index =  3;
    }
    else index = -1;
    return index;

}
#pragma mark - 返回当前选择的图片下标
-(NSInteger)getIndexFromMidImage{
    NSInteger indexForImageView = [self getIndexForSelectedImageView];
    if(indexForImageView == -1 ){
        return -1;
    }
    return [self.allImages indexOfObject:self.allSubViews[indexForImageView].image];
}

#pragma mark - 改变中间图片，自动设置其他图片
-(void)changeMidImagesFromIndex:(NSInteger)index{
    NSInteger indexForSelected = [self getIndexForSelectedImageView];
    
    if(indexForSelected == -1 || index == [self.allImages indexOfObject:self.allSubViews[indexForSelected].imageUrl]) return;//异常或重复返回
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = @"oglFlip";
    
    for(UIImageView *imageView in self.allSubViews){
        [imageView.layer addAnimation:transition forKey:nil];
    }
    
    if(indexForSelected == 1){
        [self.allSubViews[2] sd_setImageWithURL:self.allImages[index] placeholderImage:[UIImage imageNamed:@"ph"]];
        self.allSubViews[2].imageUrl = self.allImages[index];
    }
    switch (indexForSelected) {
        case 1:
            [self.allSubViews[2] sd_setImageWithURL:self.allImages[index+1==self.allImages.count?0:index+1] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[2].imageUrl = self.allImages[index+1==self.allImages.count?0:index+1];
            break;
        case 2:
            [self.allSubViews[2] sd_setImageWithURL:self.allImages[index] placeholderImage:[UIImage imageNamed:@"ph"]];
             self.allSubViews[2].imageUrl = self.allImages[index];
            break;
        case 3:
            [self.allSubViews[2] sd_setImageWithURL:self.allImages[index-1==-1?self.allImages.count-1:index-1] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[2].imageUrl = self.allImages[index-1==-1?self.allImages.count-1:index-1];
            break;
        default:
            break;
    }
//    NSLog(@"%ld",[self.allImages indexOfObject:self.allSubViews[2].image]);
    NSInteger midIndex = [self.allImages indexOfObject:self.allSubViews[2].imageUrl];
    switch (midIndex) {
        case 0:
            [self.allSubViews[1] sd_setImageWithURL:[self.allImages lastObject] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[1].imageUrl = [self.allImages lastObject];
            
            [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count - 2] placeholderImage:[UIImage imageNamed:@"ph"] ];
            self.allSubViews[0].imageUrl = self.allImages[self.allImages.count - 2];
            
            [self.allSubViews[3] sd_setImageWithURL:self.allImages[midIndex + 1] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[3].imageUrl = self.allImages[midIndex + 1];
            
            [self.allSubViews[4] sd_setImageWithURL:self.allImages[midIndex + 2] placeholderImage:[UIImage imageNamed:@"ph"]];
            self.allSubViews[4].imageUrl = self.allImages[midIndex + 2];
            break;
        case 1:
            [self.allSubViews[1] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"]];
             self.allSubViews[1].imageUrl = [self.allImages firstObject];
            
            [self.allSubViews[0] sd_setImageWithURL: [self.allImages lastObject] placeholderImage:[UIImage imageNamed:@"ph"]];
             self.allSubViews[0].imageUrl = [self.allImages lastObject];
            
            [self.allSubViews[3] sd_setImageWithURL:self.allImages[midIndex + 1] placeholderImage:[UIImage imageNamed:@"ph"]];
             self.allSubViews[3].imageUrl = self.allImages[midIndex + 1];
            
            [self.allSubViews[4] sd_setImageWithURL:self.allImages[midIndex + 2] placeholderImage:[UIImage imageNamed:@"ph"] ];
             self.allSubViews[4].imageUrl = self.allImages[midIndex + 2];
            break;
        default:
            if(midIndex == self.allImages.count - 1){
                [self.allSubViews[1] sd_setImageWithURL:self.allImages[self.allImages.count - 2] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[1].imageUrl = self.allImages[self.allImages.count - 2];
                
                [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count - 3] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[0].imageUrl = self.allImages[self.allImages.count - 3];
                
                [self.allSubViews[3] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[3].imageUrl = [self.allImages firstObject];
                
                [self.allSubViews[4] sd_setImageWithURL:self.allImages[1] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[4].imageUrl = self.allImages[1];
            }
            else if(midIndex == self.allImages.count -2){
                [self.allSubViews[1] sd_setImageWithURL:self.allImages[self.allImages.count - 3] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[1].imageUrl = self.allImages[self.allImages.count - 3];
                
                [self.allSubViews[0] sd_setImageWithURL:self.allImages[self.allImages.count - 4] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[0].imageUrl = self.allImages[self.allImages.count - 4];
                
                [self.allSubViews[3] sd_setImageWithURL:self.allImages[midIndex + 1] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[3].imageUrl = self.allImages[midIndex + 1];
                
                [self.allSubViews[4] sd_setImageWithURL:[self.allImages firstObject] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[4].imageUrl = [self.allImages firstObject];
            }
            else{
                [self.allSubViews[1] sd_setImageWithURL:self.allImages[midIndex - 1] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[1].imageUrl = self.allImages[midIndex - 1];
                
                [self.allSubViews[0] sd_setImageWithURL:self.allImages[midIndex - 2] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[0].imageUrl = self.allImages[midIndex - 2];
                
                [self.allSubViews[3] sd_setImageWithURL:self.allImages[midIndex + 1] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[3].imageUrl = self.allImages[midIndex + 1];
                
                [self.allSubViews[4] sd_setImageWithURL:self.allImages[midIndex + 2] placeholderImage:[UIImage imageNamed:@"ph"] ];
                self.allSubViews[4].imageUrl = self.allImages[midIndex + 2];
            }
            break;
    }
}

#pragma mark - touch方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event]; 
    
}
@end



















