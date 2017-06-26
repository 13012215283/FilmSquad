//
//  CZFilmInfoViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/6.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZFilmInfoViewController.h"
#import "CZFilmDetiainViewController.h"
#import "CZFilmInfoCell.h"
@interface CZFilmInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *hotFilmModels; //热映信息

@property (nonatomic,strong) UITableView    *tableView;
@end

@implementation CZFilmInfoViewController
#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView            = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-64)];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[CZFilmInfoCell class] forCellReuseIdentifier:@"filmInfoCell"];
     [self addPullToRefreshAndRequestData];   //添加下拉刷新
    [self requestData];
}
#pragma mark - 本地请求数据，没有则网络请求
-(void)requestData{
    //从本地获取数据，若没有则网络请求数据
    NSString *fileInfoPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/AllfilmInfo/AllFileModels.arch"];
    self.hotFilmModels     = [NSKeyedUnarchiver unarchiveObjectWithFile:fileInfoPath];
    if(!self.hotFilmModels){
        //若没有数据，则从网络请求
        [self.tableView triggerPullToRefresh];
    }
}

-(void)requestDataFromInternet{
    //获取数据
    __block CZFilmInfoViewController *weakSelf = self;
    [CZWebUtils requestHotFilmsInfoWithCompletion:^(id obj) {
        weakSelf.hotFilmModels = obj;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        //归档
        NSString *fileInfoPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/AllfilmInfo"];
        if(![[NSFileManager defaultManager] fileExistsAtPath:fileInfoPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:fileInfoPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *allFileModelsPath = [fileInfoPath stringByAppendingString:@"/AllFileModels.arch"];
        [NSKeyedArchiver archiveRootObject:weakSelf.hotFilmModels toFile:allFileModelsPath];
        
    }];

}
#pragma mark - 添加下拉刷新
-(void)addPullToRefreshAndRequestData{
    __block CZFilmInfoViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf requestDataFromInternet];
    }];
}

#pragma mark - tableView delegate And dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotFilmModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZFilmInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filmInfoCell" forIndexPath:indexPath];
    cell.filmInfo        = self.hotFilmModels[indexPath.row];
    cell.indexPath = indexPath;
    cell.location = self.tableView.contentOffset.y;
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}
#define HeightForCell kHEIGHT/4

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightForCell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *cells = [self.tableView visibleCells];
    for(CZFilmInfoCell *cell in cells){
        cell.indexPath = [self.tableView indexPathForCell:cell];
        cell.location = scrollView.contentOffset.y;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZFilmsInfoModel *filmsInfo = self.hotFilmModels[indexPath.row];
    CZFilmDetiainViewController *filmsDetainController = [[CZFilmDetiainViewController alloc]init];
    filmsDetainController.filmId = filmsInfo.film_id;
    filmsDetainController.title  = filmsInfo.name;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:filmsDetainController];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
