//
//  CZSearchResultsViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/20.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZSearchResultsViewController.h"

@interface CZSearchResultsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *imagesNameForCell;
@property (nonatomic,strong) NSArray *titlesForCell;

@property (nonatomic,strong) UILabel *searchPersonLabel;
@property (nonatomic,strong) UILabel *searchSquadLabel;
@property (nonatomic,strong) NSMutableArray<BmobUser*> *users;



@end

@implementation CZSearchResultsViewController
#pragma mark - tableView
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
#pragma mrak - set方法
-(void)setSearchContents:(NSString *)searchContents{
    _searchContents = searchContents;
    self.searchPersonLabel.text = [NSString stringWithFormat:@"%@%@",self.titlesForCell[0],searchContents];
    self.searchSquadLabel.text = [NSString stringWithFormat:@"%@%@",self.titlesForCell[1],searchContents];
}
#pragma mark - 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:(UIBarMetricsDefault)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置cell的数据
    self.imagesNameForCell = @[@"findUser",@"findSquad"];
    self.titlesForCell     = @[@"找人: ",@"找小分队: "];

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchCell"];
    
    
}
#pragma mark - 搜索用户方法
-(void)searchUser{
    BmobQuery* mainQuery =  [BmobQuery queryForUser];
    BmobQuery* userNameQuery =  [BmobQuery queryForUser];
    BmobQuery* nickQuery =  [BmobQuery queryForUser];
    [userNameQuery whereKey:@"username" equalTo:self.searchContents];
    [nickQuery whereKey:@"Nick" equalTo:self.searchContents];
    [mainQuery add:userNameQuery];
    [mainQuery add:nickQuery];
    [mainQuery orOperation];
    [mainQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if(!error){
            self.users = [array mutableCopy];
            [self.cz_delegate czSearchResultsViewContoller:self didFinishedSearchUsers:self.users];
            [SVProgressHUD dismiss];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"查找失败，请检查网络"];
        }
    }];
}
#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesForCell.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@",self.titlesForCell[indexPath.row],self.searchContents];
    cell.textLabel.font = YuanFont(16);
    cell.imageView.image = [UIImage imageNamed:self.imagesNameForCell[indexPath.row]];
    switch (indexPath.row) {
        case 0:
            self.searchPersonLabel = cell.textLabel;
            break;
        case 1:
            self.searchSquadLabel = cell.textLabel;
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [SVProgressHUD showWithStatus:@"正在搜索"];
            [self searchUser];
        }
            break;
        case 1:
            break;
        default:
            break;
    }
}
@end
