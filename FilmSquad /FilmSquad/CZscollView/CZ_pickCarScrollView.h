//
//  CZ_pickCarScrollView.h
//  狼人小分队
//
//  Created by 陈卓 on 16/10/1.
//  Copyright © 2016年 陈卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZ_pickCarScrollView;
@protocol CZ_pickCarScrollViewDelegate <NSObject>

-(void)CZ_pickCarScrollView:(CZ_pickCarScrollView*)pickCarScrollView hideCountLabelAndButtons:(BOOL)hidden; //隐藏计数板代理方法

@end

@interface CZ_pickCarScrollView : UIScrollView

@property(nonatomic,strong) NSMutableArray *allImages;
@property(nonatomic,weak) id<CZ_pickCarScrollViewDelegate> cz_delegate;

-(id)initWithFrame:(CGRect)frame andImages:(NSArray*)images;    //初始化方法


-(void)changeMidImagesFromIndex:(NSInteger)index;              //改变中间的图片并变换其他图片；
-(NSInteger)getIndexFromMidImage;                                  //得到当前选择中间图片的位置
-(void)setDefaultImageForAllSubView;   //设置默认图片
-(void)setUpScrollView;
@end
