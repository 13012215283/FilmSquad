//
//  CZFriendSearchViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/20.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZFriendSearchViewController.h"
#import "CZSearchResultsViewController.h"
#import "CZPersonViewController.h"

#define CellHeight 60
#define SectionHeaderHeight 20

@interface CZFriendSearchViewController ()<CZSearchResultsViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIImageView                *glassImageView;     //背景
@property (nonatomic,strong) UITableView                *tableView;          //用于显示搜索返回结果的tableview
@property (nonatomic,strong) NSMutableArray<BmobUser*>  *searchResult;
@property (nonatomic,copy)   NSString                   *searchText;         //查询内容
@property (nonatomic, strong)UINavigationController* navigation;
@end

@implementation CZFriendSearchViewController
#pragma mark - 懒加载
-(UIImageView *)glassImageView{
    if(!_glassImageView){
        _glassImageView = [Utils extraLightglassImageViewWithImage:nil andAlpha:1];
        _glassImageView.userInteractionEnabled = YES;
    }
    return _glassImageView;
}

-(UINavigationController *)navigation{
    if (!_navigation) {
        _navigation = [UINavigationController new];
    }
    return _navigation;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
#pragma mark - 重写get方法
//重写get方法,避免ResultsControllerView被自己添加的控件挡住
-(UIView *)containerView{
    if(!_containerView){
        _containerView = self.view.subviews.firstObject;   //取到serchViewController的containerView
    }
    return _containerView;
}
#pragma mark - 初始化
-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    CZSearchResultsViewController *searchResultsViewController = [[CZSearchResultsViewController alloc]init];
    if(self = [super initWithSearchResultsController:searchResultsViewController]){
        searchResultsViewController.cz_delegate = self;
        [self setupUI];
    }
    return self;
}
//重新init方法，让外部怎么创建都是自定义的serchController
- (instancetype)init
{
     CZSearchResultsViewController *searchResultsViewController = [[CZSearchResultsViewController alloc]init];
    if(self = [super initWithSearchResultsController:searchResultsViewController]){
         searchResultsViewController.cz_delegate = self;
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI
-(void)setupUI{
    //    是否隐藏原来的tableView的内容  因为结果就是显示到当前页面 所以不能隐藏
    self.dimsBackgroundDuringPresentation = YES;
    [self.searchBar setBackgroundImage:[[UIImage alloc]init] forBarPosition:(UIBarPositionAny) barMetrics:(UIBarMetricsDefault)];
    [self.searchBar setSearchBarStyle:(UISearchBarStyleMinimal)];
    
    //KVC设置搜索栏取消字样
    [self.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];

}

#pragma 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.containerView insertSubview:self.tableView atIndex:0];
    [self.containerView insertSubview:self.glassImageView atIndex:0];
    
    //布局
    [self masonry];
    
}

#pragma mark - 修改布局
-(void)viewDidLayoutSubviews{
    
}
#pragma mark - masonry布局
-(void)masonry{
    [self.glassImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
}

#pragma mark - CZSearchResultsViewConroller delegate
-(void)czSearchResultsViewContoller:(CZSearchResultsViewController *)resultsViewController didFinishedSearchUsers:(NSMutableArray *)searchReults{
    self.searchText = self.searchBar.text;  //记录查询的内容
    self.searchBar.text = @"";
    self.searchResult = searchReults;
    [self.tableView reloadData];
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.searchResult.count;
        case 1:
            
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"resultsCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"resultsCell"];
    }
    BmobUser *user         = self.searchResult[indexPath.row];
    NSString *headImageURL = [user objectForKey:@"HeadURL"];
    NSString *userName     = user.username;
    NSString *nick         = [user objectForKey:@"Nick"];
    NSString *phoneNumber  = user.mobilePhoneNumber;
    NSString *searchInfo    = [phoneNumber isEqualToString:self.searchText]?[NSString stringWithFormat:@"%@ (手机号:%@)",nick, phoneNumber]:nick;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:headImageURL] placeholderImage:[UIImage imageNamed:@"user"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.imageView.image = [Utils drawImage:image drawRect:CGRectMake(0, 0, CellHeight, CellHeight) andLineWidth:0 andStrokeColor:nil];
        
    }];
    
    cell.textLabel.font = YuanFont(16);
    cell.detailTextLabel.font = YuanFont(13);
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    [cell.textLabel setAttributedText:[self getHightLightStringFromString:searchInfo]];
    [cell.detailTextLabel setAttributedText:[self getHightLightStringFromString:userName]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SectionHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BmobUser *user;
    switch (indexPath.section) {
        case 0:
            user = self.searchResult[indexPath.row];
            break;
        case 1:
            break;
        default:
            break;
    }
    [self.cz_delegate showPersonInfomationWithUser:user];
//    CZPersonViewController *personViewController = [[CZPersonViewController alloc]init];
//    personViewController.user                    = user;
//    [self.navigation pushViewController:personViewController animated:YES];
//    [self.presentingViewController.navigationController pushViewController:personViewController animated:YES];
//    self.presentingViewController.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 获取属性字符串，用于设置搜索关键字的高亮颜色
-(NSMutableAttributedString*)getHightLightStringFromString:(NSString*)string{
    NSMutableAttributedString *attributeSearchInfo = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange rang = [string rangeOfString:self.searchText];
    [attributeSearchInfo addAttribute:NSForegroundColorAttributeName value:CZBlueColor range:rang];
    return attributeSearchInfo;
}
#pragma mark - 清空数据
-(void)clearAllData{
    self.searchText = nil;
    self.searchResult = nil;
    [self.tableView reloadData];
}

@end
