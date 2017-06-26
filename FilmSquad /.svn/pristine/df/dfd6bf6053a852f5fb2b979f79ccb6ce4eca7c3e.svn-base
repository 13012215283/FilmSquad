//
//  CZLeftMenuViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/1.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZLeftMenuViewController.h"
#import "CZMainNavigationController.h"
#import <UIViewController+LMSideBarController.h>
@interface CZLeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tabelView;
@property(nonatomic,strong) UIToolbar *toolBar;
@property(nonatomic,strong) NSArray *titles;         //菜单选项主题
@property(nonatomic,strong) UIView *headView;        //顶部视图
@property(nonatomic,strong) UIButton *headButton;   //头像按钮
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation CZLeftMenuViewController
#pragma mark - 懒加载
-(UITableView *)tabelView{
    if(!_tabelView){
        _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(kWIDTH*(1-0.618), 0, kWIDTH*0.618, kHEIGHT)];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorColor = [UIColor clearColor];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kWIDTH*0.618 ,kWIDTH*0.618*0.8 )];
        _tabelView.tableHeaderView = self.headView;
        
        [self.headView addSubview:self.headImageView];
        [self.headView addSubview:self.headButton];
        [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.headView);
            make.width.height.equalTo(self.headView.mas_width).multipliedBy(0.5);
            self.headButton.layer.cornerRadius = self.headView.frame.size.width*0.5/2;
            self.headButton.layer.borderWidth = 2;
            self.headButton.layer.borderColor = kWhiteColor.CGColor;
            self.headButton.layer.masksToBounds = YES;
        }];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.headView);
            make.width.height.equalTo(self.headView.mas_width).multipliedBy(0.5);
            self.headImageView.layer.cornerRadius = self.headView.frame.size.width*0.5/2;
            self.headImageView.layer.borderWidth = 2;
            self.headImageView.layer.borderColor = kWhiteColor.CGColor;
            self.headImageView.layer.masksToBounds = YES;

        }];
    }
    return _tabelView;
}

-(UIToolbar *)toolBar{
    if(!_toolBar){
        _toolBar = [[UIToolbar alloc]initWithFrame:self.tabelView.frame];
    }
    return _toolBar;
}

-(UIButton *)headButton{
    if(!_headButton){
        _headButton = [[UIButton alloc]init];
        [_headButton addTarget:self action:@selector(actionForHeadButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headButton;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc]init];
        [_headImageView sd_setImageWithURL:[[BmobUser currentUser] objectForKey:@"HeadURL"] placeholderImage:[UIImage imageNamed:@"user"]];
        _headImageView.backgroundColor = [UIColor whiteColor];
    }
    return _headImageView;
}


#pragma mark - 手势方法
-(void)actionForHeadButton:(UIButton*)sender{
     CZMainNavigationController *mainNavigationController = (CZMainNavigationController*)self.sideBarController.contentViewController;
    [mainNavigationController showPersonViewController];
    [self.sideBarController hideMenuViewController:YES];
    [self.tabelView deselectRowAtIndexPath:self.indexPath animated:YES];
   
}

#pragma mark - init
-(instancetype)init{
    if(self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeadImage:) name:@"changHeadImage" object:nil];
    }
    return self;
}
#pragma mark - 通知监听方法
-(void)changeHeadImage:(NSNotification*)notification{
    NSDictionary *dic = notification.userInfo;
    self.headImageView.image = dic[@"image"];
}
#pragma mark - 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.tabelView];
    self.titles = @[@"首页",@"收藏",@"设置"];
}


#pragma mark - tableView Delegate and dataSourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menucell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"menucell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"Home"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"Collection"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"Gear"];
            break;
        default:
            break;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = YuanFont(18);
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZMainNavigationController *mainNavigationController = (CZMainNavigationController*)self.sideBarController.contentViewController;
    switch (indexPath.row) {
        case 0:
            [mainNavigationController showHomeTabBarController];
            break;
        case 1:
            [mainNavigationController showCollectionViewController];
            break;
        case 2:
            [mainNavigationController showSettingViewController];
            break;
        default:
            break;
    }
    self.indexPath = indexPath;
    [self.sideBarController hideMenuViewController:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
