//
//  CZAcceptRequestViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/15.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZAcceptRequestViewController.h"
#import "CZRequesInfoCell.h"
#import "CZLeftImageButton.h"
@interface CZAcceptRequestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView      *tableView;

@property (nonatomic,strong) NSMutableArray   *squad;                   //用户所有分组名
@property (nonatomic,copy  ) NSString         *selectedSquad;           //用户选择的分组
@property (nonatomic,copy  ) NSString         *remarkName;              //用户备注名

@property (nonatomic,strong) UIView           *squadHeaderView;         //选择分组
@property (nonatomic,strong) UILabel          *squadLabel;              //分组标签
@property (nonatomic,strong) UILabel          *squadDetailLabel;        //选择的分组标签
@property (nonatomic,strong) UIButton         *spreadButton;            //展开按钮
@property (nonatomic,strong) UIButton         *selectSquadHeaderButton; //点击分组按钮
@property (nonatomic,assign) BOOL              showingSquad;            //是否显示分组

@property (nonatomic,strong) UIView           *containerFooterView;
@property (nonatomic,strong) CZLeftImageButton *addSquadButton;
@end

@implementation CZAcceptRequestViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[CZRequesInfoCell class] forCellReuseIdentifier:@"requestCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
}


-(UIView *)squadHeaderView{
    if(!_squadHeaderView){
        _squadHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
        self.squadLabel               = [[UILabel alloc]init];
        self.squadLabel.text          = @"分组 :";
        self.squadLabel.font          = YuanFont(16);
        self.squadLabel.textColor     = [UIColor grayColor];
        self.squadLabel.textAlignment = NSTextAlignmentLeft;
        
        self.squadDetailLabel         = [[UILabel alloc]init];
        self.squadDetailLabel.font    = YuanFont(16);
        self.squadDetailLabel.textAlignment = NSTextAlignmentCenter;
        self.squadDetailLabel.text    = self.squad.firstObject;
        self.selectedSquad            = self.squad.firstObject;
        
        self.spreadButton = [[UIButton alloc]init];
        [self.spreadButton setImage:[UIImage imageNamed:@"spread"] forState:(UIControlStateNormal)];
        [self.spreadButton setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateSelected)];
        
        self.selectSquadHeaderButton = [[UIButton alloc]init];
        [self.selectSquadHeaderButton addTarget:self action:@selector(spreadSquads:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return _squadHeaderView;
}

-(UIView *)containerFooterView{
    if(!_containerFooterView){
        _containerFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44+20)];
        _containerFooterView.backgroundColor = [UIColor clearColor];
        
        self.addSquadButton                 = [[CZLeftImageButton alloc]init];
        self.addSquadButton.titleLabel.font = YuanFont(16);
        self.addSquadButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.addSquadButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.addSquadButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        [self.addSquadButton setTitle:@"添加小分队" forState:(UIControlStateNormal)];
        [self.addSquadButton setImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
        [self.addSquadButton addTarget:self action:@selector(addSquad:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _containerFooterView;
}

-(NSMutableArray *)squad {
    if(!_squad){
        _squad = (NSMutableArray*)[[[BmobUser currentUser] objectForKey:@"Squad"] mutableCopy];
    }
    return _squad;
}

-(NSString *)remarkName {
    CZRequesInfoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return cell.infoTextView.text;
}
#pragma mark - 页面显示
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title    = @"添加好友";
    self.view.tag = 1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(addFriend:)];
    [self masonry];
}
#pragma mark - masonry
-(void)masonry{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //设置分组的头视图
    [self.squadHeaderView addSubview:self.squadLabel];
    [self.squadHeaderView addSubview:self.squadDetailLabel];
    [self.squadHeaderView addSubview:self.spreadButton];
    [self.squadHeaderView addSubview:self.selectSquadHeaderButton];
    [self.squadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.squadHeaderView).offset(8);
        make.height.equalTo(self.squadHeaderView).offset(-16);
        make.width.equalTo(self.squadHeaderView).multipliedBy(1.0/5);
    }];
    [self.spreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.squadHeaderView).offset(8);
        make.right.equalTo(self.squadHeaderView).offset(-8);
        make.height.width.equalTo(self.squadHeaderView.mas_height).offset(-16);
    }];
    [self.squadDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.squadLabel);
        make.left.equalTo(self.squadHeaderView);
        make.right.equalTo(self.spreadButton.mas_left);
    }];
    [self.selectSquadHeaderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.squadHeaderView);
    }];
    
    //设置分组的尾视图
    [self.containerFooterView addSubview:self.addSquadButton];
    [self.addSquadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerFooterView);
        make.top.equalTo(self.containerFooterView).offset(8);
        make.bottom.equalTo(self.containerFooterView).offset(-8);
    }];
    
}
#pragma mark - 控件方法
-(void)spreadSquads:(UIButton*)sender {
    if(self.showingSquad == NO) {
        self.showingSquad = YES;
        self.spreadButton.selected = YES;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        
        //获取主线程队列，tableView刷新完成之后调用block
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:(UITableViewScrollPositionMiddle) animated:YES];
        });
    }else{
        self.showingSquad = NO;
        self.spreadButton.selected = NO;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)addSquad:(UIButton*)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"创建小分队" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder   = @"请输入小分队名称";
        textField.font          = YuanFont(16);
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *actionDone= [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        BOOL done = YES;
        NSString *squadName = alert.textFields.firstObject.text;
        if(squadName.length == 0){
            [SVProgressHUD showErrorWithStatus:@"名称不能为空"];
            done = NO;
        }
        for(NSString *name in self.squad){
            if([squadName isEqualToString:name]){
                [SVProgressHUD showErrorWithStatus:@"名称重复"];
                done = NO;
            }
        }
        if(done == YES){
            [SVProgressHUD showWithStatus:@"正在创建"];
            [self.squad addObject:squadName];
            BmobUser *user = [BmobUser currentUser];
            [user setObject:self.squad forKey:@"Squad"];
            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if(isSuccessful){
                    [SVProgressHUD showSuccessWithStatus:@"创建成功"];
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                    //获取主线程队列，tableView刷新完成之后调用block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.squad.count-1 inSection:1];
                        [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:(UITableViewScrollPositionMiddle) animated:YES];
                    });
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"创建失败，请检查网络情况"];
                    [self.squad removeObject:squadName];
                }
            }];
        }
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionDone];
    [self presentViewController:alert animated:YES completion:nil];
}

//同意好友申请
-(void)addFriend:(UIBarButtonItem*)sender {
    [SVProgressHUD showWithStatus:@"正在添加"];
    //环信，同意好友申请
    BOOL isSuccessful = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:self.acceptedUser.objectId error:nil];
    if(isSuccessful){
        BmobUser *user = [BmobUser currentUser];
        NSMutableArray *allFriends = [user objectForKey:@"MyFriends"];
        NSArray *newFriend = @[self.acceptedUser.objectId,self.selectedSquad,self.remarkName,@"YES"];
        [allFriends addObject:newFriend];
        //更新user表中的好友列
        [user setObject:allFriends forKey:@"MyFriends"];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                [self addToOtherRequest];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"添加失败，请检查网络"];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"添加失败，请检查网络"];
    }
}

#pragma mark - 添加到他人的好友请求结果的表中
-(void)addToOtherRequest{
    BmobUser *user = [BmobUser currentUser];
    NSMutableArray *allOtherRequest = [[user objectForKey:@"OtherRequest"] mutableCopy];
    NSArray *request = @[self.acceptedUser.objectId,@"已同意"];
    [allOtherRequest addObject:request];
    [user setObject:allOtherRequest forKey:@"OtherRequest"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [self.cz_delegate CZAcceptRequestViewController:self HaveFinishedAddUser:self.acceptedUserInfo];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"添加失败，请检查网络"];
        }
    }];
}

#pragma mark - tableViewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
        {
            return self.showingSquad ? self.squad.count : 0;
        }
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZRequesInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestCell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.titleLabel.text                     = @"备注 :";
            cell.infoTextView.placeholderText        = @"请输入备注(可选)";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 1:
        {
            cell.titleLabel.text   = @"小分队:";
            cell.infoTextView.text = self.squad[indexPath.row];
            cell.infoTextView.userInteractionEnabled = NO;
            if([cell.infoTextView.text isEqualToString:self.selectedSquad]){
                [cell setAccessoryType:(UITableViewCellAccessoryCheckmark)];
            }else{
                [cell setAccessoryType:(UITableViewCellAccessoryNone)];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZRequesInfoCell *cell = (CZRequesInfoCell*)[tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.section == 0){
        [cell.infoTextView becomeFirstResponder];
    }
    if(indexPath.section == 1){
        self.selectedSquad         = cell.infoTextView.text;
        self.squadDetailLabel.text = self.selectedSquad;
        self.showingSquad          = NO;
        self.spreadButton.selected = NO;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1){
        return 44;
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 20;
        case 1:
            return self.showingSquad ? 44 : 0;
        default:
            break;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return self.squadHeaderView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 1 && self.showingSquad == YES){
        return self.containerFooterView;
    }
    return nil;
}

@end
