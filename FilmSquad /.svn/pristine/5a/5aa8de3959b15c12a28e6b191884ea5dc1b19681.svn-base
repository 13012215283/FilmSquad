//
//  CZIntroduceCellTableViewCell.m
//  FilmSquad
//
//  Created by zol on 2017/3/16.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZIntroduceCellTableViewCell.h"

@implementation CZIntroduceCellTableViewCell


#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.deskLabel               = [[UILabel alloc]init];
        self.deskLabel.font          = YuanFont(14);
        self.deskLabel.numberOfLines = 0;
        
        self.spreadButton = [[UIButton alloc]init];
        [self.spreadButton setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateNormal)];
        [self.spreadButton setImage:[UIImage imageNamed:@"up"] forState:(UIControlStateSelected)];
        self.spreadButton.userInteractionEnabled = NO;   //关闭交互
        
        [self.contentView addSubview:self.deskLabel];
        [self.contentView addSubview:self.spreadButton];
        
        [self masonry];

    }
    return self;
}

#pragma mark - 布局
#define Interval 8
-(void)masonry{
    [self.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(Interval);
        make.right.equalTo(self.contentView).offset(-Interval);
        make.bottom.equalTo(self.contentView).offset(-2*Interval);
    }];
    [self.spreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.height.mas_equalTo(2*Interval);
    }];
}

#pragma mark - 根据Label内容获取高度
-(CGFloat)getNewHeight{
    NSString *text = self.deskLabel.text;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:self.deskLabel.font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(self.deskLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height+ 4*Interval;
    
}

@end
