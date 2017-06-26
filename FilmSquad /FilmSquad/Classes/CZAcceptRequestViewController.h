//
//  CZAcceptRequestViewController.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/15.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRequestUserInfo.h"
@class CZAcceptRequestViewController;
@protocol CZAcceptRequestViewControllerDelegate <NSObject>
-(void)CZAcceptRequestViewController:(CZAcceptRequestViewController*)Controller HaveFinishedAddUser:(CZRequestUserInfo*)userInfo;

@end

@interface CZAcceptRequestViewController : UIViewController
@property (nonatomic,strong) BmobUser *acceptedUser;
@property (nonatomic,strong) CZRequestUserInfo *acceptedUserInfo;
@property (nonatomic,weak)   id<CZAcceptRequestViewControllerDelegate> cz_delegate;
@end
