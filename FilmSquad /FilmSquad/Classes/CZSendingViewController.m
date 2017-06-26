
//  CZSendingViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/13.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZSendingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YYTextView.h"
#import "pickPictureCollectionView.h"
#import "EmotionCollectionView.h"
#import "ToastUtils.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import "ZLCollectionCell.h"
#import "RecordButton.h"


@interface CZSendingViewController ()<YYTextViewDelegate,pickPictureCollectionViewDelegate,EmotionCollectionViewDelegate>
@property(nonatomic,strong) YYTextView *titleTextView;
@property(nonatomic,strong) YYTextView *textView;
@property(nonatomic,strong) YYTextView *currentTextView;
@property(nonatomic,strong) UIView *keyboardView;
@property(nonatomic,strong) UIView *separateView;
@property(nonatomic,strong) UIView *topSeparateView;
@property(nonatomic,strong) UIButton *addPicButton;
@property(nonatomic,strong) UILabel *picCountLabel;
@property(nonatomic,strong) UIButton *addEmotionButton;
@property(nonatomic,strong) UIButton *addMicrophoneButton;
@property(nonatomic,strong) UIButton *keyboardButton;


@property (nonatomic,assign) CGRect keyBoardHFrame;
@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (nonatomic, strong) NSArray *arrDataSources;
@property (nonatomic,strong) NSMutableArray *allPictures;
@property (nonatomic,strong) pickPictureCollectionView *collectionView; //选择图片的CollectionView
@property (nonatomic,strong) EmotionCollectionView *emotionCollectionView; //选择表情的CollectionView

@property (nonatomic,strong) NSMutableArray *imagesURL;
@property (nonatomic,strong) NSString *recordURl;

@property (nonatomic,strong) UIView *recordView;   //录音View
@property (nonatomic,strong) NSData *recordData;   //录音数据
@property (nonatomic,strong) NSString *recordTime;
@property (nonatomic,strong) AVAudioPlayer *recordPlayer;
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UILabel *recordTimeLabel;

@property (nonatomic,strong) BmobObject *bmobObject;
@end

@implementation CZSendingViewController
#pragma mark - 懒加载
//初始化BmobObject
-(BmobObject *)bmobObject{
    if(!_bmobObject){
        if([self.title isEqualToString:@"发表影评"]||[self.title isEqualToString:@"转发"]){
            _bmobObject = [BmobObject objectWithClassName:@"Dynamic"];
        }
        else{
            _bmobObject = [BmobObject objectWithClassName:@"Comment"];
        }
    }
    return _bmobObject;
}
//初始化图片URL
-(NSMutableArray *)imagesURL{
    if(!_imagesURL){
        _imagesURL = [[NSMutableArray alloc]init];
    }
    return _imagesURL;
}
//选择图片的collectonView
-(pickPictureCollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[pickPictureCollectionView alloc]initWithFrame:self.keyBoardHFrame    collectionViewLayout:layout];
        _collectionView.cz_delegate = self;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _collectionView;
}
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

#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //这种导航栏主题字体
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:YuanFont(20)}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置左边返回按钮
    UIImage *leftImage = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(returnAction:)];
    //设置右边发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:(UIBarButtonItemStyleDone) target:self action:@selector(sendingDynamic:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:YuanFont(16)} forState:(UIControlStateNormal)];

    [self setupUI];
    [self setupCommentUI];
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [self setNeedsStatusBarAppearanceUpdate];

}

-(void)viewDidDisappear:(BOOL)animated {
    //removeObserver 从通知中心 移除 之前监听的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
     }

-(void)viewDidAppear:(BOOL)animated{
    [self.textView becomeFirstResponder];
}



#pragma mark - 录音完成监听方法
-(void)recordFinishAction:(NSNotification*)notifiction{
    float time = [notifiction.object[@"time"] floatValue];
    self.recordTime = [NSString stringWithFormat:@"%.1fs",time];
    self.recordTimeLabel.text = [NSString stringWithFormat:@"%.1fs",time];
    self.recordData = notifiction.object[@"data"];
    self.recordPlayer = [[AVAudioPlayer alloc]initWithData:self.recordData error:nil];
    NSLog(@"%f",self.recordPlayer.duration);
    NSLog(@"%f",self.recordPlayer.volume);
}



#pragma mark - 键盘通知
//键盘开启
-(void)openKeyBoard:(NSNotification*)sender{
    self.keyBoardHFrame = [sender.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = [sender.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        CGRect frame = self.keyboardView.frame;
        frame.origin.y = kHEIGHT - keyBoardHeight - kWIDTH*0.1;
        self.keyboardView.frame = frame;
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
    } completion:nil];
    
}
#pragma mark - 控件方法
//返回按钮
-(void)returnAction:(UIBarButtonItem*)sender{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发动动态
-(void)sendingDynamic:(UIBarButtonItem*)sender{
    if([Utils checkingString:self.textView.text]||self.imagesURL.count!=0){
        [SVProgressHUD showWithStatus:@"正在发表"];
        [self uploadImage];
    }else{
        [SVProgressHUD showErrorWithStatus:@"什么都没有写哦"];
    }
    
}
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
    
    [self setupCurrentTextViewResponder];
    
    self.currentTextView.inputView = self.collectionView;
    [self.currentTextView reloadInputViews];
    
    [self setBackgroundForButton:sender];
    
}
//添加表情
-(void)addEmotion:(UIButton*)sender{
    [self setupCurrentTextViewResponder];
    self.currentTextView.inputView = self.emotionCollectionView;
    [self.currentTextView reloadInputViews];
    [self setBackgroundForButton:sender];
}
//添加语音
-(void)addMicrophone:(UIButton*)sender{
    [self setupCurrentTextViewResponder];
    self.currentTextView.inputView = self.recordView;
    [self.currentTextView reloadInputViews];
    [self setBackgroundForButton:sender];
}
//切换键盘
-(void)keyboard:(UIButton*)sender{
    [self setupCurrentTextViewResponder];
    self.currentTextView.inputView = nil;
    [self.currentTextView reloadInputViews];
    [self setBackgroundForButton:sender];
}

#pragma mark - 处理textView响应
-(void)setupCurrentTextViewResponder{
    if(self.currentTextView == nil){
        self.currentTextView = self.titleTextView;
    }
    [self.currentTextView becomeFirstResponder];
}


#pragma mark - 设置Button背景颜色
-(void)setBackgroundForButton:(UIButton*)button;{
    self.addPicButton.backgroundColor = [UIColor clearColor];
    self.addEmotionButton.backgroundColor = [UIColor clearColor];
    self.addMicrophoneButton.backgroundColor = [UIColor clearColor];
    self.keyboardButton.backgroundColor = [UIColor clearColor];
//    self.chooseClassButton.backgroundColor = [UIColor clearColor];
//    self.homeworkDetailButton.backgroundColor = [UIColor clearColor];
    button.backgroundColor = kWhiteColor;
}


#pragma mark - 设置界面
-(void)setupUI{
    //设置背景
    UIImageView *imageView = [Utils glassImageViewWithImage:nil andAlpha:kGlassAlpha];
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
//    设置主题TextView
    self.titleTextView = [[YYTextView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kWIDTH*0.1)];
    self.titleTextView.placeholderText = @"标题(可选)";
    self.titleTextView.textAlignment = NSTextAlignmentNatural;
    self.titleTextView.font = [UIFont systemFontOfSize:16];
    self.titleTextView.placeholderFont = [UIFont systemFontOfSize:16];
    self.titleTextView.backgroundColor = [UIColor whiteColor];
    self.titleTextView.delegate = self;
    self.titleTextView.alwaysBounceVertical = YES;
    [Utils faceMappingWithText:self.titleTextView];
    [self.view addSubview:self.titleTextView];
    
    //设置内容TextView
    self.textView = [[YYTextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleTextView.frame), kWIDTH, kHEIGHT-64-self.titleTextView.bounds.size.height)];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.placeholderText = @"请输入正文";
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.delegate = self;
    self.textView.alwaysBounceVertical = YES;
    [Utils faceMappingWithText:self.textView];
    [self.view addSubview:self.textView];
    //设置分隔线
    self.separateView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleTextView.frame), kWIDTH, 1)];
    self.separateView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.separateView];
    //顶部设置分隔线
    self.topSeparateView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, 1)];
    self.topSeparateView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.topSeparateView];
    //设置键盘工具栏
    self.keyboardView = [[UIView alloc]initWithFrame:CGRectMake(0, kHEIGHT-kWIDTH*0.1, kWIDTH, kWIDTH*0.1)];
    UIView *keyseparateView = [[UIView alloc]initWithFrame:CGRectMake(0, self.keyboardView.bounds.size.height-1, self.keyboardView.bounds.size.width, 1)];
    keyseparateView.backgroundColor = [UIColor blackColor];
    [self.keyboardView addSubview:keyseparateView];
    [self.view addSubview:self.keyboardView];
    
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

#pragma mark - 更新为评论界面
-(void)setupCommentUI{
    if(![self.title isEqualToString:@"发表评论"]){
        return;
    }
    self.titleTextView.placeholderText = @"";
    self.titleTextView.userInteractionEnabled = NO;
    self.textView.placeholderText = @"发表评论";
    self.keyboardButton.frame = self.addMicrophoneButton.frame;
    
    CGRect frame = self.textView.frame;
    frame.origin = self.titleTextView.frame.origin;
    frame.size.height = kHEIGHT - 64;
    self.textView.frame = frame;
    
    self.titleTextView.hidden = YES;
    self.separateView.hidden = YES;
    self.addMicrophoneButton.hidden = YES;
}


#pragma mark - YYTextViewDelegate
-(void)textViewDidBeginEditing:(YYTextView *)textView{
    textView.inputView = self.currentTextView.inputView;
    self.currentTextView = textView;
    [self.currentTextView reloadInputViews];
}

#pragma mark - pickPictureCollectionViewDelegate
//添加图片
-(void)pickPictureCollectionViewAddImage{
    [self.view endEditing:YES];
    self.addPicButton.backgroundColor = [UIColor clearColor];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 9;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    
    [actionSheet showWithSender:self animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        
        self.arrDataSources = selectPhotos;
        self.lastSelectMoldels = [selectPhotoModels mutableCopy];
        self.allPictures = [selectPhotos mutableCopy];
        self.collectionView.allPictures = self.allPictures;
        [self.collectionView reloadData];
        [self.currentTextView becomeFirstResponder];
        [self setBackgroundForButton:self.addPicButton];
        [self setupPicCountLabel];  //设置显示的图片数
    }];
}

-(void)pickPictureCollectionView:(pickPictureCollectionView *)collectionView DidDeleteItemAtIndexpath:(NSIndexPath *)indexPath{
    [self.lastSelectMoldels removeObjectAtIndex:indexPath.item];
    
    [self setupPicCountLabel];     //设置显示的图片数
    
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
    [self.currentTextView insertText:emotion[@"chs"]];
}

#pragma mark - 上传方法
-(void)uploadImage{
    if(self.collectionView.allPictures.count == 0){
        [self uploadRecoder];
        
        return;
    }
    
    NSMutableArray<NSDictionary*> *allImageDic = [[NSMutableArray alloc]init];
    for(UIImage *image in self.collectionView.allPictures){
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        NSInteger index = [self.collectionView.allPictures indexOfObject:image];
        NSString *filename = [NSString stringWithFormat:@"%@_image%ld.jpg",[[BmobUser currentUser] objectForKey:@"nick"],index+1];
        NSDictionary *dic = @{@"filename":filename,@"data":data};
        [allImageDic addObject:dic];
    }
    [BmobFile filesUploadBatchWithDataArray:allImageDic progressBlock:^(int index, float progress) {
        [SVProgressHUD showProgress:progress status:[NSString stringWithFormat:@"正在上传第%d张图片",index+1]];
    } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            for(BmobFile *file in array){
                [self.imagesURL addObject:file.url];
            }
            if([self.title isEqualToString:@"发表影评"]||[self.title isEqualToString:@"转发"]){
                [self uploadRecoder];
            }else{
                [self uploadText];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
        }
    }];
}

//上传语音
-(void)uploadRecoder{
    if(self.recordData == nil){
        [self uploadText];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在上传语音"];
    NSString *filename = [NSString stringWithFormat:@"%@_recorder.mp3",[[BmobUser currentUser] objectForKey:@"nick"]];
    BmobFile *recordFile = [[BmobFile alloc]initWithFileName:filename withFileData:self.recordData];
    [recordFile saveInBackgroundByDataSharding:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            self.recordURl = recordFile.url;
            [self uploadText];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传语音失败"];
        }
        
    }];
    
}

//上传文本
-(void)uploadText{
    [SVProgressHUD showWithStatus:@"正在发表"];
    if([self.title isEqualToString:@"发表影评"]||[self.title isEqualToString:@"转发"]){
        [self.bmobObject setObject:[BmobUser currentUser] forKey:@"User"];
        [self.bmobObject setObject:self.imagesURL forKey:@"ImageURL"];
        [self.bmobObject setObject:self.recordURl forKey:@"RecordURL"];
        [self.bmobObject setObject:self.titleTextView.text forKey:@"Title"];
        [self.bmobObject setObject:self.textView.text forKey:@"Contents"];
        [self.bmobObject setObject:self.recordTime forKey:@"RecordDuration"];
        if([self.title isEqualToString:@"转发"]){
            [self.bmobObject setObject:self.dynamic.bmobObjext forKey:@"Repost"];
            
        }
    }
    else if([self.title isEqualToString:@"发表评论"]) {
        [self.bmobObject setObject:[BmobUser currentUser] forKey:@"User"];
        [self.bmobObject setObject:self.dynamic.user forKey:@"toUser"];
        [self.bmobObject setObject:self.imagesURL forKey:@"ImageURL"];
        [self.bmobObject setObject:self.textView.text forKey:@"Contents"];
        [self.bmobObject setObject:self.dynamic.bmobObjext forKey:@"Source"];
    }
    [self.bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            if([self.title isEqualToString:@"发表评论"]){
                BmobQuery *query = [BmobQuery queryWithClassName:@"Dynamic"];
                [query getObjectInBackgroundWithId:self.dynamic.bmobObjext.objectId block:^(BmobObject *object, NSError *error) {
                    if(!error){
                        [object incrementKey:@"Comments_Num"];
                        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            if (isSuccessful) {
                                self.dynamic.comments_count = @(self.dynamic.comments_count.intValue+1).stringValue;
                                //                        //去触发UserEvent表的改变
                                //                        BmobQuery *bq = [BmobQuery queryWithClassName:@"UserEvent"];
                                //                        [bq whereKey:@"user" equalTo:self.dynamic.user];
                                //                        [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                                //                            if (array.count>0) {
                                //                                BmobObject *obj = [array firstObject];
                                //                                [obj incrementKey:@"unreadcount"];
                                //                                [obj updateInBackground];
                                //                            }
                                //                        }];
                                //                        

                                [self.cz_delegate sendingViewControllerHadSendComment];
                                //发表完成更新监听的表
                                [self sendFinish];
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"转发失败"];
                            }
                        }];
                       
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"发表失败"];
                    }
                }];
            }else if([self.title isEqualToString:@"转发"]){
                
//                [self.dynamic.bmobObjext incrementKey:@"Reposts_Num"];
//                [self.dynamic.bmobObjext setObject:self.dynamic.user forKey:@"User"];
//                [self.dynamic.bmobObjext updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                    if (isSuccessful) {
//                        self.dynamic.reposts_count = @(self.dynamic.reposts_count.intValue+1).stringValue;
//                        [self.cz_delegate sendingViewControllerHadSendRepost];
//                        [self sendFinish];
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:@"转发失败"];
//                        NSLog(@"****%@",[error localizedDescription]);
//                    }
//                }];
                
                BmobQuery *query = [BmobQuery queryWithClassName:@"Dynamic"];
                [query getObjectInBackgroundWithId:self.dynamic.bmobObjext.objectId block:^(BmobObject *object, NSError *error) {
                    if(!error){
                        [object incrementKey:@"Reposts_Num"];
                        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            if (isSuccessful) {
                                self.dynamic.reposts_count = @(self.dynamic.reposts_count.intValue+1).stringValue;
                                [self.cz_delegate sendingViewControllerHadSendRepost];
                                [self sendFinish];
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"转发失败"];
                            }
                        }];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"发表失败"];
                    }
                }];
                
            }
            else{
                [self.cz_delegate sendingViewControllerHadSendDynamic];
                [self sendFinish];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"发表失败"];
        }
    }];
    
}
#pragma mark - 发送完成之后更新newDynamic表
-(void)sendFinish{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD showSuccessWithStatus:@"发表成功"];
//    if([self.title isEqualToString:@"转发"]||[self.title isEqualToString:@"发表影评"]){
//        BmobObject *obj = [BmobObject objectWithClassName:@"newDynamic"];
//        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//            if (isSuccessful) {
//                NSLog(@"插入新数据");
//            }
//        }];
//        [SVProgressHUD showSuccessWithStatus:@"发表成功"];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

@end
