//
//  CZ_DynamicCell.m
//  CZEnglish
//
//  Created by tarena_cz on 16/11/18.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZ_DynamicCell.h"
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+AFNetworking.h>
@interface CZ_DynamicCell()
@property (nonatomic, strong)AVAudioPlayer *player;
@property (nonatomic, strong)NSMutableData *musicData;
@end
@implementation CZ_DynamicCell
#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = kWhiteColor;
        self.headImageView = [[UIImageView alloc]init];
        self.nameLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.titleTextView = [[YYTextView alloc]init];
        self.titleTextView.font = YuanFont(15);
        [Utils faceMappingWithText:self.titleTextView];
        self.titleTextView.userInteractionEnabled = NO;
        self.titleTextView.textAlignment = NSTextAlignmentCenter;
        
        self.containerView = [[CZ_ContainerView alloc]init];
        self.bottomBar = [[UIView alloc]init];
        
        self.topButton = [[UIButton alloc]init];
        
        [self.contentView addSubview:self.topButton];
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.titleTextView];
        [self.contentView addSubview:self.containerView];
        [self.contentView addSubview:self.bottomBar];
        
        self.playControl = [[CZ_Control alloc]initWithFrame:CGRectZero];
        self.playControl.imageView.image = [UIImage imageNamed:@"media_volume_2"];
        
        self.repostControl = [[CZ_Control alloc]initWithFrame:CGRectZero];;
        self.repostControl.imageView.image = [UIImage imageNamed:@"share_pressed"];
        
        self.commentControl = [[CZ_Control alloc]initWithFrame:CGRectZero];;
        self.commentControl.imageView.image = [UIImage imageNamed:@"comment_pressed"];
        
        self.zanControl = [[CZ_Control alloc]initWithFrame:CGRectZero];;
        
        [self.bottomBar addSubview:self.playControl];
        [self.bottomBar addSubview:self.repostControl];
        [self.bottomBar addSubview:self.commentControl];
        [self.bottomBar addSubview:self.zanControl];


        //分割线
        self.topSeparateView = [[UIView alloc]init];
        self.bottomSeparateView = [[UIView alloc]init];
        self.topSeparateView.backgroundColor = kWhiteColor;
        self.bottomSeparateView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.topSeparateView];
        [self.bottomBar addSubview:self.bottomSeparateView];
    }
    return self;
}
#pragma mark set方法
-(void)setDynamicFrame:(DynamicFrame *)dynamicFrame{
    _dynamicFrame = dynamicFrame;
    [self setFrameForAll];
    [self setDataForAll];
}

#pragma  mark - 设置frame
-(void)setFrameForAll{
    //判断是否点过赞，并设置不同的图片
    if(self.dynamicFrame.dynamic.isZan == YES){
        self.zanControl.imageView.image = [UIImage imageNamed:@"zan_pressed"];
    }else{
        self.zanControl.imageView.image = [UIImage imageNamed:@"zan_normal"];
    }

    self.headImageView.frame = self.dynamicFrame.headerImageViewF;
    
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.height/2;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.borderWidth = 1;
    self.headImageView.layer.borderColor = [kWhiteColor CGColor];
   

    self.nameLabel.frame = self.dynamicFrame.nameLabelF;
    self.nameLabel.font = YuanFont(16);
    
    self.timeLabel.frame = self.dynamicFrame.timeLabelF;
    self.timeLabel.font = YuanFont(12);
    self.timeLabel.textColor = [UIColor lightGrayColor];
    
    
    self.titleTextView.frame = self.dynamicFrame.titleTextViewF;
    
    
    self.containerView.frame = self.dynamicFrame.containerViewF;
    self.bottomBar.frame = self.dynamicFrame.bottomBarF;
    
    self.topSeparateView.frame = self.dynamicFrame.topSeparatViewF;
    self.bottomSeparateView.frame = self.dynamicFrame.bottomSeparatViewF;
    
    //将模型数据传入containerView,设置其子视图
    self.containerView.dynamicFrame = self.dynamicFrame;
    
    //设置buttonBar里面的内容
    self.playControl.frame = self.dynamicFrame.playControlF;
    self.repostControl.frame = self.dynamicFrame.repostControlF;
    self.commentControl.frame = self.dynamicFrame.commentContolF;
    self.zanControl.frame = self.dynamicFrame.zanControlF;
    
    
    self.playControl.tag = 0;
    self.repostControl.tag = 1;
    self.commentControl.tag = 2;
    self.zanControl.tag = 3;
    [self.playControl addTarget:self action:@selector(actionForControl:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.repostControl addTarget:self action:@selector(actionForControl:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.repostControl addTarget:self action:@selector(actionForControlTouchDown:) forControlEvents:(UIControlEventTouchDown)];
    [self.repostControl addTarget:self action:@selector(actionTouchUpOutside:) forControlEvents:(UIControlEventTouchUpOutside)];
    
    [self.commentControl addTarget:self action:@selector(actionForControl:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.commentControl addTarget:self action:@selector(actionForControlTouchDown:) forControlEvents:(UIControlEventTouchDown)];
    [self.commentControl addTarget:self action:@selector(actionTouchUpOutside:) forControlEvents:(UIControlEventTouchUpOutside)];
    
    [self.zanControl addTarget:self action:@selector(actionForControl:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.zanControl addTarget:self action:@selector(actionForControlTouchDown:) forControlEvents:(UIControlEventTouchDown)];
    [self.zanControl addTarget:self action:@selector(actionTouchUpOutside:) forControlEvents:(UIControlEventTouchUpOutside)];
    
    //设置右上角button
    
    if(self.dynamicFrame.topButtoImageName !=nil){
        self.topButton.frame = self.dynamicFrame.topButtonF;
        self.topButton.tag = 4;
        [self.topButton setImage:[UIImage imageNamed:self.dynamicFrame.topButtoImageName] forState:(UIControlStateNormal)];
        [self.topButton addTarget:self action:@selector(actionForControl:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    
}
#pragma mark - 设置数据
-(void)setDataForAll{
    Dynamic *dynamic = self.dynamicFrame.dynamic;
    self.nameLabel.text = dynamic.name;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dynamic.headURL] placeholderImage:[UIImage imageNamed:@"user"]];

    
    self.timeLabel.text = dynamic.created_at;
    self.titleTextView.text = @"";
    [self.titleTextView insertText:dynamic.title];
    
    self.playControl.hidden = (dynamic.recordURL==nil)?YES:NO;
    
    //设置语音时间数
    self.playControl.titleLabel.text = self.dynamicFrame.dynamic.recordDuration;
   
    //设置转发数
    self.repostControl.titleLabel.text = dynamic.reposts_count;
    if(self.dynamicFrame.dynamic.reposts_count==nil){
        self.repostControl.titleLabel.text = @"0";
    }
    //设置评论数
    self.commentControl.titleLabel.text = self.dynamicFrame.dynamic.comments_count;
    if(self.dynamicFrame.dynamic.comments_count==nil){
        self.commentControl.titleLabel.text = @"0";
    }
    //设置点赞数
    self.zanControl.titleLabel.text = self.dynamicFrame.dynamic.zan_count;
    if(self.dynamicFrame.dynamic.zan_count==nil){
        self.zanControl.titleLabel.text = @"0";
    }
    
}


#pragma mark - 控件方法
-(void)actionForControl:(UIControl*)sender{
    switch (sender.tag) {
        case 0:
            [self downloadMusicWithURL:[NSURL URLWithString:self.dynamicFrame.dynamic.recordURL]];
            break;
        case 1:
            [self.cz_delegate CZ_DynamicCell:self clickedRepost:sender];
            break;
        case 2:
            [self.cz_delegate CZ_DynamicCell:self clickedComment:sender];
            break;
        case 3:
            [self.cz_delegate CZ_DynamicCell:self clickedZan:sender];
            break;
        case 4:
            [self.cz_delegate CZ_DynamicCell:self clickedTopButton:sender];
        default:
            break;
    }
    sender.backgroundColor = [UIColor clearColor];
}

-(void)actionForControlTouchDown:(UIControl*)sender{
    sender.backgroundColor = kWhiteColor;
}
-(void)actionTouchUpOutside:(UIControl*)sender{
    sender.backgroundColor = [UIColor clearColor];
}



#pragma mark - 下载语音方法
-(void)downloadMusicWithURL:(NSURL *)musicURL{
    //用来保存接收到的实时的音频数据
    self.musicData = [NSMutableData data];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:musicURL];
    //创建数据任务
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度:%f",downloadProgress.fractionCompleted);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"下载完成!");
    }];
    //设置得到实时数据的block
    [manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
        NSLog(@"%ld",data.length);
        //把歌曲数据拼接起来
        [self.musicData appendData:data];
        
        //没有创建 或者创建出来没有播放 都需要重新创建并播放
        if (!self.player||!self.player.isPlaying) {
            self.player = [[AVAudioPlayer alloc]initWithData:self.musicData error:nil];
            [self.player play];
            
            NSLog(@"%f",self.player.duration);
            NSLog(@"开始并播放");
        }
        
    }];
    //开始任务
    [task resume];
}




#pragma mark - 每次设置时时调用
-(void)layoutSubviews{
    [super layoutSubviews];
    if(!self.dynamicFrame.bottomPaddingHidden){
        CGRect frame = self.contentView.frame;
        frame.size.height = self.frame.size.height-8;
        self.contentView.frame = frame;
    }
}


@end
