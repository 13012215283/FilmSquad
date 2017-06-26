//
//  CZRequesInfoCell.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/23.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZRequesInfoCell.h"

@implementation CZRequesInfoCell


#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.titleLabel               = [[UILabel alloc]init];
        self.titleLabel.font          = YuanFont(16);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor     = [UIColor grayColor];
        [self.contentView addSubview: self.titleLabel];
        
        self.infoTextView                                = [[YYTextView alloc]init];
        self.infoTextView.font                           = YuanFont(16);
        self.infoTextView.alwaysBounceVertical = YES;
        self.infoTextView.showsVerticalScrollIndicator   = NO;
        self.infoTextView.placeholderFont                = YuanFont(16);
        self.infoTextView.textAlignment                  = NSTextAlignmentLeft;
        [self.contentView addSubview:self.infoTextView];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(8);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.height.equalTo(self.contentView.mas_height).offset(-16);
            make.width.equalTo(self.contentView).multipliedBy(1.0/5);
        }];
        [self.infoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(8);
            make.right.equalTo(self.contentView).offset(-8);
            make.top.bottom.equalTo(self.titleLabel);
            
        }];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
