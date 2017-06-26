//
//  EaseMobManager.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/1.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "EaseMobManager.h"
static EaseMobManager *_manager;
@implementation EaseMobManager
//创建单例
+(EaseMobManager *)shareManager{
    
    
    @synchronized(self) {
        if (!_manager) {
            _manager = [[EaseMobManager alloc]init];
            
            [[EaseMob sharedInstance].chatManager addDelegate:_manager delegateQueue:nil];
            
        }
    }
    return _manager;
    
}

//监听好友请求
-(void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
    if(!message){
        message = @"";
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"request" object:self userInfo:@{@"username":username ,@"message":message}];
}

//监听好友申请成功
-(void)didAcceptedByBuddy:(NSString *)username{
    BmobUser *user = [BmobUser currentUser];
    //获取我的好友申请列表
    NSMutableArray *allMyRequest = [[user objectForKey:@"MyRequest"] mutableCopy];
    NSMutableArray *newAllMyRequest = [[NSMutableArray alloc]init];  //新的申请列表
    for(NSArray *obj in allMyRequest){
            NSMutableArray *newObj = [obj mutableCopy];
            [newAllMyRequest addObject:newObj];
    }
    
    NSMutableArray *requestUser = [[NSMutableArray alloc]init];     //申请成功的用户
    for(NSMutableArray *obj in newAllMyRequest){
        if([[obj firstObject] isEqualToString:username]){
            obj[3]      = @"已通过申请";
            requestUser = obj;
        }
    }
    //获取好友列表
    NSMutableArray *allMyFriends = [[user objectForKey:@"MyFriends"] mutableCopy];
    [allMyFriends addObject:requestUser];  //添加申请成功的用户进入好友列表
    
    //更新用户信息
    [user setObject:newAllMyRequest forKey:@"MyRequest"];
    [user setObject:allMyFriends forKey:@"MyFriends"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            //好友申请成功，发送通知
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"acceptedFriendsRequest" object:@{@"username":username}];
        }
    }];
}

//监听好友申请失败
-(void)didRejectedByBuddy:(NSString *)username{
    BmobUser *user = [BmobUser currentUser];
    //获取我的好友申请列表
    NSMutableArray *allMyRequest = [[user objectForKey:@"MyRequest"] mutableCopy];
    NSMutableArray *newAllMyRequest = [[NSMutableArray alloc]init];  //新的申请列表
    for(NSArray *obj in allMyRequest){
        NSMutableArray *newObj = [obj mutableCopy];
        [newAllMyRequest addObject:newObj];
    }
    
    NSMutableArray *requestUser = [[NSMutableArray alloc]init];     //申请成功的用户
    for(NSMutableArray *obj in newAllMyRequest){
        if([[obj firstObject] isEqualToString:username]){
            obj[3]      = @"对方已拒绝";
            requestUser = obj;
        }
    }

    //更新用户信息
    [user setObject:newAllMyRequest forKey:@"MyRequest"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            //好友申请成功，发送通知
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"refuesedFriendsRequest" object:@{@"username":username}];
        }
    }];

}

#pragma mark - 监听接受消息

//接受在线消息
-(void)didReceiveMessage:(EMMessage *)message{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMessage" object:message];
}

//接受离线消息
-(void)didReceiveOfflineMessages:(NSArray *)offlineMessages{
    
    for (EMMessage *message in offlineMessages){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMessage" object:message];
    }
}


@end
