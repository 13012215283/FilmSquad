//
//  CZPersonViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZPersonViewController.h"
#import "CZSendRequestViewController.h"
#import "ToastUtils.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import "ZLCollectionCell.h"

@interface CZPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView  *headBackgroundImageView;
@property (nonatomic,strong) UIImageView  *headImageView;             //头像
@property (nonatomic,strong) UILabel      *nameLabel;                 //名字标签
@property (nonatomic,strong) UIButton     *addFriendButton;           //添加好友
@property (nonatomic,strong) UIToolbar    *bottomToolBar;

@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (nonatomic, strong) NSArray                              *arrDataSources;

@end

@implementation CZPersonViewController
#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kWIDTH*(0.618+0.4))];
        [_tableView.tableHeaderView addSubview: self.headView];
    }
    return _tableView;
}
-(UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kWIDTH*(0.618+0.4))];
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:self.headBackgroundImageView];
        [_headView addSubview:self.headImageView];
        [_headView addSubview:self.nameLabel];

    }
    return _headView;
}
-(UIImageView *)headBackgroundImageView{
    if(!_headBackgroundImageView){
        _headBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kWIDTH*0.618)];
        _headBackgroundImageView.image = [UIImage imageNamed:@"back"];
        [_headBackgroundImageView setContentMode:(UIViewContentModeScaleAspectFill)];
        [_headBackgroundImageView setClipsToBounds:YES];
    }
    return _headBackgroundImageView;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH/3, kWIDTH/3)];
        _headImageView.backgroundColor = [UIColor whiteColor];
        _headImageView.center = CGPointMake(kWIDTH/2,kWIDTH*0.618);
        _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.borderWidth = 3;
        _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [_headImageView sd_setImageWithURL:[self.user objectForKey:@"HeadURL"] placeholderImage:[UIImage imageNamed:@"user"]];
        UITapGestureRecognizer *gestureReconizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionForChangeHeadImage:)];
        [_headImageView addGestureRecognizer:gestureReconizer];
        _headImageView.userInteractionEnabled = YES;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = YuanFont(20);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = [self.user objectForKey:@"Nick"];
    }
    return _nameLabel;
}
-(UIToolbar*)bottomToolBar{
    if(!_bottomToolBar){
        _bottomToolBar = [[UIToolbar alloc]init];
        [_bottomToolBar addSubview:self.addFriendButton];
        _bottomToolBar.hidden =  [self checkUserIsCurrenUser] || [self isFriendForUser];
        _bottomToolBar.barStyle = UIBarStyleBlack;
        [self.view addSubview:_bottomToolBar];
    }
    return _bottomToolBar;
}
-(UIButton *)addFriendButton{
    if(!_addFriendButton){
        _addFriendButton = [[UIButton alloc]init];
        [_addFriendButton setTitle:@"申请好友" forState:(UIControlStateNormal)];
        [_addFriendButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_addFriendButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        _addFriendButton.titleLabel.font      = YuanFont(16);
        [_addFriendButton addTarget:self action:@selector(addFriend:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addFriendButton;
}
#pragma mark - 判断用户是否是好友
-(BOOL)isFriendForUser{
    return NO;
}
#pragma mark - 控件方法
//添加好友
-(void)addFriend:(UIButton*)sender{
    CZSendRequestViewController *sendRequestViewContoller = [[CZSendRequestViewController alloc]init];
    sendRequestViewContoller.user = self.user;
    [self.navigationController pushViewController:sendRequestViewContoller animated:YES];
}
//换头像
-(void)actionForChangeHeadImage:(UITapGestureRecognizer*)reconizer{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount      = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount     = 20;
    
    [actionSheet showWithSender:self animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        
        self.arrDataSources = selectPhotos;
        self.lastSelectMoldels = [selectPhotoModels mutableCopy];
        
        NSMutableArray<NSDictionary*> *allImageDic = [[NSMutableArray alloc]init];
        NSData *data = UIImageJPEGRepresentation([selectPhotos firstObject], 1.0);
        NSString *filename = [NSString stringWithFormat:@"%@_image_head.jpg",[self.user objectForKey:@"Nick"]];
        NSDictionary *dic = @{@"filename":filename,@"data":data};
        [allImageDic addObject:dic];
        [BmobFile filesUploadBatchWithDataArray:allImageDic progressBlock:^(int index, float progress) {
            [SVProgressHUD showProgress:progress status:@"正在设置头像"];
            
        } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                BmobFile *file = [array firstObject];
                BmobUser *user = self.user;
                [user setObject:file.url forKey:@"HeadURL"];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if(isSuccessful){
                        [SVProgressHUD showSuccessWithStatus:@"头像设置成功"];
                        self.headImageView.image = [selectPhotos firstObject];
                        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                        [center postNotificationName:@"changHeadImage" object:self userInfo:@{@"image":self.headImageView.image}];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"登录超时，请退出账号重新登录"];
                    }
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"头像设置失败"];
            }
        }];
    }];

}

#pragma mark - 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag = self.hideNavigationButtonItem? 0 : 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人";
    //添加tableView
    [self.view addSubview:self.tableView];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"personCell"];
    
    [self masonry];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - masonry 布局
-(void)masonry{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headImageView);
        make.top.equalTo(self.headImageView.mas_bottom);
        make.height.equalTo(self.headImageView).multipliedBy(0.25);
    }];
    
    [self.bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.addFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomToolBar);
    }];
}
#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - 检查当前页面的用户信息，是否是当前用户的好友或自己本身
-(BOOL)checkUserIsCurrenUser{
    return [self.user.objectId isEqualToString:[BmobUser currentUser].objectId] ? YES : NO;
}
-(BOOL)checkUserIsFriend{
    NSArray *friendsId = [[BmobUser currentUser] objectForKey:@"FriendsId"];
    return [friendsId containsObject:self.user.objectId] ? YES : NO;
}


@end
