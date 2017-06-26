//
//  CZChattingViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/18.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZChattingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YYTextView.h"
#import "pickPictureCollectionView.h"
#import "EmotionCollectionView.h"
#import "ToastUtils.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import "ZLCollectionCell.h"
#import "RecordButton.h"
#import "parseChattingMessage.h"
#import "ChattingCell.h"
#import "amrFileCodec.h"
#import "CZMainNavigationController.h"
#import <UIViewController+LMSideBarController.h>

@interface CZChattingViewController ()<YYTextViewDelegate,EmotionCollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) YYTextView *textView;               //输入框
@property(nonatomic,strong) UIView     *keyboardView;

@property(nonatomic,strong) UIButton *addPicButton;             //添加图片按钮
@property(nonatomic,strong) UILabel  *picCountLabel;             //图片数
@property(nonatomic,strong) UIButton *addEmotionButton;         //添加表情按钮
@property(nonatomic,strong) UIButton *addMicrophoneButton;      //添加语音按钮
@property(nonatomic,strong) UIButton *keyboardButton;           //键盘按钮

@property (nonatomic,assign) CGRect                                keyBoardHFrame;
@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (nonatomic, strong) NSArray                              *arrDataSources;
@property (nonatomic,strong) NSMutableArray                        *allPictures;
@property (nonatomic,strong) EmotionCollectionView *emotionCollectionView; //选择表情的CollectionView


@property (nonatomic,strong) UIView         *recordView;   //录音View
@property (nonatomic,strong) NSData         *recordData;   //录音数据
@property (nonatomic,strong) NSString       *recordTime;
@property (nonatomic,strong) AVAudioPlayer  *recordPlayer;
@property (nonatomic,strong) UIButton       *playButton;
@property (nonatomic,strong) UILabel        *recordTimeLabel;

@property (nonatomic,strong) NSMutableArray *messages;     //所有信息
@property (nonatomic,strong)NSMutableArray  *cellHeight;   //所有信息用Cell的高度

@property (nonatomic,strong) UITableView    *tableView;

@end

@implementation CZChattingViewController
#pragma mark - 懒加载

//表情CollectionView
-(EmotionCollectionView *)emotionCollectionView{
    if(!_emotionCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _emotionCollectionView = [[EmotionCollectionView alloc]initWithFrame:self.keyBoardHFrame    collectionViewLayout:layout];
        _emotionCollectionView.cz_delegate = self;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _emotionCollectionView;
    
}

//录音页面
-(UIView *)recordView{
    if(!_recordView){
        _recordView = [[UIView alloc]initWithFrame:self.keyBoardHFrame];
        _recordView.backgroundColor = kWhiteColor;
        
        //添加录音Button
        RecordButton *recordButton = [[RecordButton alloc]initWithFrame:CGRectMake(0, 0, _recordView.frame.size.height*0.6, _recordView.frame.size.height*0.6)];
        recordButton.center = CGPointMake(_recordView.frame.size.width/2, _recordView.frame.size.height/2);
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recordFinishAction:) name:@"RecordDidFinishNotification" object:nil];
        [_recordView addSubview:recordButton];
        //添加播放按钮
        self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(_recordView.frame.size.width-_recordView.frame.size.width*0.2,0, _recordView.frame.size.width*0.2, _recordView.frame.size.height*0.15)];
        UIButton *speakerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.playButton.frame.size.height, self.playButton.frame.size.height)];
        [speakerButton setImage:[UIImage imageNamed:@"media_volume_2"] forState:(UIControlStateNormal)];
        [speakerButton addTarget:self action:@selector(playRecorder:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.playButton addSubview:speakerButton];
        
        self.recordTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(speakerButton.frame), 0, self.playButton.frame.size.width-self.playButton.frame.size.height, self.playButton.frame.size.height)];
        self.recordTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.recordTimeLabel.font = [UIFont systemFontOfSize:15];
        self.recordTimeLabel.textColor = [UIColor lightGrayColor];
        [self.playButton addSubview:self.recordTimeLabel];
        [_recordView addSubview:self.playButton];
        
        
        [self.playButton addTarget:self action:@selector(playRecorder:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _recordView;
}

#pragma mark- 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag                       = 1   ;
    self.view.backgroundColor           = [UIColor whiteColor];
    self.title                          = self.userInfo.name;
    [self setupUI];
    [self createConversation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessageAction:) name:@"ReceiveMessage" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CZMainNavigationController *mainNavigationController = (CZMainNavigationController*)self.sideBarController.contentViewController;
    mainNavigationController.navigationBar.hidden   = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    //removeObserver 从通知中心 移除 之前监听的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setMessagesReaded" object:self.userInfo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    CZMainNavigationController *mainNavigationController = (CZMainNavigationController*)self.sideBarController.contentViewController;
    mainNavigationController.navigationBar.hidden   = YES;
}

#pragma mark - 创建会话
-(void)createConversation{
 
    self.conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.userInfo.user.objectId conversationType:eConversationTypeChat];
    NSArray *oldMessages = self.conversation.loadAllMessages;    //获取以前的聊天信息
    self.messages        = [NSMutableArray arrayWithArray:oldMessages];
    self.cellHeight = [[parseChattingMessage parseChattingCellHeightWithMessageArray:self.messages] mutableCopy];
    [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToTableViewLastRow];
    });

}


#pragma mark - 接受消息
-(void)didReceiveMessageAction:(NSNotification *)notification{
    EMMessage *message = notification.object;
    //避免重复
    for (EMMessage *m in self.messages) {
        if (m.timestamp == message.timestamp) {
            return;
        }
    }
    
    if ([message.from isEqualToString:self.userInfo.user.objectId]) {
        
        
        [self.messages addObject:message];
        
        [self.cellHeight addObject:[parseChattingMessage parseChattingCellHeightWithMessage:message]];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.messages.count-1 inSection:0]] withRowAnimation:(UITableViewRowAnimationFade)];
        [self scrollToTableViewLastRow];
    }

}

#pragma mark - 键盘通知
//键盘开启
-(void)openKeyBoard:(NSNotification*)sender{
    self.keyBoardHFrame = [sender.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = [sender.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        CGRect frame            = self.keyboardView.frame;
        frame.origin.y          = kHEIGHT - keyBoardHeight - kWIDTH*0.1;
        self.keyboardView.frame = frame;
        
        frame                = self.tableView.frame;
        frame.size.height    = kHEIGHT  - keyBoardHeight - kWIDTH*0.1 * 2;
        self.tableView.frame = frame;
        [self scrollToTableViewLastRow];
        NSLog(@"%f",self.keyboardView.frame.size.height);
        
    } completion:nil];
    
}

//键盘关闭
-(void)closeKeyBoard:(NSNotification*)sender{
    
    NSTimeInterval duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        CGRect frame = self.keyboardView.frame;
        frame.origin.y = kHEIGHT - kWIDTH*0.1;;
        self.keyboardView.frame = frame;
        
        frame                = self.tableView.frame;
        frame.size.height    = kHEIGHT  - kWIDTH*0.1 * 2;
        self.tableView.frame = frame ;
    } completion:nil];
    
}


#pragma mark - 控件方法
//播放录音
-(void)playRecorder:(UIButton*)sender{
    if(self.recordPlayer == nil)return;
    if([self.recordPlayer isPlaying]){
        [self.recordPlayer pause];
    }else{
        [self.recordPlayer play];
    }
    
}
//添加图片
-(void)addPicture:(UIButton*)sender{
    [self.view endEditing:YES];
    self.addPicButton.backgroundColor = [UIColor clearColor];
    [self setBackgroundForButton:nil];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    
    [actionSheet showWithSender:self animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        
        self.arrDataSources = selectPhotos;
        self.lastSelectMoldels = [selectPhotoModels mutableCopy];
        self.allPictures = [selectPhotos mutableCopy];
        [self.textView becomeFirstResponder];
        [self setBackgroundForButton:selectPhotos.count == 0?nil:self.keyboardButton];
        
        UIImage *image       = [selectPhotos firstObject];
        EMChatImage *imgChat = [[EMChatImage alloc] initWithUIImage:image displayName:@"a.jpg"];
        EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithChatObject:imgChat];

        
        EMMessage *message = [[EMMessage alloc] initWithReceiver:self.userInfo.user.objectId bodies:@[body]];
        message.messageType = eMessageTypeChat;
        
        [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil];
        [self.messages addObject:message];
        
        [self.cellHeight addObject:[parseChattingMessage parseChattingCellHeightWithMessage:message]];
        
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToTableViewLastRow];
        });

        
        
    }];
}
//添加表情
-(void)addEmotion:(UIButton*)sender{
    [self.textView becomeFirstResponder];
    self.textView.inputView = self.emotionCollectionView;
    [self.textView reloadInputViews];
    [self setBackgroundForButton:sender];
}
//添加语音
-(void)addMicrophone:(UIButton*)sender{
    [self.textView becomeFirstResponder];
    self.textView.inputView = self.recordView;
    [self.textView reloadInputViews];
    [self setBackgroundForButton:sender];
}
//切换键盘
-(void)keyboard:(UIButton*)sender{
    [self.textView becomeFirstResponder];
    self.textView.inputView = nil;
    [self.textView reloadInputViews];
    [self setBackgroundForButton:sender];
}

#pragma mark - 设置Button背景颜色
-(void)setBackgroundForButton:(UIButton*)button;{
    self.addPicButton.backgroundColor = [UIColor clearColor];
    self.addEmotionButton.backgroundColor = [UIColor clearColor];
    self.addMicrophoneButton.backgroundColor = [UIColor clearColor];
    self.keyboardButton.backgroundColor = [UIColor clearColor];
    button.backgroundColor = kWhiteColor;
}

#pragma mark - 录音完成监听方法
-(void)recordFinishAction:(NSNotification*)notifiction{
    float time = [notifiction.object[@"time"] floatValue];
    self.recordTime = [NSString stringWithFormat:@"%.1fs",time];
//    self.recordTimeLabel.text = [NSString stringWithFormat:@"%.1fs",time];
    self.recordData = notifiction.object[@"data"];
    self.recordPlayer = [[AVAudioPlayer alloc]initWithData:self.recordData error:nil];
    
    EMMessage *message = nil;
    EMChatVoice *voice = [[EMChatVoice alloc] initWithData:self.recordData displayName:@"a.amr"];
    voice.duration = [self.recordTime floatValue];
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:voice];
    
    // 生成message
    message = [[EMMessage alloc] initWithReceiver:self.userInfo.user.objectId bodies:@[body]];
    message.messageType = eMessageTypeChat; // 设置为单聊消息
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil];
    [self.messages addObject:message];
    
    [self.cellHeight addObject:[parseChattingMessage parseChattingCellHeightWithMessage:message]];
    
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToTableViewLastRow];
    });


}


#pragma mark - 设置UI
-(void)setupUI{
    //设置tableView
    self.tableView                 = [[UITableView alloc]init];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChattingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"chattingCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT  - kWIDTH*0.1*2);
    
    //设置键盘工具栏
    self.keyboardView = [[UIView alloc]initWithFrame:CGRectMake(0, kHEIGHT-kWIDTH*0.1, kWIDTH, kWIDTH*0.1)];
    UIView *keyseparateView         = [[UIView alloc]initWithFrame:CGRectMake(0, self.keyboardView.bounds.size.height-1, self.keyboardView.bounds.size.width, 1)];
    keyseparateView.backgroundColor = [UIColor blackColor];
    [self.keyboardView addSubview:keyseparateView];
    [self.view addSubview:self.keyboardView];
    
    //设置输入框
    self.textView                     = [[YYTextView alloc]init];
    self.textView.delegate            = self;
    self.textView.layer.cornerRadius  = 10;
    self.textView.layer.borderWidth   = 1;
    self.textView.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    self.textView.layer.masksToBounds = YES;
    self.textView.font                = YuanFont(18);
    self.textView.returnKeyType  = UIReturnKeySend;
    [Utils faceMappingWithText:self.textView];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.keyboardView).offset(8);
        make.right.equalTo(self.keyboardView).offset(-8);
        make.bottom.equalTo(self.keyboardView.mas_top);
        make.height.equalTo(self.keyboardView);
    }];
    
    //设置添加图片按钮
    self.addPicButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.keyboardView.bounds.size.height*0.8, self.keyboardView.bounds.size.height*0.8)];
    self.addPicButton.center = CGPointMake(self.keyboardView.bounds.size.width*0.08, self.keyboardView.bounds.size.height/2);
    [self.addPicButton setImage:[UIImage imageNamed:@"Picture"] forState:(UIControlStateNormal)];
    [self.addPicButton addTarget:self action:@selector(addPicture:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.keyboardView addSubview:self.addPicButton];
    
    self.picCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.addPicButton.frame.size.height/2, self.addPicButton.frame.size.height/2)];
    self.picCountLabel.center = CGPointMake(self.addPicButton.frame.size.width, 0);
    self.picCountLabel.textColor = [UIColor whiteColor];
    self.picCountLabel.textAlignment = NSTextAlignmentCenter;
    self.picCountLabel.font = [UIFont systemFontOfSize:12 weight:1];
    self.picCountLabel.backgroundColor = [UIColor redColor];
    self.picCountLabel.layer.cornerRadius = self.picCountLabel.frame.size.width/2;
    self.picCountLabel.layer.masksToBounds = YES;
    self.picCountLabel.hidden = YES;
    [self.addPicButton addSubview:self.picCountLabel];
    
    //设置添加表情按钮
    self.addEmotionButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addPicButton.frame)+self.keyboardView.bounds.size.width*0.08, self.addPicButton.frame.origin.y, self.keyboardView.bounds.size.height*0.8, self.keyboardView.bounds.size.height*0.8)];
    [self.addEmotionButton setImage:[UIImage imageNamed:@"Emotion"] forState:(UIControlStateNormal)];
    [self.addEmotionButton addTarget:self action:@selector(addEmotion:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.keyboardView addSubview:self.addEmotionButton];
    
    //设置添加语音按钮
    self.addMicrophoneButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addEmotionButton.frame)+self.keyboardView.bounds.size.width*0.08, self.addPicButton.frame.origin.y, self.keyboardView.bounds.size.height*0.8, self.keyboardView.bounds.size.height*0.8)];
    [self.addMicrophoneButton setImage:[UIImage imageNamed:@"Microphone"] forState:(UIControlStateNormal)];
    [self.addMicrophoneButton addTarget:self action:@selector(addMicrophone:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.keyboardView addSubview:self.addMicrophoneButton];
    
    //设置键盘按钮keyboard
    self.keyboardButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addMicrophoneButton.frame)+self.keyboardView.bounds.size.width*0.08, self.addPicButton.frame.origin.y, self.keyboardView.bounds.size.height*0.8, self.keyboardView.bounds.size.height*0.8)];
    [self.keyboardButton setImage:[UIImage imageNamed:@"keyboard"] forState:(UIControlStateNormal)];
    [self.keyboardButton addTarget:self action:@selector(keyboard:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.keyboardView addSubview:self.keyboardButton];
}
#pragma mark - 显示或隐藏图片数Label
-(void)setupPicCountLabel{
    if(self.allPictures.count>0){
        self.picCountLabel.hidden = NO;
        self.picCountLabel.text = @(self.allPictures.count).stringValue;
    }else{
        self.picCountLabel.hidden = YES;
    }
}

#pragma mark - EmotionCollectionViewDelegate
-(void)EmotionCollectionView:(EmotionCollectionView *)collectionView selectEmotion:(NSDictionary *)emotion{
    [self.textView insertText:emotion[@"chs"]];
}
#pragma mark - YYTextViewDelegate,响应键盘发送按键触发事件
-(void)textViewDidBeginEditing:(YYTextView *)textView{
    [self setBackgroundForButton:self.keyboardButton];
}

//响应键盘发送按键触发事件
-(BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        if(![Utils checkingString:textView.text]){
            [SVProgressHUD showInfoWithStatus:@"请输入内容!"];
            return YES;
        }
        // 生成message
        EMMessage *message = nil;
        EMChatText *txtChat = [[EMChatText alloc] initWithText:textView.text];
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
        
        message = [[EMMessage alloc] initWithReceiver:self.userInfo.user.objectId bodies:@[body]];
        message.messageType = eMessageTypeChat; // 设置为单聊消息
        [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil];
        [self.messages addObject:message];
        
        [self.cellHeight addObject:[parseChattingMessage parseChattingCellHeightWithMessage:message]];
        
        [self.tableView reloadData];
        //获取主线程队列，tableView刷新完成之后调用block
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToTableViewLastRow];
            self.textView.text = @"";
        });
        

    }
    return YES;
}

#pragma mark - tableView滚动到最后一个Cell
-(void)scrollToTableViewLastRow
{
    if(self.messages.count == 0){
        return;
    }
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - tablieViewDelegate and dataSource
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
    [self setBackgroundForButton:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChattingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chattingCell" forIndexPath:indexPath];
    cell.message        = self.messages[indexPath.row];
    cell.toUserInfo     = self.userInfo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cellHeight[indexPath.row] integerValue]+4*kSpacing;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EMMessage *message = self.messages[indexPath.row];
    
    //得到消息里面的内容展示
    
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Voice:
        {
            
            
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            
            
            NSData *data = nil;
            if ([message.from isEqualToString:self.userInfo.user.objectId]) {//对方
                
                data = [NSData dataWithContentsOfURL:[NSURL URLWithString:body.remotePath]];
                
            }else{
                
                data = [NSData dataWithContentsOfFile:body.localPath];
            }
            
            
            data = DecodeAMRToWAVE(data);
            
            self.recordPlayer = [[AVAudioPlayer alloc]initWithData:data error:nil];
            [self.recordPlayer play];
            ChattingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.voiceView beginAnimation];
            
        }
    }
    
}



@end
