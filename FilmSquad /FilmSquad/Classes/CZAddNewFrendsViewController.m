//
//  CZAddNewFrendsViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/20.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZAddNewFrendsViewController.h"
#import "CZFriendSearchViewController.h"
#import "CZSearchResultsViewController.h"
#import "CZPersonViewController.h"
#import "AppDelegate.h"
@interface CZAddNewFrendsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,CZFriendSearchViewControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CZFriendSearchViewController *searchController;
@property (nonatomic,strong) NSArray *imagesNameForCell;
@property (nonatomic,strong) NSArray *titlesForCell;

@end

@implementation CZAddNewFrendsViewController
#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableFooterView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag = 1;
    self.title = @"添加";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addCell"];
    //设置Cell的内容数据
    self.imagesNameForCell = @[@"connetList",];
    self.titlesForCell     = @[@"添加手机联系人"];
    //初始搜索栏
    [self initSearchController];
    
}

#pragma mark - 初始化搜索栏
-(void)initSearchController{
    //    搜索栏相关  参数为搜索结果的页面 如果给nil在当前页面显示
    
    self.searchController                       = [[CZFriendSearchViewController alloc]init];
    self.searchController.delegate              = self;
    self.searchController.searchResultsUpdater  = self;
    self.searchController.cz_delegate           = self;
    //把搜索栏添加到表头
 
    self.tableView.tableHeaderView              = self.searchController.searchBar;
    
    self.searchController.searchBar.placeholder = @"账号 / 昵称 / 手机号 / 群号";
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
//    [self.navigationController addChildViewController:self.searchController];
}
#pragma mark 搜索结果协议

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    CZSearchResultsViewController *searchResultsViewController = (CZSearchResultsViewController*)searchController.searchResultsController;
    searchResultsViewController.searchContents                 = searchController.searchBar.text;
}

//搜索栏隐藏的时候
-(void)willDismissSearchController:(UISearchController *)searchController{
    [self.tabBarController.tabBar setHidden:NO];
    AppDelegate *app                                    = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.statusBarInterceptView.backgroundColor          = [UIColor clearColor];
    [UIApplication sharedApplication].statusBarStyle    = UIStatusBarStyleLightContent;
}

-(void)willPresentSearchController:(UISearchController *)searchController{
    [self.searchController.searchBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBarController.tabBar setHidden:YES];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    app.statusBarInterceptView.backgroundColor       = [UIColor whiteColor];
   
    CZFriendSearchViewController *searchConrollerNew = (CZFriendSearchViewController*)searchController;
    [searchConrollerNew clearAllData];   //清空数据
}


#pragma mark - 
-(void)showPersonInfomationWithUser:(BmobUser *)user{
    self.searchController.active = NO;
    CZPersonViewController *personViewController = [[CZPersonViewController alloc]init];
    personViewController.user                    = user;
    [self.navigationController pushViewController:personViewController animated:YES];
}

#pragma mark - tableView delegate and datasour
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesForCell.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
    cell.imageView.image  = [UIImage imageNamed:self.imagesNameForCell[indexPath.row]];
    cell.textLabel.text   = self.titlesForCell[indexPath.row];
    cell.textLabel.font   = YuanFont(16);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWIDTH/7;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 20;
//}
@end
