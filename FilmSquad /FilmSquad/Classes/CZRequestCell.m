//
//  CZRequestCell.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/13.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZRequestCell.h"

@implementation CZRequestCell
#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.headImageView                     = [[UIImageView alloc]init];
        self.headImageView.backgroundColor     = [UIColor whiteColor];
        self.headImageView.layer.cornerRadius  = (60 - 16)/2;
        self.headImageView.layer.borderWidth   = 1;
        self.headImageView.layer.borderColor   = [UIColor blackColor].CGColor;
        self.headImageView.layer.masksToBounds = YES;
        
        //名字
        self.nameLabel               = [[UILabel alloc]init];
        self.nameLabel.textColor     = [UIColor grayColor];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font          = YuanFont(16);
        
        //请求信息
        self.messageLabel               = [[UILabel alloc]init];
        self.messageLabel.textColor     = [UIColor lightGrayColor];
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.font          = YuanFont(14);
        
        //同意按钮
        self.acceptButton                 = [[UIButton alloc]init];
        self.acceptButton.backgroundColor = kBlueColor;
        self.acceptButton.titleLabel.font = YuanFont(14);
        [self.acceptButton setTitle:@"同意" forState:(UIControlStateNormal)];
        [self.acceptButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.acceptButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];

        //添加同意按钮触发方法
        [self.acceptButton addTarget:self action:@selector(accept:) forControlEvents:(UIControlEventTouchUpInside)];
        
        //拒绝按钮
        self.refuseButton                 = [[UIButton alloc]init];
        self.refuseButton.backgroundColor = [UIColor blackColor];
        self.refuseButton.titleLabel.font = YuanFont(14);
        
        [self.refuseButton setTitle:@"拒绝" forState:(UIControlStateNormal)];
        [self.refuseButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.refuseButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];

        //添加拒绝按钮触发方法
        [self.refuseButton addTarget:self action:@selector(refuse:) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.resultLabel               = [[UILabel alloc]init];
        self.resultLabel.textColor     = [UIColor lightGrayColor];
        self.resultLabel.font          = YuanFont(16);
        self.resultLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.acceptButton];
        [self.contentView addSubview:self.refuseButton];
        [self.contentView addSubview:self.resultLabel];
        
        //布局
        [self masonry];
    }
    return self;
}

#pragma mark - 控件方法
//同意好友申请触发方法
-(void)accept:(UIButton*)sender{
    [self.cz_delegate czRequestCell:self acceptRequestFromUser:self.requestUser];
}

//拒绝好友申请触发方法
-(void)refuse:(UIButton*)sender{
    [self.cz_delegate czRequestCell:self refuseRequestFromUser:self.requestUser];
}

#pragma mark - masonry
-(void)masonry{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.width.height.equalTo(self.contentView.mas_height).offset(-16);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(8);
        make.top.equalTo(self.headImageView);
        make.width.equalTo(self.contentView).multipliedBy(1.0/3);
        make.height.equalTo(self.headImageView).multipliedBy(0.5);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.width.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [self.refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView).multipliedBy(0.4);
        make.width.equalTo(self.nameLabel).multipliedBy(0.4);
    }];
    
    [self.acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.refuseButton.mas_left).offset(-16);
        make.width.height.top.bottom.equalTo(self.refuseButton);
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.acceptButton);
        make.right.equalTo(self.refuseButton);
    }];
    
    //设置圆角
    self.refuseButton.layer.cornerRadius  = 10;
    self.refuseButton.layer.masksToBounds = YES;
    
    self.acceptButton.layer.cornerRadius  = 10;
    self.acceptButton.layer.masksToBounds = YES;
    
}


@end
