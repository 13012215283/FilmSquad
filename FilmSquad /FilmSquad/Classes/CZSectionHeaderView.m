//
//  CZSectionHeaderView.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/17.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZSectionHeaderView.h"

@implementation CZSectionHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        self.squadLabel               = [[UILabel alloc]init];
        self.squadLabel.font          = YuanFont(16);
        self.squadLabel.textColor     = [UIColor blackColor];
        self.squadLabel.textAlignment = NSTextAlignmentLeft;
        
        self.friendsCountLabel               = [[UILabel alloc]init];
        self.friendsCountLabel.font          = YuanFont(13);
        self.friendsCountLabel.textColor     = [UIColor lightGrayColor];
        self.friendsCountLabel.textAlignment = NSTextAlignmentRight;
        
        self.spreadButton = [[UIButton alloc]init];
        [self.spreadButton setImage:[UIImage imageNamed:@"spread"] forState:(UIControlStateNormal)];
        [self.spreadButton setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateSelected)];
        
        self.selectSquadHeaderButton = [[UIButton alloc]init];
        [self.selectSquadHeaderButton addTarget:self action:@selector(spreadSquads:) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.seperateView = [[UIView alloc]init];
        self.seperateView.backgroundColor = kWhiteColor;
        
        self.footerSeperateView = [[UIView alloc]init];
        self.footerSeperateView.backgroundColor = kWhiteColor;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //添加子视图
        [self.contentView addSubview:self.squadLabel];
        [self.contentView addSubview:self.friendsCountLabel];
        [self.contentView addSubview:self.spreadButton];
        [self.contentView addSubview:self.selectSquadHeaderButton];
        [self.contentView addSubview:self.seperateView];
        [self.contentView addSubview:self.footerSeperateView];
        
        //布局
        [self masonry];
        
    }
    return self;
}
#pragma mark - 布局
-(void)masonry{
    
    [self.spreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(8);
        make.width.height.equalTo(self.contentView.mas_height).offset(-16);
    }];
    
    [self.friendsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.height.top.bottom.equalTo(self.spreadButton);
        make.width.equalTo(self.spreadButton).multipliedBy(2);
    }];
    
    [self.squadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.spreadButton);
        make.left.equalTo(self.spreadButton.mas_right).offset(8);
        make.right.equalTo(self.friendsCountLabel.mas_left);
    }];
    
    [self.selectSquadHeaderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.footerSeperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
}

#pragma mark - 控件方法
//按下暂开分组按钮
-(void)spreadSquads:(UIButton*)sender{
    if(self.spreadButton.selected == NO) {
        self.spreadButton.selected     = YES;
        self.footerSeperateView.hidden = YES;
        [self.cz_delegate showSquadContenFromCZSectionHeaderViewt:self];
    }
    else{
        self.spreadButton.selected     = NO;
        self.footerSeperateView.hidden = NO;
        [self.cz_delegate closeSquadContenFromCZSectionHeaderViewt:self];
    }
    
}

@end
