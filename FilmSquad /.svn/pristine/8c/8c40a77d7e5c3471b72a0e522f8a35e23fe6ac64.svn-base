//
//  CZFilmInfoCell.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/22.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZFilmInfoCell.h"

@implementation CZFilmInfoCell
#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.posterImageView   = [[UIImageView alloc]init];
        self.filmNameLabel     = [[UILabel alloc]init];
        self.scoreLabel        = [[UILabel alloc]init];
        self.commentCountLabel = [[UILabel alloc]init];
        self.collectionButton  = [[UIButton alloc]init];
        
        self.scoreLabel.font   = [UIFont systemFontOfSize:25 weight:0.3];
        self.scoreLabel.textColor = [UIColor yellowColor];
        
        self.filmNameLabel.font = [UIFont systemFontOfSize:15 weight:0.1];
        self.filmNameLabel.textColor = [UIColor whiteColor];
        
        self.commentCountLabel.font = [UIFont systemFontOfSize:12 weight:0.1];;
        self.commentCountLabel.textColor = [UIColor whiteColor];
        self.commentCountLabel.alpha = 0.6;
        
        [self.collectionButton setImage:[UIImage imageNamed:@"collection_nomal"] forState:(UIControlStateNormal)];
        [self.collectionButton setImage:[UIImage imageNamed:@"collection_hight"] forState:(UIControlStateSelected)];
        
        UIView *blackView         = [[UIView alloc]init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha           = 0.4;
        [self.contentView addSubview:self.scrollView];
        [self.contentView addSubview:blackView];
        [self.contentView addSubview:self.filmNameLabel];
        [self.contentView addSubview:self.scoreLabel];
        [self.contentView addSubview:self.commentCountLabel];
        [self.contentView addSubview:self.collectionButton];
        
        
        [self masonry];
        
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        
    }
    return self;
}
#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT/4)];
        _scrollView.userInteractionEnabled         = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [_scrollView setContentSize:CGSizeMake(kWIDTH*1.4, kHEIGHT/4*1.4)];
        
        self.posterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kWIDTH*1.4, kHEIGHT/4*1.4)];
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        UIVisualEffectView *ve = [[UIVisualEffectView alloc]initWithEffect:effect];
        ve.frame = self.posterImageView.bounds;
        ve.alpha = 0.5;
        [self.posterImageView addSubview:ve];
        
        [_scrollView addSubview:self.posterImageView];
    }
    return _scrollView;
}
#pragma mark - set方法
-(void)setFilmInfo:(CZFilmsInfoModel *)filmInfo{
    _filmInfo = filmInfo;
    [self.posterImageView sd_setImageWithURL:filmInfo.poster_url placeholderImage:[UIImage imageNamed:@""]];
    
    self.scoreLabel.text        = filmInfo.score;
    self.filmNameLabel.text     = filmInfo.name;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@人评论",filmInfo.score_count];
}

#define HeightForCell kHEIGHT/4
#define FirstLocation self.indexPath.row * HeightForCell-HeightForCell
#define FinalLocation self.indexPath.row * HeightForCell + 4*HeightForCell
#define Interval (kHEIGHT/4*0.3)/(5*HeightForCell)
-(void)setLocation:(CGFloat)location{
    _location = location;
    if(self.indexPath.row == 0){
        if(location >= (self.indexPath.row * HeightForCell-HeightForCell) && location <= (self.indexPath.row * HeightForCell + 4*HeightForCell)  ){
            CGFloat y = kHEIGHT/4*0.3 - (location+HeightForCell - FirstLocation+HeightForCell)*(Interval);
            [self.scrollView setContentOffset:CGPointMake(kWIDTH*0.2, y)];
        }
    }else if(location >= (self.indexPath.row * HeightForCell-4*HeightForCell) && location <= (self.indexPath.row * HeightForCell + HeightForCell)  ){
    
        CGFloat y = kHEIGHT/4*0.2 - (location - FirstLocation)*(Interval);
        [self.scrollView setContentOffset:CGPointMake(kWIDTH*0.2, y)];
    }
}

#pragma mark - masonry
-(void)masonry{
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.height.width.equalTo(self.contentView.mas_height).multipliedBy(1.0/3);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.filmNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreLabel);
        make.left.equalTo(self.scoreLabel.mas_right);
        make.height.equalTo(self.scoreLabel).multipliedBy(0.5);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filmNameLabel.mas_bottom);
        make.left.equalTo(self.filmNameLabel);
        make.width.height.equalTo(self.filmNameLabel);
    }];
    
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scoreLabel);
        make.right.equalTo(self.contentView).offset(-8);
        make.width.height.equalTo(self.contentView.mas_height).multipliedBy(1.0/6);
    }];
    
}

@end
