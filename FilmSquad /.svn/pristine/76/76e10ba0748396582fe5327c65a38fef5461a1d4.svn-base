//
//  CZSectionHeaderView.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/17.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZSectionHeaderView;

@protocol CZSectionHeaderViewDelegate <NSObject>

-(void)showSquadContenFromCZSectionHeaderViewt:(CZSectionHeaderView*)headerView;
-(void)closeSquadContenFromCZSectionHeaderViewt:(CZSectionHeaderView*)headerView;

@end

@interface CZSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong) UILabel          *squadLabel;              //分组标签
@property (nonatomic,strong) UILabel          *friendsCountLabel;       //好友数标签
@property (nonatomic,strong) UIButton         *spreadButton;            //展开按钮
@property (nonatomic,strong) UIButton         *selectSquadHeaderButton; //点击分组按钮

@property (nonatomic,strong) UIView           *seperateView;            //分割线
@property (nonatomic,strong) UIView           *footerSeperateView;            //分割线

@property (nonatomic,weak  ) id<CZSectionHeaderViewDelegate> cz_delegate; //设置代理
@end
