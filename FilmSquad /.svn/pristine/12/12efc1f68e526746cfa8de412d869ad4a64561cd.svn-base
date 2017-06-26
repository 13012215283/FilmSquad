//
//  CollectionViewCell.m
//  FilmSquad
//
//  Created by zol on 2017/3/16.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CollectionViewCell.h"
#define Interval 8
@implementation CollectionViewCell
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.actorImageView = [[UIImageView alloc]init];
        self.nameLabel      = [[UILabel alloc]init];
        self.jobLabel       = [[UILabel alloc]init];
        
        self.actorImageView.layer.cornerRadius  = (frame.size.width - 2*Interval)/2;
        self.actorImageView.layer.masksToBounds = YES;
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font          = YuanFont(16);
        
        self.jobLabel.textAlignment  = NSTextAlignmentCenter;
        self.jobLabel.font           = YuanFont(12);
        self.jobLabel.textColor      = [UIColor lightGrayColor];
        
        
        [self.contentView addSubview:self.actorImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.jobLabel];
        [self masonry];
    }
    return self;
}

#pragma mark - 布局

-(void)masonry{
    [self.actorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(Interval);
        make.right.equalTo(self.contentView).offset(-Interval);
        make.height.equalTo(self.contentView.mas_width).offset(-Interval*2);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.actorImageView.mas_bottom).offset(Interval);
        make.bottom.equalTo(self.nameLabel.mas_top);
    }];
    [self.jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - set方法
-(void)setActor:(CZFimlActorsInfoModel *)actor{
    _actor = actor;
    [self.actorImageView sd_setImageWithURL:actor.profile_image_url placeholderImage:[UIImage imageNamed:@"ph"]];
    self.nameLabel.text = actor.name;
    self.jobLabel.text  = actor.job;
}
@end
