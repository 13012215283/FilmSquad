//
//  CZUserInfo.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/13.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZUserInfo.h"

@implementation CZUserInfo
+(CZUserInfo *)getRequestUserInfoFromUser:(BmobUser *)user{
    CZUserInfo *userInformation = [[CZUserInfo alloc]init];
    userInformation.user        = user;
    userInformation.name        = [user objectForKey:@"Nick"];
    userInformation.headURL     = [user objectForKey:@"HeadURL"];
    return userInformation;
}

+(NSArray*)getUserInfoFromeAllUsers:(NSArray*)users withObject:(NSArray*)object{
    NSMutableArray *userInfo         = [[NSMutableArray alloc]init];
    for(BmobUser *obj in users){
        CZUserInfo *info = [CZUserInfo getRequestUserInfoFromUser:obj];
        NSDictionary *dic;
        for(NSArray *ary in object){
            if([info.user.objectId isEqualToString:ary[0]]){
                dic = @{@"userInfo":info,@"result":[ary lastObject]};
            }
        }
        [userInfo addObject:dic];
    }
    return userInfo;
}

+(NSArray*)getUserInfoFromeAllFriends:(NSArray*)users withFriendsList:(NSArray*)friendsList{
    NSMutableArray *allFriendsInfo = [[NSMutableArray alloc]init];
    for(BmobUser *user in users){
        for(NSArray *ary in friendsList){
            //根据user的Id在friendsList中找到对应的信息
            if([user.objectId isEqualToString:[ary firstObject]]){
                CZUserInfo *userInfo = [CZUserInfo getRequestUserInfoFromUser:user];
                userInfo.squad       = ary[1];  //获得好友的分组
                userInfo.remarkName  = ary[2];  //获得好友的备注
                [allFriendsInfo addObject:userInfo];
            }
        }
    }
    return allFriendsInfo;
}
@end
