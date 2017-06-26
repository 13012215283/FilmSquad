//
//  CZWebUtils.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/22.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZWebUtils.h"
#import "CZFilmsInfoModel.h"
#import "CZFilmInfoDetailModel.h"
#import "CZFimlActorsInfoModel.h"
#import "CZFilmPhotos.h"
@implementation CZWebUtils

#define CZHotFilmsInfoPath @"http://ting.weibo.com/movieapp/rank/hot"
#define CZFilmsDetailPath  @"http://ting.weibo.com/movieapp/page/base?film_id="
#pragma mark - 请求热映电影信息
+(void)requestHotFilmsInfoWithCompletion:(MyCallback)callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:CZHotFilmsInfoPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic       = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *hotFilmsArray  = dic[@"data"][@"ranklist_hot"];
        NSArray *hotFilmsModels = [CZFilmsInfoModel arrayOfModelsFromDictionaries:hotFilmsArray error:nil];
        
        callback(hotFilmsModels);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)requestHotFilmsDetailAndActorsWithFilmId:(NSString*)filmId WithCompletion:(MyCallbackDetailAndActors)callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    NSString *path = [CZFilmsDetailPath stringByAppendingString:filmId];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic        = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *filmDetail = [CZFilmInfoDetailModel arrayOfModelsFromDictionaries:@[dic[@"data"][@"base_info"]]  error:nil];
        NSArray      *filmPhotos = [CZFilmPhotos arrayOfModelsFromDictionaries:dic[@"data"][@"film_photos"][@"list"] error:nil];
        NSArray      *actors     = [CZFimlActorsInfoModel  arrayOfModelsFromDictionaries:dic[@"data"][@"creator_info"][@"actors"][@"list"] error:nil];
        callback(filmDetail,filmPhotos,actors);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
     
}
@end
