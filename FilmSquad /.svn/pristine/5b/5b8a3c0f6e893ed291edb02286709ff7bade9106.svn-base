//
//  CZConversationCell.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/20.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZConversationCell.h"

@implementation CZConversationCell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.headImageView                     = [[UIImageView alloc]init];
        self.headImageView.backgroundColor     = [UIColor whiteColor];
        self.headImageView.layer.cornerRadius  = (60 - 16)/2;
//        self.headImageView.layer.borderWidth   = 1;
//        self.headImageView.layer.borderColor   = [UIColor whiteColor].CGColor;
        self.headImageView.layer.masksToBounds = YES;
        
        //名字
        self.nameLabel               = [[UILabel alloc]init];
        self.nameLabel.textColor     = [UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font          = YuanFont(16);
        
        //未读消息数
        self.unReadedCountLabel                 = [[UILabel alloc]init];
        self.unReadedCountLabel.backgroundColor = [UIColor redColor];
        self.unReadedCountLabel.font            = YuanFont(14);
        self.unReadedCountLabel.textAlignment   = NSTextAlignmentCenter;
        self.unReadedCountLabel.textColor       = [UIColor whiteColor];
        self.unReadedCountLabel.layer.cornerRadius  = (60-16)/2/2;
        self.unReadedCountLabel.layer.masksToBounds = YES;
    
        
        //请求信息
        self.messageLabel               = [[YYTextView alloc]init];
        self.messageLabel.textColor     = [UIColor grayColor];
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.font          = YuanFont(14);
        self.messageLabel.userInteractionEnabled = NO;
        [Utils faceMappingWithText:self.messageLabel];
        
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.unReadedCountLabel];
        //布局
        [self masonry];
    }
    return self;
}

#pragma mark - set方法
-(void)setConversation:(EMConversation *)conversation{
    _conversation = conversation;
    NSMutableArray *allMessage = [conversation.loadAllMessages mutableCopy];
    EMMessage *message         = [allMessage lastObject];
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
  
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            self.messageLabel.text = ((EMTextMessageBody*)msgBody).text;
        }
            break;
            
        case eMessageBodyType_Image:
        {
            self.messageLabel.text = @"图片";
        }
            break;
        case eMessageBodyType_Voice:
        {
            self.messageLabel.text = @"语音";
        }
    }
    
    self.unReadedCountLabel.hidden = [conversation unreadMessagesCount] == 0 ? YES : NO;
    self.unReadedCountLabel.text   = @([conversation unreadMessagesCount]).stringValue;
}

-(void)setUserInfo:(CZUserInfo *)userInfo{
    _userInfo = userInfo;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headURL] placeholderImage:[UIImage imageNamed:@"user"]];
    self.nameLabel.text = userInfo.name;
}


#pragma mark - masonry
-(void)masonry{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.width.height.equalTo(self.contentView.mas_height).offset(-16);
    }];
    
    [self.unReadedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(self.headImageView).multipliedBy(0.5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(8);
        make.top.equalTo(self.headImageView);
        make.right.equalTo(self.unReadedCountLabel.mas_left).offset(-8);
        make.height.equalTo(self.headImageView).multipliedBy(0.5);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.width.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom);
    }];


    
}


@end
