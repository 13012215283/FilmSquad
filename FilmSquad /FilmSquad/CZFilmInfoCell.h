//
//  CZFilmInfoCell.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/22.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZFilmsInfoModel.h"
#import "CZ_Control.h"
@interface CZFilmInfoCell : UITableViewCell
@property (nonatomic,strong) UIImageView  *posterImageView;     //宣传海报
@property (nonatomic,strong) UIScrollView *scrollView;          //滚动视图
@property (nonatomic,strong) UILabel      *scoreLabel;          //评分
@property (nonatomic,strong) UILabel      *filmNameLabel;       //电影名
@property (nonatomic,strong) UILabel      *commentCountLabel;   //评论人数
@property (nonatomic,strong) UIButton     *collectionButton;    //收藏按钮
@property (nonatomic,strong) CZFilmsInfoModel *filmInfo;
@property (nonatomic,assign) CGFloat      location;
@property (nonatomic,strong) NSIndexPath  *indexPath;
@end
