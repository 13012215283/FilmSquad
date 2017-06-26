//
//  CZUserInfo.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/13.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZUserInfo : NSObject
@property (nonatomic,strong) BmobUser *user;           //用户
@property (nonatomic,strong) NSString *name;           //昵称
@property (nonatomic,  copy) NSString *headURL;        //头像
@property (nonatomic,  copy) NSString *information;    //信息
@property (nonatomic,  copy) NSString *squad;          //分组
@property (nonatomic,  copy) NSString *remarkName;     //备注

+(CZUserInfo *)getRequestUserInfoFromUser:(BmobUser *)user;
+(NSArray*)getUserInfoFromeAllUsers:(NSArray*)users withObject:(NSArray*)object;
+(NSArray*)getUserInfoFromeAllFriends:(NSArray*)users withFriendsList:(NSArray*)friendsList;
@end
