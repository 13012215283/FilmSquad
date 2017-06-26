//
//  CZNewFriendsViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/13.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZNewFriendsViewController.h"
#import "CZRequestCell.h"
#import "CZAcceptRequestViewController.h"

@interface CZNewFriendsViewController ()<UITableViewDelegate,UITableViewDataSource,CZRequestCellDelegate,CZAcceptRequestViewControllerDelegate>
@property (nonatomic,strong) UITableView    *tableView;

@property (nonatomic,strong) NSMutableArray *allMyRequest;
@property (nonatomic,strong) NSMutableArray *allOtherRequest;

@property (nonatomic,strong) NSArray     *allMyRequestInfo;         //最终用户信息
@property (nonatomic,strong) NSArray     *allOtherRequestInfo;      //最终用户信息

@end

@implementation CZNewFriendsViewController

#pragma mark - 懒加载
-(UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag = 1;
    self.title = @"新的影友";
    [self.tableView registerClass:[CZRequestCell class] forCellReuseIdentifier:@"requestCell"];
    [self getRequestInfo];
}

#pragma mark - 获取信息
-(void)getRequestInfo{
    BmobUser *user = [BmobUser currentUser];
    self.allMyRequest      = [[user objectForKey:@"MyRequest"] mutableCopy];
    self.allOtherRequest   =  [[user objectForKey:@"OtherRequest"] mutableCopy];
    
    NSMutableArray *allMyRequestId    = [[NSMutableArray alloc]init];
    NSMutableArray *allOtherRequestId = [[NSMutableArray alloc]init];
    
    for(NSArray *obj in self.allMyRequest){
        [allMyRequestId addObject:[obj firstObject]];
    }
    for(NSArray *obj in self.allOtherRequest){
        [allOtherRequestId addObject:[obj firstObject]];
    }
    
    BmobQuery *query                 = [BmobQuery queryForUser];
    [query whereKey:@"objectId" containedIn:allMyRequestId];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *allMyRequestUsers = [array mutableCopy];
         self.allMyRequestInfo = [CZUserInfo getUserInfoFromeAllUsers:allMyRequestUsers withObject:self.allMyRequest];
        //查找他人的好友请求
        [self requestOtherRequestInfoFromallOtherRequestId:allOtherRequestId];
    }];
}

#pragma mark - 请求其他人好友请求的数据
-(void)requestOtherRequestInfoFromallOtherRequestId:(NSArray*)allOtherRequestId{
    //查找他人的好友请求
    BmobQuery *query                 = [BmobQuery queryForUser];
    [query whereKey:@"objectId" containedIn:allOtherRequestId];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *allOtherRequestUsers = [array mutableCopy];
        self.allOtherRequestInfo = [CZUserInfo getUserInfoFromeAllUsers:allOtherRequestUsers withObject:self.allOtherRequest];
        //刷新tableView
        [self.tableView reloadData];
    }];
    

}

#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.allRequestUsers.count;
            break;
        case 1:
            return self.allOtherRequestInfo.count;
            break;
        case 2:
            return self.allMyRequestInfo.count;
            break;
        default:
            break;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestCell" forIndexPath:indexPath];

    switch (indexPath.section) {
        case 0:{
            CZRequestUserInfo *requestUserInfo = self.allRequestUsers[indexPath.row];
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:requestUserInfo.headURL] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.requestUser         = requestUserInfo;
            cell.nameLabel.text      = requestUserInfo.name;
            cell.messageLabel.text   = requestUserInfo.requestMessage;
            cell.resultLabel.hidden  = YES;
            cell.refuseButton.hidden = NO;
            cell.acceptButton.hidden = NO;

        }
            break;
        case 1:{
            NSDictionary *dic      = self.allOtherRequestInfo[indexPath.row];
            CZUserInfo   *userInfo = dic[@"userInfo"];
            NSString     *result   = dic[@"result"];
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headURL] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.nameLabel.text      = userInfo.name;
            cell.resultLabel.text    = result;
            cell.refuseButton.hidden = YES;
            cell.acceptButton.hidden = YES;
            cell.resultLabel.hidden  = NO;
        }
            break;
        case 2:{
            NSDictionary *dic      = self.allMyRequestInfo[indexPath.row];
            CZUserInfo   *userInfo = dic[@"userInfo"];
            NSString     *result   = dic[@"result"];
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headURL] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.nameLabel.text      = userInfo.name;
            cell.resultLabel.text    = result;
            cell.refuseButton.hidden = YES;
            cell.acceptButton.hidden = YES;
            cell.resultLabel.hidden  = NO;
        }
            break;
        default:
            break;
    }
    
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    //设置代理
    cell.cz_delegate       = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#define SectionHeaderHeight 30   //单元头的高度
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, SectionHeaderHeight)];
    UILabel *sectionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, SectionHeaderHeight)];
    sectionTitleLabel.font      = YuanFont(14);
    sectionTitleLabel.textColor = [UIColor lightGrayColor];
    [sectionHeaderView addSubview:sectionTitleLabel];
    
    switch (section) {
        case 0:
            sectionTitleLabel.text = @"待处理的好友请求";
            break;
        case 1:
            sectionTitleLabel.text = @"已处理的好友请求";
            break;
        case 2:
            sectionTitleLabel.text = @"我的请求";
            break;
        default:
            break;
    }
    return sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SectionHeaderHeight;
}
#pragma mark - CZRequestCell delegate(同意或拒绝请求的代理)
//同意好友请求
-(void)czRequestCell:(CZRequestCell *)cell acceptRequestFromUser:(CZRequestUserInfo*)requestUser{
    //跳转添加好友页面，选择好友所在的分组和设置好友备注
    CZAcceptRequestViewController *acceptRequestViewController = [[CZAcceptRequestViewController alloc]init];
    acceptRequestViewController.acceptedUser     = requestUser.user;
    acceptRequestViewController.acceptedUserInfo = requestUser;
    acceptRequestViewController.cz_delegate      = self;
    [self.navigationController pushViewController:acceptRequestViewController animated:YES];
}

//拒绝好友请求
-(void)czRequestCell:(CZRequestCell *)cell refuseRequestFromUser:(CZRequestUserInfo *)requestUser{
    [SVProgressHUD showWithStatus:@"正在执行操作"];
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager rejectBuddyRequest:requestUser.user.objectId reason:@"" error:nil];
    if(isSuccess){
        BmobUser *user = [BmobUser currentUser];
        NSMutableArray *allOtherRequest = [[user objectForKey:@"OtherRequest"] mutableCopy];
        NSArray *request = @[requestUser.user.objectId,@"已拒绝"];
        [allOtherRequest addObject:request];
        [user setObject:allOtherRequest forKey:@"OtherRequest"];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                //把拒绝的好友从数组中删除,并刷新tableView
                [self.allRequestUsers removeObject:requestUser];
                [self getRequestInfo];
                [SVProgressHUD showSuccessWithStatus:@"拒绝成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"操作失败，请检查网络"];
            }
        }];

    }
}

#pragma mark - CZAcceptRequestViewControllerDelegate
//添加好友成功
-(void)CZAcceptRequestViewController:(CZAcceptRequestViewController *)Controller HaveFinishedAddUser:(CZRequestUserInfo *)userInfo{
    //把添加的好友从数组中删除,并刷新tableView
    [self.allRequestUsers removeObject:userInfo];
    [self getRequestInfo];
}

@end
