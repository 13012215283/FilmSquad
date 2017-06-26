//
//  CZ_DynamicCell.h
//  CZEnglish
//
//  Created by tarena_cz on 16/11/18.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZ_ContainerView.h"
#import "DynamicFrame.h"
#import "CZ_Control.h"

@class  CZ_DynamicCell;
@protocol CZ_DynamicCellDelegate <NSObject>

-(void)CZ_DynamicCell:(CZ_DynamicCell*)dynamicCell clickedRepost:(UIControl*)control;
-(void)CZ_DynamicCell:(CZ_DynamicCell*)dynamicCell clickedComment:(UIControl*)control;
-(void)CZ_DynamicCell:(CZ_DynamicCell*)dynamicCell clickedZan:(UIControl*)control;
-(void)CZ_DynamicCell:(CZ_DynamicCell*)dynamicCell clickedTopButton:(UIControl*)button;

@end

@interface CZ_DynamicCell : UITableViewCell
@property(nonatomic,strong) UIImageView *headImageView;         //头像
@property(nonatomic,strong) UILabel *nameLabel;                 //名字
@property(nonatomic,strong) UILabel *timeLabel;                 //时间
@property(nonatomic,strong) YYTextView *titleTextView;          //主题
@property(nonatomic,strong) CZ_ContainerView *containerView;    //内容视图
@property(nonatomic,strong) UIView *bottomBar;                  //底部Bar

@property(nonatomic,strong) CZ_Control *playControl;            //播放语音按钮

@property(nonatomic,strong) CZ_Control *repostControl;          //转发按钮

@property(nonatomic,strong) CZ_Control *commentControl;         //评论按钮

@property(nonatomic,strong) CZ_Control *zanControl;             //点赞按钮
@property(nonatomic,strong) UIButton *topButton;                //右上角按钮

@property(nonatomic,strong) UIView *topSeparateView;            //分割线
@property(nonatomic,strong) UIView *bottomSeparateView;         //分割线

//代理
@property(nonatomic,weak)   id<CZ_DynamicCellDelegate> cz_delegate;

//模型数据
@property(nonatomic,strong) DynamicFrame *dynamicFrame;



@end
