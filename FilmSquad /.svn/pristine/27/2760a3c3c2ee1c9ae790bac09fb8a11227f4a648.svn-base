//
//  CZRequestUserInfo.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/13.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZRequestUserInfo.h"

@implementation CZRequestUserInfo
+(CZRequestUserInfo *)getRequestUserInfoFromUser:(BmobUser *)user RequestMessage:(NSString *)message{
    CZRequestUserInfo *userInformation = [[CZRequestUserInfo alloc]init];
    userInformation.user           = user;
    userInformation.name           = [user objectForKey:@"Nick"];
    userInformation.headURL        = [user objectForKey:@"HeadURL"];
    userInformation.requestMessage = message;
    return userInformation;
}

@end
