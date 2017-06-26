//
//  UserInformation.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation
+(NSArray *)getAllZanUserArrayFromArray:(NSArray *)array{
    NSMutableArray *allUser = [[NSMutableArray alloc]init];
    for(BmobUser *user in array){
        UserInformation *userInformation = [[UserInformation alloc]init];
        userInformation.user = user;
        userInformation.name = [user objectForKey:@"Nick"];
        userInformation.headURL = [user objectForKey:@"HeadURL"];
        [allUser addObject:userInformation];
    }
    return allUser;
}

@end
