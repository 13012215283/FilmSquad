//
//  CZChattingViewController.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/18.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZUserInfo.h"
@interface CZChattingViewController : UIViewController
@property (nonatomic,strong) CZUserInfo     *userInfo;      //聊天对象
@property (nonatomic,strong) EMConversation *conversation;  //会话
@end
