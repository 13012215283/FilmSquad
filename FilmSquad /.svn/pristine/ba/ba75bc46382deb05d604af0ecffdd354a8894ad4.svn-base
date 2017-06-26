//
//  CZDynamicDetailViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZDynamicDetailViewController.h"
#import "CZ_DynamicCell.h"
#import "CZSendingViewController.h"
#import "DynamicFrame.h"
#import "Comment.h"
#import "Repost.h"
#import "UserInformation.h"
#import <UIImageView+AFNetworking.h>

#define ZanCellHeight 44

@interface CZDynamicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CZSendingViewControllerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *buttonBar;
@property(nonatomic,strong)UIView *separatView;    //底部转发button
@property(nonatomic,strong)UIButton *zanButton;    //底部赞button
@property(nonatomic,strong)UIButton *commentButton;//底部评论button

@property(nonatomic,strong)UIButton *topRepostButton;  //切换转发页面按钮
@property(nonatomic,strong)UIButton *topZanButton;     //切换赞页面按钮
@property(nonatomic,strong)UIButton *topCommentButton; //切换评论页面按钮
@property(nonatomic,strong)UILabel *topRepostLabel;
@property(nonatomic,strong)UILabel *topCommentLabel;
@property(nonatomic,strong)UILabel *topZanLabel;
@property(nonatomic,strong)UIView *sectionHeaderView;
@property(nonatomic,strong)NSMutableArray<UILabel*> *topLabels;

@property(nonatomic,strong)UIButton *repostButton;
@property(nonatomic,strong)UIView *bottomSeparatView;
@property(nonatomic,strong)UIView *bottomSeparatView2;
@property(nonatomic,strong)UIView *scrollBottomView;  //label底部滚动图


@property(nonatomic,strong) NSMutableArray<DynamicFrame*> *allCommentFrame; //评论Frame模型数据数组
@property(nonatomic,strong) NSMutableArray<DynamicFrame*> *allRepostFrame;  //转发Frame模型数据数组
@property(nonatomic,strong) NSMutableArray<DynamicFrame*> *allZanFrame;     //点赞Frame模型数据数组

@property(nonatomic,assign) CGFloat footHeight;
@property(nonatomic,assign) CGFloat lastLocation;



@end

@implementation CZDynamicDetailViewController

#pragma mark - 懒加载

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-64-kWIDTH/10)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.tag = 2;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSMutableArray<UILabel *> *)topLabels{
    if(!_topLabels){
        _topLabels = [[NSMutableArray alloc]init];
    }
    return _topLabels;
}
//分割线
-(UIView *)separatView{
    if(!_separatView){
        _separatView = [[UIView alloc]initWithFrame:CGRectZero];
        _separatView.backgroundColor = [UIColor lightGrayColor];
        [self.buttonBar addSubview:self.separatView];
    }
    return _separatView;
}
//底部Bar
-(UIView *)buttonBar{
    if(!_buttonBar){
        _buttonBar = [[UIView alloc]initWithFrame:CGRectZero];
        _buttonBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_buttonBar];
    }
    return _buttonBar;
}
//赞按钮
-(UIButton *)zanButton{
    if(!_zanButton){
        _zanButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_zanButton setImage:[UIImage imageNamed:self.dynamicFrame.dynamic.isZan?@"zan_pressed":@"zan_normal"] forState:UIControlStateNormal];
        _zanButton.tintColor = [UIColor blueColor];
        [self.buttonBar addSubview:_zanButton];
        
        [_zanButton setTitle:@"赞" forState:(UIControlStateNormal)];
        [_zanButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [_zanButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        _zanButton.titleLabel.font = YuanFont(12);
        
        [_zanButton addTarget:self action:@selector(acitonForZanButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _zanButton;
}
//评论按钮
-(UIButton *)commentButton{
    if(!_commentButton){
        _commentButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_commentButton setImage:[UIImage imageNamed:@"comment_normal"] forState:(UIControlStateNormal)];
        [_commentButton setImage:[UIImage imageNamed:@"comment_pressed"] forState:(UIControlStateHighlighted)];
        [_commentButton addTarget:self action:@selector(actionForComment:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_commentButton setTitle:@"评论" forState:(UIControlStateNormal)];
        [_commentButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [_commentButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        _commentButton.titleLabel.font = YuanFont(12);
        [self.buttonBar addSubview:_commentButton];
    }
    return _commentButton;
}
//转发按钮
-(UIButton *)repostButton{
    if(!_repostButton){
        _repostButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_repostButton setImage:[UIImage imageNamed:@"share_normal"] forState:(UIControlStateNormal)];
         [_repostButton setImage:[UIImage imageNamed:@"share_pressed"] forState:(UIControlStateHighlighted)];
        [self.buttonBar addSubview:_repostButton];
        [_repostButton addTarget:self action:@selector(acitonForRepostButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_repostButton setTitle:@"评论" forState:(UIControlStateNormal)];
        [_repostButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [_repostButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        _repostButton.titleLabel.font = YuanFont(12);
    }
    return _repostButton;
}
//切换转发页面按钮
-(UIButton *)topRepostButton{
    if(!_topRepostButton){
        _topRepostButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _topRepostButton.tag = 1;
        [_topRepostButton addTarget:self action:@selector(actionForTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
        self.topRepostLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.topRepostLabel.textAlignment = NSTextAlignmentCenter;
        self.topRepostLabel.font = YuanFont(14);
        self.topRepostLabel.textColor = [UIColor lightGrayColor];
        self.topRepostLabel.text = [NSString stringWithFormat:@"%@ %@ ",@"转发",(self.dynamicFrame.dynamic.reposts_count==nil)?@"0":self.dynamicFrame.dynamic.reposts_count];
        ;
        [_topRepostButton addSubview:self.topRepostLabel];
    }
    return _topRepostButton;
}
//切换评论页面按钮
-(UIButton *)topCommentButton{
    if(!_topCommentButton){
        _topCommentButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _topCommentButton.tag = 2;
        [_topCommentButton addTarget:self action:@selector(actionForTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
        self.topCommentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.topCommentLabel.textAlignment = NSTextAlignmentCenter;
        self.topCommentLabel.font = YuanFont(14);
        self.topCommentLabel.textColor = [UIColor blackColor];
        self.topCommentLabel.text = self.topCommentLabel.text = [NSString stringWithFormat:@"%@ %@ ",@"评论",(self.dynamicFrame.dynamic.comments_count==nil)?@"0":self.dynamicFrame.dynamic.comments_count];
        [_topCommentButton addSubview:self.topCommentLabel];
    }
    return _topCommentButton;
}
//切换点赞页面按钮
-(UIButton *)topZanButton{
    if(!_topZanButton){
        _topZanButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _topZanButton.tag = 3;
        [_topZanButton addTarget:self action:@selector(actionForTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
        self.topZanLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.topZanLabel.textAlignment = NSTextAlignmentCenter;
        self.topZanLabel.font = YuanFont(14);
        self.topZanLabel.textColor = [UIColor lightGrayColor];
        self.topZanLabel.text =  [NSString stringWithFormat:@"%@ %@ ",@"赞",(self.dynamicFrame.dynamic.zan_count==nil)?@"0":self.dynamicFrame.dynamic.zan_count];
        [_topZanButton addSubview:self.topZanLabel];
        
    }
    return _topZanButton;
}
//label底部滚动图
-(UIView *)scrollBottomView{
    if(!_scrollBottomView){
        _scrollBottomView = [[UIView alloc]initWithFrame:CGRectZero];
        _scrollBottomView.backgroundColor = [UIColor blackColor];
    }
    return _scrollBottomView;
}
//分割线
-(UIView *)bottomSeparatView{
    if(!_bottomSeparatView){
        _bottomSeparatView = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomSeparatView.backgroundColor = [UIColor lightGrayColor];
        [self.buttonBar addSubview:_bottomSeparatView];
    }
    return _bottomSeparatView;
}
//分割线
-(UIView *)bottomSeparatView2{
    if(!_bottomSeparatView2){
        _bottomSeparatView2 = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomSeparatView2.backgroundColor = [UIColor lightGrayColor];
        [self.buttonBar addSubview:_bottomSeparatView2];
    }
    return _bottomSeparatView2;
}

#pragma mark - 通过dynamic数组获得dynamiFrame数组
-(NSArray *)getAllDynamicFrameArrayFromArray:(NSArray<Dynamic *> *)array{
    NSMutableArray *allDynamicF = [[NSMutableArray alloc]init];
    for(Dynamic *dynamic in array){
        DynamicFrame *dynamicF = [self getDynamicFrameWithDynamic:dynamic];
        [allDynamicF addObject:dynamicF];
    }
    return allDynamicF;
}

#pragma mark - 得到DynamicFrame，自定义评论转发Cell
//自定义评论转发Cell
-(DynamicFrame*)getDynamicFrameWithDynamic:(Dynamic*)dynamic{
    DynamicFrame *dynamicF = [[DynamicFrame alloc]init];
    if([dynamic isMemberOfClass:[Comment class]]||[dynamic isMemberOfClass:[Repost class]]){
        dynamicF.bottomBarHidden = YES;     //隐藏底部bar
        dynamicF.bottomPaddingHidden = YES;
        dynamicF.divCount = 6;              //设置图片大小参数，默认为3
        //设置frame
        dynamicF.dynamic = dynamic;
        
        //自定义更新frame
        CGRect frame ;
        frame =  dynamicF.topSeparatViewF;
        frame.size.height = 0;
        dynamicF.topSeparatViewF = frame;
        
        frame = dynamicF.textViewF;
        frame.origin.x = dynamicF.nameLabelF.origin.x;
        frame.size.width -= frame.origin.x;
        dynamicF.textViewF = frame;
        
        frame = dynamicF.photosViewF;
        frame.origin.x = dynamicF.nameLabelF.origin.x;
        frame.size.width -= frame.origin.x;
        dynamicF.photosViewF = frame;
        
        frame = dynamicF.bottomSeparatViewF;
        frame.origin.x = dynamicF.nameLabelF.origin.x;
        dynamicF.bottomSeparatViewF = frame;
        
    }else if([dynamic isMemberOfClass:[UserInformation class]]){
        dynamicF.bottomBarHidden = YES;     //隐藏底部bar
        dynamicF.bottomPaddingHidden = YES;
        //设置frame
        dynamicF.dynamic = dynamic;
        
        CGRect frame ;
        
        frame =  dynamicF.topSeparatViewF;
        frame.size.height = 0;
        dynamicF.topSeparatViewF = frame;
        
        frame = dynamicF.nameLabelF;
        frame.size.height = dynamicF.headerImageViewF.size.height;
        dynamicF.nameLabelF = frame;
        
        frame = dynamicF.bottomSeparatViewF;
        frame.origin.x = dynamicF.nameLabelF.origin.x;
        dynamicF.bottomSeparatViewF = frame;

    }else{
        if(self.dynamicFrame.dynamic.recordURL == nil){
            dynamicF.bottomBarHidden = YES;
        }
        dynamicF.dynamic = dynamic;
        //自定义更新frame
        dynamicF.repostControlF = CGRectZero;
        dynamicF.commentContolF = CGRectZero;
        dynamicF.zanControlF = CGRectZero;
        
    }
    return dynamicF;
}


#pragma mark - 控件方法
//切换转发，评论，赞页面
-(void)actionForTopButton:(UIButton*)sender{
    self.topRepostLabel.textColor = [UIColor lightGrayColor];
    self.topCommentLabel.textColor = [UIColor lightGrayColor];
    self.topZanLabel.textColor = [UIColor lightGrayColor];
    switch (sender.tag) {
        case 1:   //转发
            self.tableView.tag = 1;
            self.topRepostLabel.textColor = [UIColor blackColor];
            [self updateScrollBottomViewFromLabel:self.topRepostButton];
            
            
            
            
            break;
        case 2:   //评论
            self.tableView.tag = 2;
            self.topCommentLabel.textColor = [UIColor blackColor];
            [self updateScrollBottomViewFromLabel:self.topCommentButton];
            
            
            
            
            
            break;
        case 3:   //赞
            self.tableView.tag = 3;
            self.topZanLabel.textColor = [UIColor blackColor];
            [self updateScrollBottomViewFromLabel:self.topZanButton];
            
            break;
        default:
            break;
    }
}
//发表评论
-(void)actionForComment:(UIButton*)sender{
    CZSendingViewController *sendViewcontroller = [[CZSendingViewController alloc]init];
    sendViewcontroller.title = @"发表评论";
    sendViewcontroller.dynamic = self.dynamicFrame.dynamic;
    sendViewcontroller.cz_delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:sendViewcontroller];
    [self presentViewController:navigationController animated:YES completion:nil];
}
//转发
-(void)acitonForRepostButton:(UIButton*)sender{
    CZSendingViewController *sendViewcontroller = [[CZSendingViewController alloc]init];
    sendViewcontroller.title = @"转发";
    if(self.dynamicFrame.dynamic.reposts_status){
        sendViewcontroller.dynamic = self.dynamicFrame.dynamic.reposts_status;
    }else{
        sendViewcontroller.dynamic = self.dynamicFrame.dynamic;
    }
    sendViewcontroller.cz_delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:sendViewcontroller];
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)acitonForZanButton:(UIButton*)sender{
    NSMutableArray<NSString*> *zanList = self.dynamicFrame.dynamic.zanList;
    if(zanList == nil){
        zanList = [[NSMutableArray alloc]init];
    }
    BmobObject *object = self.dynamicFrame.dynamic.bmobObjext;
    if(self.dynamicFrame.dynamic.isZan == YES){
        self.dynamicFrame.dynamic.zan_count = @(self.dynamicFrame.dynamic.zan_count.intValue-1).stringValue;
        self.topZanLabel.text = [NSString stringWithFormat:@"赞 %@",self.dynamicFrame.dynamic.zan_count];
        [self.zanButton setImage:[UIImage imageNamed:@"zan_normal"] forState:(UIControlStateNormal)];
        self.dynamicFrame.dynamic.isZan = NO;
        
        [zanList removeObject:[BmobUser currentUser].objectId];
        [object setObject:zanList forKey:@"ZanList"];
        [object setObject:self.dynamicFrame.dynamic.user forKey:@"User"];
        if(self.dynamicFrame.dynamic.reposts_status){
            [object setObject:self.dynamicFrame.dynamic.reposts_status.bmobObjext forKey:@"Repost"];
        }
        [object decrementKey:@"Zan_Num"];
        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(!isSuccessful){
                self.dynamicFrame.dynamic.isZan = YES;
                self.dynamicFrame.dynamic.zan_count = @(self.dynamicFrame.dynamic.zan_count.intValue+1).stringValue;
                self.topZanLabel.text = [NSString stringWithFormat:@"赞 %@",self.dynamicFrame.dynamic.zan_count];
                [self.zanButton setImage:[UIImage imageNamed:@"zan_pressed"] forState:(UIControlStateNormal)];
            }
        }];
    }else{
        self.dynamicFrame.dynamic.isZan = YES;
        self.dynamicFrame.dynamic.zan_count = @(self.dynamicFrame.dynamic.zan_count.intValue+1).stringValue;
        self.topZanLabel.text = [NSString stringWithFormat:@"赞 %@",self.dynamicFrame.dynamic.zan_count];
        [self.zanButton setImage:[UIImage imageNamed:@"zan_pressed"] forState:(UIControlStateNormal)];
        
        [zanList addObject:[BmobUser currentUser].objectId];
        [object setObject:zanList forKey:@"ZanList"];
        [object setObject:self.dynamicFrame.dynamic.user forKey:@"User"];
        if(self.dynamicFrame.dynamic.reposts_status){
            [object setObject:self.dynamicFrame.dynamic.reposts_status.bmobObjext forKey:@"Repost"];
        }
        
        [object incrementKey:@"Zan_Num"];
        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(!isSuccessful){
                self.dynamicFrame.dynamic.zan_count = @(self.dynamicFrame.dynamic.zan_count.intValue-1).stringValue;
                self.topZanLabel.text = [NSString stringWithFormat:@"赞 %@",self.dynamicFrame.dynamic.zan_count];
                [self.zanButton setImage:[UIImage imageNamed:@"zan_normal"] forState:(UIControlStateNormal)];
                self.dynamicFrame.dynamic.isZan = NO;
            }
        }];
    }

}

//返回页面
-(void)returnAction:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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

    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.shadowImage = [[UINavigationBar alloc]init].shadowImage;
    self.title = @"详情";
    
    [self setupUI];
    [self.tableView registerClass:[CZ_DynamicCell class] forCellReuseIdentifier:@"dynamicCell"];
    if(self.isComment){
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0,kHEIGHT-64-kWIDTH*0.2, 0);
        [self setupTableViewContentOffset];
    }
    [self requestData];
    
}
#pragma mark - 从本地获取信息，若没有则触发下拉刷新
-(void)requestData{
    NSLog(@"文件目录:%@",NSHomeDirectory());
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/AllDynamic"];
    //获所有动态的详情文件夹
    NSString *dynamicDetailPath = [documentPath stringByAppendingPathComponent:self.dynamicFrame.dynamic.bmobObjext.objectId];
    NSString *allRepostFramePath = [dynamicDetailPath stringByAppendingString:@"/AllRepost"];
    NSString *allCommentFramePath = [dynamicDetailPath stringByAppendingString:@"/AllCommentFrame"];
    NSString *allZanFramePath = [dynamicDetailPath stringByAppendingString:@"/AllZanFrame "];
    self.allRepostFrame  = [NSKeyedUnarchiver unarchiveObjectWithFile:allRepostFramePath];
    self.allCommentFrame = [NSKeyedUnarchiver unarchiveObjectWithFile:allCommentFramePath];
    self.allZanFrame     = [NSKeyedUnarchiver unarchiveObjectWithFile:allZanFramePath];
    if(!self.allRepostFrame || !self.allCommentFrame || !self.allZanFrame){
        [self.tableView triggerPullToRefresh];
    }else{
        [self setuoTableViewContentInset]; // 设置setContentOffset
        [self.tableView reloadData];
    }
}

#pragma mark - 设置界面,下拉上拉刷新请求数据
-(void)setupUI{
    self.view.tag = -1;
    //设置背景
    UIImageView *imageView = [Utils glassImageViewWithImage:nil andAlpha:kGlassAlpha];
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = kWhiteColor;
    [self masonry];
    
    
#define LimitCout 20   //请求数量
    //获取沙箱根目录
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/AllDynamic"];
    //获所有动态的文件夹，不存在则创建
    NSString *filePath = [documentPath stringByAppendingPathComponent:self.dynamicFrame.dynamic.bmobObjext.objectId];
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    //添加下拉刷新
    __block CZDynamicDetailViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        BmobQuery *query = [BmobQuery queryWithClassName:@"Dynamic"];
        [query whereKey:@"Repost" equalTo:weakSelf.dynamicFrame.dynamic.bmobObjext];
        [query orderByDescending:@"createdAt"];
        [query includeKey:@"User"];
        query.limit = LimitCout;
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            weakSelf.allRepostFrame = [[weakSelf getAllDynamicFrameArrayFromArray:[Repost getAllRepostArrayFromArray:array]] mutableCopy];
            //归档
            NSString *allRepostFramePath = [filePath stringByAppendingString:@"/AllRepost"];
            [NSKeyedArchiver archiveRootObject:weakSelf.allRepostFrame toFile:allRepostFramePath];
            // 设置setContentOffset
            [weakSelf setuoTableViewContentInset];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
        
        BmobQuery *query2 = [BmobQuery queryWithClassName:@"Comment"];
        [query2 whereKey:@"Source" equalTo:weakSelf.dynamicFrame.dynamic.bmobObjext];
        [query2 orderByDescending:@"createdAt"];
        [query2 includeKey:@"User"];
        query2.limit = LimitCout;
        [query2 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            weakSelf.allCommentFrame = [[weakSelf getAllDynamicFrameArrayFromArray:[Comment getAllCommentArrayFromArray:array]] mutableCopy];
            //归档
            NSString *allCommentFramePath = [filePath stringByAppendingString:@"/AllCommentFrame"];
            [NSKeyedArchiver archiveRootObject:weakSelf.allCommentFrame toFile:allCommentFramePath];
            [weakSelf setuoTableViewContentInset]; // 设置setContentOffset
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
        
        BmobQuery *query3 = [BmobQuery queryForUser];
        [query3 whereKey:@"objectId" containedIn:weakSelf.dynamicFrame.dynamic.zanList];
        [query3 orderByDescending:@"updatedAt"];
        query3.limit = LimitCout;
        [query3 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            weakSelf.allZanFrame = [[weakSelf getAllDynamicFrameArrayFromArray:[UserInformation getAllZanUserArrayFromArray:array]] mutableCopy];
            //归档
            NSString *allZanFramePath = [filePath stringByAppendingString:@"/AllZanFrame "];
            [NSKeyedArchiver archiveRootObject:weakSelf.allZanFrame toFile:allZanFramePath];
            [weakSelf setuoTableViewContentInset]; // 设置setContentOffset
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.pullToRefreshView stopAnimating];

            
        }];
        
    }];
    //添加上拉刷新
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        switch (weakSelf.tableView.tag) {
            case 1: //请求转发数据
            {
                BmobQuery *query = [BmobQuery queryWithClassName:@"Dynamic"];
                [query whereKey:@"Repost" equalTo:weakSelf.dynamicFrame.dynamic.bmobObjext];
                [query orderByDescending:@"createdAt"];
                [query includeKey:@"User"];
                query.limit = LimitCout;
                if(weakSelf.allRepostFrame.count !=0){
                    query.skip = weakSelf.allRepostFrame.count;
                }
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    NSArray *addRepost = [Repost getAllRepostArrayFromArray:array];
                    
                    [weakSelf.allRepostFrame addObjectsFromArray:[weakSelf getAllDynamicFrameArrayFromArray:addRepost]];
                    [weakSelf setuoTableViewContentInset]; // 设置setContentOffset
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.infiniteScrollingView stopAnimating];
                }];
            }
                break;
            case 2:  //请求评论数据
            {
                BmobQuery *query = [BmobQuery queryWithClassName:@"Comment"];
                [query whereKey:@"Source" equalTo:weakSelf.dynamicFrame.dynamic.bmobObjext];
                [query orderByDescending:@"createdAt"];
                [query includeKey:@"User"];
                query.limit = LimitCout;
                if(weakSelf.allCommentFrame.count !=0){
                    query.skip = weakSelf.allCommentFrame.count;
                }
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    NSArray *addComments = [Comment getAllCommentArrayFromArray:array];
                    [weakSelf.allCommentFrame addObjectsFromArray:[weakSelf getAllDynamicFrameArrayFromArray:addComments]];
                    [weakSelf setuoTableViewContentInset]; // 设置setContentOffset
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.infiniteScrollingView stopAnimating];
                }];
            }
                break;
            case 3:
            {
                BmobQuery *query = [BmobQuery queryForUser];
                [query whereKey:@"objectId" containedIn:weakSelf.dynamicFrame.dynamic.zanList];
                [query orderByDescending:@"updatedAt"];
                query.limit = LimitCout;
                if(weakSelf.allZanFrame.count!=0){
                    query.skip = weakSelf.allZanFrame.count;
                }
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    NSArray *addZan = [UserInformation getAllZanUserArrayFromArray:array];
                    [weakSelf.allZanFrame addObjectsFromArray:[weakSelf getAllDynamicFrameArrayFromArray:addZan]];
                    [weakSelf setuoTableViewContentInset]; // 设置setContentOffset
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.infiniteScrollingView stopAnimating];

                }];
                
                
                
            }
                break;
                
            default:
                break;
        }
    }];
}


#pragma mark - 根据label内容得到新的宽度
-(CGFloat)getNewWidthFromLabel:(UILabel*)label{
    NSString *text = label.text;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
    
}
#pragma mark - 选择页面ScrollBottomView更新位置
-(void)updateScrollBottomViewFromLabel:(UIButton*)buttom{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.scrollBottomView.frame;
        frame.size.width = buttom.frame.size.width;
        frame.origin.x = buttom.frame.origin.x;
        self.scrollBottomView.frame = frame;
    } completion:^(BOOL finished) {
        [self setuoTableViewContentInset];
        [self.tableView reloadData];
    }];
}
#pragma mark - 设置setContentInset
-(void)setuoTableViewContentInset{
    if(!self.allCommentFrame.count&&self.isComment){
        self.isComment = NO;
        return;
    }
    CGFloat totalHeight = 0;
    switch (self.tableView.tag) {
        case 1: //转发
        {
            for(DynamicFrame *dynamicF in self.allRepostFrame){
                totalHeight += [dynamicF getTotalHeight];
            }
        }
            break;
        case 2:  //评论
        {
            for(DynamicFrame *dynamicF in self.allCommentFrame){
                totalHeight += [dynamicF getTotalHeight];
            }
        }
            break;
        case 3: //赞
            for(DynamicFrame *dynamicF in self.allZanFrame){
                totalHeight += [dynamicF getTotalHeight];
            }

            break;
        default:
            break;
    }
    CGFloat contenHeight = (kHEIGHT-64-kWIDTH*0.2)>totalHeight?(kHEIGHT-64-kWIDTH*0.2)-totalHeight:0;
    self.lastLocation = self.tableView.contentOffset.y;    //记录位置
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, contenHeight, 0)];
    self.footHeight = contenHeight;
    [self setupTableViewContentOffset];
    
}
#pragma mark - 设置setContentOffset
-(void)setupTableViewContentOffset{
    if(self.isComment){
        CGFloat dynamicHeight = 0;
        DynamicFrame *dynamicF = [self getDynamicFrameWithDynamic:self.dynamicFrame.dynamic];
        dynamicHeight += [dynamicF getTotalHeight];
        [self.tableView setContentOffset:CGPointMake(0, dynamicHeight)];
        self.isComment = NO;
        return;
    }
    [self.tableView setContentOffset:CGPointMake(0, self.lastLocation)];
}



#pragma mark - masonry布局
-(void)masonry{
    [self.buttonBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.1);
        make.bottom.equalTo(self.view);
    }];
    [self.separatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonBar);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    [self.repostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buttonBar);
        make.top.bottom.equalTo(self.buttonBar);
        make.width.equalTo(self.buttonBar.mas_width).multipliedBy(1.0/3);
        make.height.equalTo(self.buttonBar);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.repostButton.mas_right);
        make.top.bottom.equalTo(self.buttonBar);
        make.width.height.equalTo(self.repostButton);
    }];
    [self.zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentButton.mas_right);
        make.top.bottom.equalTo(self.buttonBar);
        make.width.height.equalTo(self.repostButton);
    }];
    [self.bottomSeparatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.repostButton.mas_right);
        make.width.mas_equalTo(1);
        make.centerY.equalTo(self.commentButton.mas_centerY);
        make.height.equalTo(self.buttonBar.mas_height).multipliedBy(0.6);
    }];
    [self.bottomSeparatView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentButton.mas_right);
        make.width.mas_equalTo(1);
        make.centerY.equalTo(self.commentButton.mas_centerY);
        make.height.equalTo(self.buttonBar.mas_height).multipliedBy(0.6);
    }];
}
#pragma mark - SendingViewControllerDelegate
-(void)sendingViewControllerHadSendComment{
    [self actionForTopButton:self.topCommentButton];
    [self.tableView triggerPullToRefresh];
}
-(void)sendingViewControllerHadSendRepost{
    [self actionForTopButton:self.topRepostButton];
    [self.tableView triggerPullToRefresh];

}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (tableView.tag) {
        case 1:
        {
            self.topRepostLabel.text = [NSString stringWithFormat:@"%@ %@ ",@"转发",(self.dynamicFrame.dynamic.reposts_count==nil)?@"0":self.dynamicFrame.dynamic.reposts_count];
            
            [self.topRepostButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self getNewWidthFromLabel:self.topRepostLabel]);
            }];
            [self.topRepostLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.top.equalTo(self.topRepostButton);
            }];
        }
            break;
        case 2:
        {
            self.topCommentLabel.text = [NSString stringWithFormat:@"%@ %@ ",@"评论",(self.dynamicFrame.dynamic.comments_count==nil)?@"0":self.dynamicFrame.dynamic.comments_count];
            
            
            [self.topCommentButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self getNewWidthFromLabel:self.topCommentLabel]);
            }];
            [self.topCommentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.top.equalTo(self.topCommentButton);
            }];
        }
            break;
        case 3:
        {
            self.topZanLabel.text = [NSString stringWithFormat:@"%@ %@ ",@"赞",(self.dynamicFrame.dynamic.zan_count==nil)?@"0":self.dynamicFrame.dynamic.zan_count];
            [self.topZanButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([self getNewWidthFromLabel:self.topZanLabel]);
            }];
            [self.topZanLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.top.equalTo(self.topZanButton);
            }];
        }
            break;
        default:
            break;
    }
    
    //更新约束
    [self.sectionHeaderView setNeedsUpdateConstraints];
    [self.sectionHeaderView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.sectionHeaderView layoutIfNeeded];
    }];
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }
    switch (tableView.tag) {
        case 1:
            return self.allRepostFrame.count;
            break;
        case 2:
            return self.allCommentFrame.count;
            break;
        case 3:
            return self.allZanFrame.count;
            break;
            
        default:
            break;
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZ_DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0){
        DynamicFrame *dynamicF = [self getDynamicFrameWithDynamic:self.dynamicFrame.dynamic];
        cell.dynamicFrame = dynamicF;
        return cell;
    }
    
    switch (tableView.tag) {
        case 1:   //转发
        {
            
            cell.dynamicFrame = self.allRepostFrame[indexPath.row];
            return cell;
        }
            break;
        case 2:  //评论
        {
            cell.dynamicFrame = self.allCommentFrame[indexPath.row];
            
            return cell;
            
        }
            break;
        case 3: //点赞
        {
            cell.dynamicFrame = self.allZanFrame[indexPath.row];
        }
            break;
            
        default:
            break ;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        CGFloat height = 0;
        DynamicFrame *dynamicF = [self getDynamicFrameWithDynamic:self.dynamicFrame.dynamic];
        height += [dynamicF getTotalHeight];
        return height;
    }
    CGFloat height = 0;
    switch (tableView.tag) {
        case 1: //转发
        {
            height += [self.allRepostFrame[indexPath.row] getTotalHeight];
            break;
        }
        case 2: //评论
        {
            height += [self.allCommentFrame[indexPath.row] getTotalHeight];
            break;
        }
        case 3: //点赞
            height += [self.allZanFrame[indexPath.row] getTotalHeight];
            break;
        default:
            break;
    }
    return height;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
        if(!headerView){
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerView"];
            self.sectionHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
            self.sectionHeaderView.backgroundColor = [UIColor whiteColor];
            [headerView setBackgroundColor:[UIColor whiteColor]];
            UIView *separateView = [[UIView alloc]initWithFrame:CGRectZero];
            separateView.backgroundColor = kWhiteColor;
            [self.sectionHeaderView addSubview:separateView];
            [separateView mas_makeConstraints:^(MASConstraintMaker *make){
                make.bottom.left.right.equalTo(self.sectionHeaderView);
                make.height.mas_equalTo(1);
            }];
            self.sectionHeaderView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:self.sectionHeaderView];
            [self.sectionHeaderView addSubview:self.topRepostButton];
            [self.sectionHeaderView addSubview:self.topCommentButton];
            [self.sectionHeaderView addSubview:self.topZanButton];
            [self.sectionHeaderView addSubview:self.scrollBottomView];
            //masonry
            [self.sectionHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.top.equalTo(headerView);
                make.width.mas_equalTo(kWIDTH);
                make.height.mas_equalTo(kWIDTH/10);
                make.center.equalTo(headerView);
            }];
            [self.topRepostButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.sectionHeaderView);
                make.left.equalTo(self.sectionHeaderView).offset(8);
                make.width.mas_equalTo([self getNewWidthFromLabel:self.topRepostLabel]);
            }];
            [self.topCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.topRepostButton);
                make.left.equalTo(self.topRepostButton.mas_right).offset(16);
                make.width.mas_equalTo([self getNewWidthFromLabel:self.topCommentLabel]);
            }];
            [self.topZanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.topRepostButton);
                make.right.equalTo(self.sectionHeaderView).offset(-8);
                make.width.mas_equalTo([self getNewWidthFromLabel:self.topZanLabel]);
            }];
            [self.topRepostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.left.right.equalTo(self.topRepostButton);
            }];
            [self.topCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.left.right.equalTo(self.topCommentButton);
            }];
            [self.topZanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.left.right.equalTo(self.topZanButton);
            }];
        }
        CGRect frame = self.scrollBottomView.frame;
        switch (tableView.tag) {
            case 1:
            {
                CGRect frame = self.scrollBottomView.frame;
                frame.size.width = self.topRepostButton.frame.size.width;
                frame.origin.x = self.topRepostButton.frame.origin.x;
            }
                break;
            case 2:
            {
                frame.size.width = self.topCommentButton.frame.size.width;
                frame.origin.x = self.topCommentButton.frame.origin.x;
                
            }
                break;
            case 3:
            {
                CGRect frame = self.scrollBottomView.frame;
                frame.size.width = self.topZanButton.frame.size.width;
                frame.origin.x = self.topZanButton.frame.origin.x;
            }
                break;
            default:
                break;
        }
        frame.size.height = 2;
        frame.origin.y = CGRectGetMaxY(self.topRepostButton.frame)-2;
        self.scrollBottomView.frame = frame;
        return headerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return kWIDTH/10;
    }
    return 0;
}
@end
