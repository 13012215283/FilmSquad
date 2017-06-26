//
//  ChattingCell.m
//  LanYiEnglish
//
//  Created by tarena_shuan on 16/11/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ChattingCell.h"
#import <YYTextView.h>
@interface ChattingCell ()
@property (nonatomic, strong)YYTextView* textContent;
@property (nonatomic, strong)UIImageView* imgContent;
@property (nonatomic, strong)UIImageView *imageBubbleIV;

@end

@implementation ChattingCell

-(TRVoiceView *)voiceView{
    
    if (!_voiceView) {
        _voiceView = [[NSBundle mainBundle]loadNibNamed:@"TRVoiceView" owner:self options:nil][0];
        //设置音频控件的显示坐标
        _voiceView.frame = CGRectMake(15, 12, 0, 0);
//        _voiceView.origin  = CGPointMake(15, 12);
        [self.backgroundIV addSubview:self.voiceView];
    }
    return _voiceView;
}
-(UIImage *)imageBubbleLeft{
    if (!_imageBubbleLeft) {
        _imageBubbleLeft = [UIImage imageNamed:@"message_other"];
        _imageBubbleLeft = [_imageBubbleLeft resizableImageWithCapInsets:UIEdgeInsetsMake(19, 31, 17, 14) resizingMode:UIImageResizingModeStretch];
    }
    return _imageBubbleLeft;
}
-(UIImage *)imageBubbleRight{
    if (!_imageBubbleRight) {
        _imageBubbleRight = [UIImage imageNamed:@"message_i"];
        _imageBubbleRight = [_imageBubbleRight resizableImageWithCapInsets:UIEdgeInsetsMake(19, 14, 17, 31) resizingMode:UIImageResizingModeStretch];
    }
    return _imageBubbleRight;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.headIV.layer.cornerRadius = self.headIV.frame.size.width / 2;
    self.headIV.layer.masksToBounds = YES;
    
    
}
-(UIImageView *)imgContent{
    if (_imgContent == nil) {
        _imgContent = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BubbleWidth*.6, BubbleWidth*.6)];
        _imgContent.contentMode = UIViewContentModeScaleAspectFill;
        _imgContent.layer.masksToBounds = YES;

        [self addSubview:_imgContent];
        
        self.imageBubbleIV = [[UIImageView alloc]initWithFrame:_imgContent.bounds];
        [_imgContent addSubview:self.imageBubbleIV];
    }
    return _imgContent;
}

-(YYTextView *)textContent{
    if (_textContent == nil) {
        _textContent = [[YYTextView alloc]initWithFrame:CGRectMake(2*kSpacing, kSpacing, BubbleWidth-4*kSpacing, 0)];
        _textContent.font = YuanFont(14);
        [Utils faceMappingWithText:_textContent];
        [self.backgroundIV addSubview:_textContent];
    }
    return _textContent;
}





-(void)setMessage:(EMMessage *)message{
    _message = message;
    
    //为了避免复用出错
    self.textContent.hidden = self.imgContent.hidden =self.voiceView.hidden = YES;
    
    NSString* backgroundImgNameOfText =  [message.from isEqualToString:self.toUserInfo.user.objectId]?@"chat_recive_nor":@"chat_send_nor";
    
    self.backgroundIV.image = [UIImage imageNamed:backgroundImgNameOfText];
    
       //得到消息里面的内容展示
    
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            self.backgroundIV.hidden = NO;
            self.textContent.hidden = NO;
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            
            CGRect frame               = self.textContent.frame;
            frame.size.width           = BubbleWidth-4*kSpacing;
            frame.size.height          = 0;
            self.textContent.frame     = frame;
            self.textContent.text      = txt;
            self.textContent.textColor = [UIColor blackColor];
            
            frame                      = self.textContent.frame;
            frame.size                 = self.textContent.textLayout.textBoundingSize;
   
            self.textContent.frame     = frame;
            
            //修改气泡尺寸
            frame = self.backgroundIV.frame;
            frame.size =  CGSizeMake(self.textContent.frame.size.width+4*kSpacing, self.textContent.frame.size.height+2*kSpacing);
            self.backgroundIV.frame = frame;
        }
            break;
            
        case eMessageBodyType_Image:
        {
            self.imgContent.hidden = NO;
            self.backgroundIV.hidden = YES;
            
            
             EMImageMessageBody *body = (EMImageMessageBody *)msgBody;
            
            
            
            if ([message.from isEqualToString:self.toUserInfo.user.objectId]) {//对方
                NSString *path = body.remotePath;
                [self.imgContent sd_setImageWithURL:[NSURL URLWithString:path]];
                self.imageBubbleIV.image = self.imageBubbleLeft;
                
            
            }else{
                NSString *path = body.localPath;
                self.imgContent.image = [UIImage imageWithContentsOfFile:path];
                self.imageBubbleIV.image = self.imageBubbleRight;
            }
            
            
            
            
        }
            break;
        case eMessageBodyType_Voice:
        {
            self.voiceView.hidden = NO;
            self.backgroundIV.hidden = NO;
               EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            
            //设置显示时间
            self.voiceView.timeLabel.text = [NSString stringWithFormat:@"%ld\"",body.duration];
            
          
            //设置气泡的大小
            CGRect frame            = self.backgroundIV.frame;
            frame.size              = CGSizeMake(60+30, 25+24);
            self.backgroundIV.frame = frame;
            
            
            if ([message.to isEqualToString:self.toUserInfo.user.objectId]) {//自己发送的内容
                [self.voiceView changeLocation:YES];
   
            }else{
                [self.voiceView changeLocation:NO];
            }
            
            
        }
            break;
            
    }
//设置头像位置
    [self updateImageViewPosition];

    
}

-(void)updateImageViewPosition{
    if (![self.message.from isEqualToString:self.toUserInfo.user.objectId]) {
        CGRect frame = self.headIV.frame;
        frame.origin.x = kWIDTH - 8- 40;
        self.headIV.frame = frame;
        [self.headIV sd_setImageWithURL:[[BmobUser currentUser] objectForKey:@"HeadURL"] placeholderImage:[UIImage imageNamed:@"user"]];
        
        frame = self.backgroundIV.frame;
        frame.origin.x = self.headIV.frame.origin.x - 8 - frame.size.width;
        self.backgroundIV.frame = frame;
        
        frame = self.imgContent.frame;
        frame.origin.x = self.headIV.frame.origin.x - 8 - frame.size.width;
        self.imgContent.frame = frame;
        
//        self.backgroundIV.right = self.imgContent.right = self.headIV.x - 8;
        
        
    }
    else{
        
        CGRect frame      = self.headIV.frame;
        frame.origin.x    = 8;
        self.headIV.frame = frame;
//        self.headIV.x = 8;
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:self.toUserInfo.headURL] placeholderImage:[UIImage imageNamed:@"user"]];
        
        frame = self.backgroundIV.frame;
        frame.origin.x = CGRectGetMaxX(self.headIV.frame) + kSpacing;
        self.backgroundIV.frame = frame;
        
        frame = self.imgContent.frame;
        frame.origin.x = CGRectGetMaxX(self.headIV.frame) + kSpacing;
        self.imgContent.frame = frame;

        
//        self.backgroundIV.x =
//          self.imgContent.left = self.headIV.right + kSpacing;
    }
}

-(void)setupImgContent{
    CGRect frame          = self.imgContent.frame;
    frame.origin          = self.backgroundIV.frame.origin;
    frame.size.width      = self.backgroundIV.frame.size.width - kSpacing;
    frame.size.height     = self.backgroundIV.frame.size.height - kSpacing;
    self.imgContent.frame = frame;
//    self.imgContent.x = self.backgroundIV.x;
//    self.imgContent.y = self.backgroundIV.y;
//    self.imgContent.width = self.backgroundIV.width - kSpacing;
//    self.imgContent.height = self.backgroundIV.height - kSpacing;
}


@end
