//
//  CZMessagesViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/1.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZMessagesViewController.h"
#import "CZConversationCell.h"
#import "CZUserInfo.h"
#import "CZChattingViewController.h"
#import "CZMainNavigationController.h"
#import <UIViewController+LMSideBarController.h>
@interface CZMessagesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tabelView;
@property(nonatomic,strong) UIToolbar *toolBar;

@property (nonatomic,strong) NSMutableArray<EMConversation*> *conversations;           //所有会话
@property (nonatomic,strong) NSMutableArray<CZUserInfo*>     *converSationUserInfo;    //所有会话对象的用户信息
@property (nonatomic,strong) NSMutableArray<CZUserInfo*>     *allUserInfo;             //所有好友用户信息
@end

@implementation CZMessagesViewController
#pragma mark - 初始化
-(instancetype)init{
    if(self = [super init]){
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFriendsList:) name:@"ReceiveFriendsList" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessageAction:) name:@"ReceiveMessage" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMessagesReaded:) name:@"setMessagesReaded" object:nil];
        
        //获取本地的所有会话
        NSArray *oldConversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
        self.conversations = [oldConversations mutableCopy];
        
    }
    return self;
}
#pragma mark - 收到消息通知方法
-(void)didReceiveMessageAction:(NSNotification*)notification{
    //获取本地的所有会话
    NSArray *oldConversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    self.conversations = [oldConversations mutableCopy];
    self.converSationUserInfo = [[NSMutableArray alloc]init];
    //获取所有会话的用户信息
    for(EMConversation *conversation in self.conversations){
        for(CZUserInfo *userInfo in self.allUserInfo){
            if([conversation.chatter isEqualToString:userInfo.user.objectId]){
                [self.converSationUserInfo addObject:userInfo];
            }
        }
    }
    [self.tabelView reloadData];
}
#pragma mark - 有会话窗口关闭
-(void)setMessagesReaded:(NSNotification*)notification{
    //获取本地的所有会话
    NSArray *oldConversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    self.conversations = [oldConversations mutableCopy];
    self.converSationUserInfo = [[NSMutableArray alloc]init];
    //获取所有会话的用户信息
    for(EMConversation *conversation in self.conversations){
        for(CZUserInfo *userInfo in self.allUserInfo){
            if([conversation.chatter isEqualToString:userInfo.user.objectId]){
                [self.converSationUserInfo addObject:userInfo];
            }
        }
    }
    CZUserInfo *userInfo = notification.object;
    for(EMConversation *conversation in self.conversations){
        if([conversation.chatter isEqualToString:userInfo.user.objectId]){
            [conversation markAllMessagesAsRead:YES];
        }
    }
    [self.tabelView reloadData];
}
#pragma mark - 得到好友列表通知方法
-(void)receiveFriendsList:(NSNotification*)notification{
    self.allUserInfo = [notification.object mutableCopy];
    self.converSationUserInfo = [[NSMutableArray alloc]init];
    //获取所有会话的用户信息
    for(EMConversation *conversation in self.conversations){
        for(CZUserInfo *userInfo in self.allUserInfo){
            if([conversation.chatter isEqualToString:userInfo.user.objectId]){
                [self.converSationUserInfo addObject:userInfo];
            }
        }
    }
    [self.tabelView reloadData];
}
#pragma mark - 懒加载
-(UITableView *)tabelView{
    if(!_tabelView){
        _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH*0.618, kHEIGHT)];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorColor = [UIColor clearColor];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        [_tabelView setSeparatorColor:[UIColor lightGrayColor]];
        _tabelView.tableFooterView = [[UIView alloc]init];
    }
    return _tabelView;
}

-(UIToolbar *)toolBar{
    if(!_toolBar){
        _toolBar = [[UIToolbar alloc]initWithFrame:self.tabelView.frame];
    }
    return _toolBar;
}

-(NSMutableArray<CZUserInfo *> *)converSationUserInfo{
    if(!_converSationUserInfo){
        _converSationUserInfo = [[NSMutableArray alloc]init];
    }
    return _converSationUserInfo;
}

#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.tabelView registerClass:[CZConversationCell class] forCellReuseIdentifier:@"conversationCell"];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.tabelView];
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.converSationUserInfo.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conversationCell" forIndexPath:indexPath];
    cell.conversation = self.conversations[indexPath.row];
    cell.userInfo     = self.converSationUserInfo[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#define HeightForRow 60
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightForRow;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZChattingViewController *chattingViewController = [[CZChattingViewController alloc]init];
    chattingViewController.userInfo                  = self.converSationUserInfo[indexPath.row];
    CZMainNavigationController *mainNavigationController = (CZMainNavigationController*)self.sideBarController.contentViewController;
    [mainNavigationController pushViewController:chattingViewController animated:NO];
    mainNavigationController.navigationBar.hidden   = NO;
    
    [self.conversations[indexPath.row] markAllMessagesAsRead:YES];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    
    [self.tabelView deselectRowAtIndexPath:indexPath animated:NO];
    [self.sideBarController hideMenuViewController:YES];
}
@end
