//
//  CZFriendsCell.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/17.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZFriendsCell.h"

@implementation CZFriendsCell
#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.headerImageView = [[UIImageView alloc]init];
        self.nameLabel       = [[UILabel alloc]init];
        
        self.headerImageView.layer.cornerRadius  = (60 - 16 )/2;
        self.headerImageView.layer.masksToBounds = YES;
        
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font      = YuanFont(16);
        
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self masonry];
    }
    return self;
}

#pragma mark - 布局 
-(void)masonry{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(8);
        make.height.width.equalTo(self.contentView.mas_height).offset(-16);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(8);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.headerImageView).offset(-16);
        make.width.equalTo(self.contentView).multipliedBy(1.0/3);
    }];
}

#pragma mark - 设置内容
-(void)setUserInfo:(CZUserInfo *)userInfo{
    _userInfo = userInfo;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headURL] placeholderImage:[UIImage imageNamed:@"user"]];
    self.nameLabel.text = [userInfo.remarkName isEqualToString:@""]?userInfo.name:[NSString stringWithFormat:@"%@(%@)",userInfo.name,userInfo.remarkName];
}

@end
