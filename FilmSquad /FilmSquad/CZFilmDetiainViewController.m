//
//  CZFilmDetiainViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 17/3/2.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZFilmDetiainViewController.h"
#import "CZFilmInfoDetailModel.h"
#import "CZFimlActorsInfoModel.h"
#import "CZActorsCellTableViewCell.h"
#import "CZFilmPhotos.h"
#import "CZWebUtils.h"
#import "FilmPhotosCell.h"
#import "CZIntroduceCellTableViewCell.h"
@interface CZFilmDetiainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView      *headView;
@property (nonatomic,strong) UIImageView *posterImageView;
@property (nonatomic,strong) UILabel     *scoreLabel;
@property (nonatomic,strong) UIView      *scoreView;
@property (nonatomic,strong) UILabel     *commentCountLabel;
@property (nonatomic,strong) UILabel     *timeLabel;
@property (nonatomic,strong) UILabel     *typeLabel;
@property (nonatomic,strong) NSMutableArray<UIImageView*> *starImageViews;



@property (nonatomic,strong) CZFilmInfoDetailModel                         *filmDetain;
@property (nonatomic,strong) NSMutableArray<CZFimlActorsInfoModel*>        *actors;
@property (nonatomic,strong) NSMutableArray<CZFilmPhotos*>                 *filmPhotos;
@property (nonatomic,strong) NSMutableArray  *allImageUrl;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;     //渐变层

@property (nonatomic,assign) BOOL    cz_selected;
@property (nonatomic,assign) CGFloat deskHeight;
@end

@implementation CZFilmDetiainViewController
#pragma mark - 懒加载
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        // 初始化渐变层
        _gradientLayer       = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT*0.618);
        
        // 设置颜色渐变方向
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint   = CGPointMake(0, 1);
        
        // 设定颜色组
        _gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor blackColor].CGColor];
        
        // 设定颜色分割点
        _gradientLayer.locations = @[@(0.1f), @(1.f)];
    }
    return _gradientLayer;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView                     = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kWIDTH, kHEIGHT)];
        _tableView.contentInset        = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.delegate            = self;
        _tableView.dataSource          = self;

        self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT*0.618)];
        self.posterImageView = [[UIImageView alloc]init];
        self.posterImageView.backgroundColor = [UIColor blackColor];
        self.posterImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.posterImageView.layer addSublayer:self.gradientLayer];
        self.posterImageView.layer.masksToBounds = YES;
        
        self.scoreLabel               = [[UILabel alloc]init];
        self.scoreLabel.font          = [UIFont systemFontOfSize:25 weight:0.3];
        self.scoreLabel.textColor     = [UIColor yellowColor];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        
        self.scoreView = [[UIView alloc]init];
        self.starImageViews = [[NSMutableArray alloc]init];
        //添加评分星
        for(NSInteger i = 0; i < 5; i++){
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image        = [UIImage imageNamed:@"star_empty"];
            [self.starImageViews addObject:imageView];
            [self.scoreView addSubview:imageView];
        }
        
        //黑色蒙版
        UIView *blackView         = [[UIView alloc]init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha           = 0.4;
        
        
        
        //评论人数
        self.commentCountLabel               = [[UILabel alloc]init];
        self.commentCountLabel.font          = YuanFont(15);
        self.commentCountLabel.textColor     = [UIColor whiteColor];
        self.commentCountLabel.textAlignment = NSTextAlignmentCenter;
        self.commentCountLabel.alpha         = 0.6;
        
        //电影类型
        self.typeLabel               = [[UILabel alloc]init];
        self.typeLabel.font          = YuanFont(15);
        self.typeLabel.textColor     = [UIColor whiteColor];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.alpha         = 0.6;
        
        //上映时间
        self.timeLabel               = [[UILabel alloc]init];
        self.timeLabel.font          = YuanFont(15);
        self.timeLabel.textColor     = [UIColor whiteColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.alpha         = 0.6;

        
        
        
        [self.headView addSubview:self.posterImageView];
        [self.headView addSubview:self.scoreLabel];
        [self.headView addSubview:self.scoreView];
        [self.headView addSubview:blackView];
        [self.headView addSubview:self.commentCountLabel];
        [self.headView addSubview:self.typeLabel];
        [self.headView addSubview:self.timeLabel];
        _tableView.tableHeaderView = self.headView;
        
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.posterImageView);
            make.height.equalTo(self.posterImageView).multipliedBy(1.5);
        }];
        
        
    }
    return _tableView;
}
#pragma mark - 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:YuanFont(20)}];
    
    //设置左边返回按钮
    UIImage *leftImage = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(returnAction:)];
    
    self.view.tag = 1;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FilmPhotosCell class] forCellReuseIdentifier:@"photoCell"];
    [self.tableView registerClass:[CZActorsCellTableViewCell class] forCellReuseIdentifier:@"actorCell"];
    [self.tableView registerClass:[CZIntroduceCellTableViewCell class] forCellReuseIdentifier:@"introduceCell"];
    [self masonry];
    [self requestData];
}
#pragma mark - 请求数据
-(void)requestData{
    //从本地获取数据，若没有则网络请求数据
    NSString *fileInfoPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/AllfileDetail"];
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@",fileInfoPath,self.filmId];
    
    NSString *filmDetailPath = [directoryPath stringByAppendingString:@"/FileDetail.arch"];
    NSString *photosPath   = [directoryPath stringByAppendingString:@"/PhotoUrls.arch"];
    NSString *actorsPath   = [directoryPath stringByAppendingString:@"/Actors.arch"];
    
    self.filmDetain = [NSKeyedUnarchiver unarchiveObjectWithFile:filmDetailPath];
    self.allImageUrl     = [NSKeyedUnarchiver unarchiveObjectWithFile:photosPath];
    self.actors     = [NSKeyedUnarchiver unarchiveObjectWithFile:actorsPath];
    if(!self.filmDetain || !self.allImageUrl || !self.actors){
        //若本地没有数据，网络请求
        [self requestDataFromInternet];
    }else{
        [self setupUI];
        [self.tableView reloadData];
    }
    
}
-(void)requestDataFromInternet{
    //网络请求数据
    [CZWebUtils requestHotFilmsDetailAndActorsWithFilmId:self.filmId WithCompletion:^(id filmDetial, id filmPotos, id actors) {
        [SVProgressHUD showWithStatus:@"请稍等"];
        self.filmDetain = filmDetial[0];
        self.filmPhotos = [filmPotos mutableCopy];
        self.actors     = [actors mutableCopy];
        
        [self setupUI];
        self.allImageUrl = [[NSMutableArray alloc]init];
        for(CZFilmPhotos *photos in self.filmPhotos){
            [self.allImageUrl addObject:photos.photo_url_small];
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        //获取沙箱根目录
        NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        //获取存储所有电影详情的文件夹，不存在则创建
        NSString *fileInfoPath = [documentPath stringByAppendingString:@"/AllfileDetail"];
        if(![[NSFileManager defaultManager] fileExistsAtPath:fileInfoPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:fileInfoPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *directoryPath = [NSString stringWithFormat:@"%@/%@",fileInfoPath,self.filmId];
        //判断文件夹是否存在，不存在则创建
        if(![[NSFileManager defaultManager] fileExistsAtPath:directoryPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //归档
        NSString *filmDetailPath = [directoryPath stringByAppendingString:@"/FileDetail.arch"];
        
        NSData *filmDetailData = [NSKeyedArchiver archivedDataWithRootObject:self.filmDetain];
        [filmDetailData writeToFile:filmDetailPath atomically:YES];
        
        NSString *photosPath   = [directoryPath stringByAppendingString:@"/PhotoUrls.arch"];
        NSData *photoUrlsData = [NSKeyedArchiver archivedDataWithRootObject:self.allImageUrl];
        [photoUrlsData writeToFile:photosPath atomically:YES];
        
        NSString *actorsPath   = [directoryPath stringByAppendingString:@"/Actors.arch"];
        NSData *actorsData = [NSKeyedArchiver archivedDataWithRootObject:self.actors];
        [actorsData writeToFile:actorsPath atomically:YES];
    }];
}

#pragma mark - 设置UI
-(void)setupUI{
    [self.posterImageView sd_setImageWithURL:self.filmDetain.poster_url placeholderImage:[UIImage imageNamed:@"ph"]];
    self.scoreLabel.text = self.filmDetain.score;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@人点评",self.filmDetain.score_count];;
    self.typeLabel.text = [NSString stringWithFormat:@"%@/%@",self.filmDetain.filmType,self.filmDetain.country];
    self.timeLabel.text = self.filmDetain.release_time;
    [self setupScoreStar];

}
#pragma mark - 布局
-(void)masonry{
    
    [self.posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headView);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headView);
        make.height.width.equalTo(self.headView.mas_width).multipliedBy(1.0/8);
    }];
    
    [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.scoreLabel.mas_width).multipliedBy(2.5);
        make.height.equalTo(self.scoreLabel).multipliedBy(0.5);
        make.centerX.equalTo(self.scoreLabel);
        make.top.equalTo(self.scoreLabel.mas_bottom);
    }];
    
    [self.starImageViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.scoreView);
        make.width.equalTo(self.scoreView.mas_width).multipliedBy(1.0/5);
    }];
    
    [self.starImageViews[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starImageViews[0].mas_right);
        make.top.bottom.equalTo(self.scoreView);
        make.width.height.equalTo(self.starImageViews[0]);
    }];
    
    [self.starImageViews[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starImageViews[1].mas_right);
        make.top.bottom.equalTo(self.scoreView);
        make.width.height.equalTo(self.starImageViews[0]);
    }];
    
    [self.starImageViews[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starImageViews[2].mas_right);
        make.top.bottom.equalTo(self.scoreView);
        make.width.height.equalTo(self.starImageViews[0]);
    }];
    
    [self.starImageViews[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starImageViews[3].mas_right);
        make.top.bottom.equalTo(self.scoreView);
        make.width.height.equalTo(self.starImageViews[0]);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.scoreView).multipliedBy(2);
        make.top.equalTo(self.scoreView.mas_bottom).offset(8);
        make.height.centerX.equalTo(self.scoreView);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.commentCountLabel);
        make.top.equalTo(self.commentCountLabel.mas_bottom);
        make.height.equalTo(self.commentCountLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.commentCountLabel);
        make.top.equalTo(self.typeLabel.mas_bottom);
        make.height.equalTo(self.commentCountLabel);
    }];
}

#pragma mark - 设置评分星数
-(void)setupScoreStar{
    CGFloat score = self.filmDetain.score.floatValue;
    CGFloat starScore = score/2;
    NSInteger intScore = @(starScore).integerValue;
    CGFloat   floatScore = starScore - intScore;
    for(NSInteger i = 0; i < intScore; i++){
        UIImageView *starImageView = self.starImageViews[i];
        starImageView.image = [UIImage imageNamed:@"star_full"];
    }
    if(floatScore >=0.5){
        self.starImageViews[intScore].image = [UIImage imageNamed:@"star_half"];
    }
    
}

#pragma mark - 控件方法
-(void)returnAction:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - uitableView delegate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            CZIntroduceCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introduceCell" forIndexPath:indexPath];
            cell.deskLabel.text                 = self.filmDetain.desc;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
            break;
        case 1:
        {
            CZActorsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"actorCell" forIndexPath:indexPath];
            cell.allActorInfo               = self.actors;
            [cell.actorsCollectionView reloadData];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
           
            FilmPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell" forIndexPath:indexPath];
            if(self.allImageUrl.count >= 5){
                cell.allImagesUrl = self.allImageUrl;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
            
        default:
            break;
    }
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView  *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 50)];
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, kWIDTH, 50)];
    sectionLabel.textColor = [UIColor blackColor];
    sectionLabel.font      = YuanFont(20);
    switch (section) {
        case 0:
            sectionLabel.text = @"简介";
            break;
        case 1:
            sectionLabel.text = @"演员";
            break;
        case 3:
            sectionLabel.text = @"剧照";
            break;
        default:
            break;
    }
    
    //分割线
    UIView *topSepView      = [[UIView alloc]init];
    UIView *bottomSepView   = [[UIView alloc]init];
    topSepView.backgroundColor = kWhiteColor;
    bottomSepView.backgroundColor = kWhiteColor;
    
    [sectionHeaderView addSubview:sectionLabel];
    [sectionHeaderView addSubview:topSepView];
    [sectionHeaderView addSubview:bottomSepView];
    
    [topSepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(sectionHeaderView);
        make.height.mas_equalTo(1);
    }];
    
    [bottomSepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(sectionHeaderView);
        make.height.mas_equalTo(1);
    }];
    
    return sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if(self.cz_selected == NO){
                return  kWIDTH*0.2 ;
            }else{
                return self.deskHeight;
            }
        }
            break;
        case 1:
            return kWIDTH*0.45;
            break;
        case 2:
            return kWIDTH*0.618;
            break;
        default:
            break;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        CZIntroduceCellTableViewCell *cell = (CZIntroduceCellTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.spreadButton.selected = !cell.spreadButton.selected;
        self.deskHeight  = [cell getNewHeight];
        self.cz_selected = cell.spreadButton.selected;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.tableView.contentOffset.y < - 100) {
        [self.tableView setContentOffset:CGPointMake(0, -100)];
    }
}

@end
