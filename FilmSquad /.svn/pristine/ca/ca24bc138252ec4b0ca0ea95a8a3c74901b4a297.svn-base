//
//  CZFriendsViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/6.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZFriendsViewController.h"
#import "CZMainNavigationController.h"
#import <UIViewController+LMSideBarController.h>
#import "CZFriendButton.h"
#import "CZFriendSearchViewController.h"
#import "CZAddNewFrendsViewController.h"
#import "CZNewFriendsViewController.h"
#import "CZRequestUserInfo.h"
#import "AppDelegate.h"
#import "CZSectionHeaderView.h"
#import "CZFriendsCell.h"
#import "CZChattingViewController.h"


@interface CZFriendsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,CZSectionHeaderViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView                   *tableView;
@property (nonatomic,strong) CZFriendSearchViewController  *searchController;
@property (nonatomic,strong) UIView                        *headContentView;
@property (nonatomic,strong) UIView                        *headView;
@property (nonatomic,strong) UIScrollView                  *headScrollView;
@property (nonatomic,strong) UIView                        *containerViewForScrollView;
@property (nonatomic,strong) CZFriendButton                *myNewFriendButton;    //新的影友按钮
@property (nonatomic,strong) CZFriendButton                *filmSquadButton;      //小分队按钮
@property (nonatomic,strong) CZFriendButton                *addFriendButton;      //添加影友按钮
@property (nonatomic,strong) UIView *stateBarVew;

@property (nonatomic,strong) NSMutableArray                *squad;                //好友分组
@property (nonatomic,strong) NSMutableArray                *friendsList;          //好友列表

@property (nonatomic,strong) NSMutableArray<CZRequestUserInfo*> *allRequestUsers; //所有好友请求信息
@property (nonatomic,strong) NSMutableDictionary            *allSquadDic;
@property (nonatomic,strong) NSMutableDictionary            *showOrCloseSquad;    //判断是否展开分组
@end

@implementation CZFriendsViewController

#pragma mark - 初始化
-(instancetype)init{
    if(self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRequest:) name:@"request" object:nil];
        //tableView注册cell
        [self.tableView registerClass:[CZFriendsCell class] forCellReuseIdentifier:@"friendCell"];
        [self addPullToRefreshAndRequestData];
        [self.tableView triggerPullToRefresh];  //下拉刷新
    }
    return self;
}

#pragma mark - 好友请求通知监听方法
-(void)newRequest:(NSNotification*)notification{
    NSDictionary *requestInfo = notification.userInfo;
    BmobQuery *query = [BmobQuery queryForUser];
    [query whereKey:@"objectId" equalTo:requestInfo[@"username"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        CZRequestUserInfo *requestUserInfo = [CZRequestUserInfo getRequestUserInfoFromUser:[array firstObject] RequestMessage:requestInfo[@"message"]];
        [self.allRequestUsers addObject:requestUserInfo];
    }];
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headContentView;
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(UIScrollView *)headScrollView{
    if(!_headScrollView){
        _headScrollView = [[UIScrollView alloc]init];
        _headScrollView.showsHorizontalScrollIndicator = NO;
        _headScrollView.showsVerticalScrollIndicator = NO;
        [_headScrollView setAlwaysBounceHorizontal:YES];
        self.containerViewForScrollView = [[UIView alloc]init];
        [self.containerViewForScrollView addSubview:self.newFriendButton];
        [self.containerViewForScrollView addSubview:self.filmSquadButton];
        [self.containerViewForScrollView addSubview:self.addFriendButton];
        
        [_headScrollView addSubview:self.containerViewForScrollView];
    }
    return _headScrollView;
}

#define HeaderViewHeight  kWIDTH/4+44+2
-(UIView*)headContentView{
    if(!_headContentView){
        _headContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, HeaderViewHeight+20)];
        [_headContentView addSubview:self.headView];
        
    }
    return _headContentView;
}

-(UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, HeaderViewHeight)];
        [_headView addSubview:self.headScrollView];
       
        //masonry布局
        [self.headScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.headView);
            make.top.equalTo(self.headView.mas_top).offset(45);
            make.width.equalTo(self.headView);
            make.bottom.equalTo(self.headView).offset(-1);

        }];
        [self.containerViewForScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.headScrollView);
            make.width.equalTo(self.headScrollView);
            make.height.equalTo(self.headScrollView);
        }];
        [self.newFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.containerViewForScrollView);
            make.top.equalTo(self.containerViewForScrollView);
            make.bottom.equalTo(self.containerViewForScrollView);
            make.width.equalTo(self.containerViewForScrollView).multipliedBy(1.0/4);
        }];
        [self.filmSquadButton mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.containerViewForScrollView).offset(kWIDTH/16);
            make.height.width.bottom.top.equalTo(self.newFriendButton);
        }];
        [self.addFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerViewForScrollView).offset(-kWIDTH/16);
            make.width.height.bottom.top.equalTo(self.newFriendButton);
        }];
    }
    return _headView;
}

-(CZFriendButton *)newFriendButton{
    if(!_myNewFriendButton){
        _myNewFriendButton = [[CZFriendButton alloc]init];
        [_myNewFriendButton addTarget:self action:@selector(newFriend:) forControlEvents:(UIControlEventTouchUpInside)];
        [_myNewFriendButton setImage:[UIImage imageNamed:@"newFriend"] forState:(UIControlStateNormal)];
        [_myNewFriendButton setTitle:@"新的影友" forState:(UIControlStateNormal)];
        [_myNewFriendButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_myNewFriendButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        _myNewFriendButton.titleLabel.font = YuanFont(15);
        _myNewFriendButton.titleLabel.textAlignment  = NSTextAlignmentCenter;
    }
    return _myNewFriendButton;
}
-(CZFriendButton *)filmSquadButton{
    if(!_filmSquadButton){
        _filmSquadButton = [[CZFriendButton alloc]init];
        [_filmSquadButton addTarget:self action:@selector(squad:) forControlEvents:(UIControlEventTouchUpInside)];
        [_filmSquadButton setImage:[UIImage imageNamed:@"squad_normal"] forState:(UIControlStateNormal)];
        [_filmSquadButton setTitle:@"小分队" forState:(UIControlStateNormal)];
        [_filmSquadButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_filmSquadButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        _filmSquadButton.titleLabel.textAlignment  = NSTextAlignmentCenter;
        _filmSquadButton.titleLabel.font = YuanFont(15);

    }
    return _filmSquadButton;
}
-(CZFriendButton *)addFriendButton{
    if(!_addFriendButton){
        _addFriendButton = [[CZFriendButton alloc]init];
        [_addFriendButton addTarget:self action:@selector(addFriend:) forControlEvents:(UIControlEventTouchUpInside)];
        [_addFriendButton setImage:[UIImage imageNamed:@"addFriend_normal"] forState:(UIControlStateNormal)];
        [_addFriendButton setTitle:@"添加" forState:(UIControlStateNormal)];
        [_addFriendButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_addFriendButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        _addFriendButton.titleLabel.textAlignment  = NSTextAlignmentCenter;
        _addFriendButton.titleLabel.font = YuanFont(15);
    }
    return _addFriendButton;
}

-(NSMutableArray<CZRequestUserInfo *> *)allRequestUsers{
    if(!_allRequestUsers){
        _allRequestUsers = [[NSMutableArray alloc]init];
    }
    return _allRequestUsers;
}
#pragma mark - 控件方法
-(void)newFriend:(UIButton*)sender{
    CZNewFriendsViewController *newfriendViewController = [[CZNewFriendsViewController alloc]init];
    newfriendViewController.allRequestUsers = self.allRequestUsers;
    [self.navigationController pushViewController:newfriendViewController animated:YES];
}

-(void)squad:(UIButton*)sender{
    
}
-(void)addFriend:(UIButton*)sender{
    CZAddNewFrendsViewController *addFriendViewContoller = [[CZAddNewFrendsViewController alloc]init];
    [self.navigationController pushViewController:addFriendViewContoller animated:YES];
}
#pragma mark - 页面加载
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始搜索栏
    [self initSearchController];
}




#pragma mark - 添加下拉刷新
-(void)addPullToRefreshAndRequestData{
     __block CZFriendsViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        BmobUser *user       = [BmobUser currentUser];
        weakSelf.squad       = [[user objectForKey:@"Squad"] mutableCopy];      //获取分组信息
        weakSelf.friendsList = [[user objectForKey:@"MyFriends"] mutableCopy];  //获取好友列表
        
        //创建所有分组信息的字典
        weakSelf.allSquadDic = [[NSMutableDictionary alloc]init];
        weakSelf.showOrCloseSquad = [[NSMutableDictionary alloc]init];
        for(NSString *squadName in weakSelf.squad){
            NSMutableArray *squadUsers = [[NSMutableArray alloc]init];
            [weakSelf.allSquadDic setObject:squadUsers forKey:squadName];
            [weakSelf.showOrCloseSquad setObject:@"close" forKey:squadName];
        }
        
        //获取所有朋友的objectId
        NSMutableArray *allObjectId = [[NSMutableArray alloc]init];
        for(NSArray *ary in weakSelf.friendsList){
            [allObjectId addObject:[ary firstObject]];
        }
        //获取所有好友的BmobUser信息
        BmobQuery *query = [BmobQuery queryForUser];
        [query whereKey:@"objectId" containedIn:allObjectId];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            NSArray *allFriendsInfo = [CZUserInfo getUserInfoFromeAllFriends:array withFriendsList:weakSelf.friendsList];
            //将所有好友信息分组并存入字典中
            for(CZUserInfo *userInfo in allFriendsInfo){
                [weakSelf.allSquadDic[userInfo.squad] addObject:userInfo];
            }
            [weakSelf.tableView reloadData];
            
          
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            
            //好友列表请求完毕发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveFriendsList" object:allFriendsInfo];
        }];
    }];
}

#pragma mark - 初始化搜索栏
-(void)initSearchController{
    //搜索栏相关  参数为搜索结果的页面 如果给nil在当前页面显示
    self.searchController = [[CZFriendSearchViewController alloc]init];
    //设置结果过滤器
    self.searchController.searchResultsUpdater = self;
    
    //把搜索栏添加到表头
    [self.headView addSubview:self.searchController.searchBar];
    self.searchController.delegate = self;
}
#pragma mark 搜索结果协议
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //得到用户输入的内容
//    NSString *text = searchController.searchBar.text;
}

//搜索栏隐藏的时候
-(void)willDismissSearchController:(UISearchController *)searchController{
    [self.tabBarController.tabBar setHidden:NO];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.statusBarInterceptView.backgroundColor = [UIColor clearColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)didDismissSearchController:(UISearchController *)searchController{
 
}

-(void)willPresentSearchController:(UISearchController *)searchController{
    [self.searchController.searchBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBarController.tabBar setHidden:YES];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    app.statusBarInterceptView.backgroundColor = [UIColor whiteColor];
    
}


#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.squad.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *friends =  self.allSquadDic[self.squad[section]];
    //如果分组的状态是展开，则返回分组的好友数，否则返回0
    return [self.showOrCloseSquad[self.squad[section]] isEqualToString:@"show"]?friends.count:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    //获取分组名
    NSString *squadName = self.squad[indexPath.section];
    //获取分组的所有好友
    NSArray  *friends   = self.allSquadDic[squadName];
    //赋值
    cell.userInfo = friends[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZChattingViewController *chattingViewController = [[CZChattingViewController alloc]init];
    CZFriendsCell *cell = (CZFriendsCell*)[tableView cellForRowAtIndexPath:indexPath];
    chattingViewController.userInfo = cell.userInfo;
    
    CZMainNavigationController *mainNavigationController = (CZMainNavigationController*)self.sideBarController.contentViewController;
    mainNavigationController.navigationBar.hidden   = YES;
    
    [mainNavigationController pushViewController:chattingViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#define SectionHeaderHeight 40
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SectionHeaderHeight;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CZSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeader"];
    if(!sectionHeaderView) {
       sectionHeaderView = [[CZSectionHeaderView alloc]initWithReuseIdentifier:@"sectionHeader"];
    }
    sectionHeaderView.cz_delegate           = self;                 //设置代理
    sectionHeaderView.squadLabel.text       = self.squad[section];
    sectionHeaderView.spreadButton.selected = [self.showOrCloseSquad[self.squad[section]] isEqualToString:@"show"]?YES:NO;
    sectionHeaderView.footerSeperateView.hidden = sectionHeaderView.spreadButton.selected;
    return sectionHeaderView;
}
#define HeightForRow 60
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightForRow;
}

#pragma mark - CZSectionHeaderViewDelegate 
//展开分组
-(void)showSquadContenFromCZSectionHeaderViewt:(CZSectionHeaderView *)headerView{
    //修改分组为展开状态
    NSString *squadName   = headerView.squadLabel.text;
    self.showOrCloseSquad[squadName] = @"show";
    //获取section,并刷新section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[self.squad indexOfObject:squadName]] withRowAnimation:UITableViewRowAnimationFade];
}

//关闭分组
-(void)closeSquadContenFromCZSectionHeaderViewt:(CZSectionHeaderView *)headerView{
    //修改分组为关闭状态
    NSString *squadName   = headerView.squadLabel.text;
    self.showOrCloseSquad[squadName] = @"close";
    //获取section,并刷新section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[self.squad indexOfObject:squadName]] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
}


@end
