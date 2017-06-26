//
//  CZFriendSearchViewController.h
//  FilmSquad
//
//  Created by 陈卓 on 16/12/20.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZFriendSearchViewController;
@protocol CZFriendSearchViewControllerDelegate <NSObject>

-(void)showPersonInfomationWithUser:(BmobUser*)user;

@end

@interface CZFriendSearchViewController : UISearchController

@property (nonatomic,weak)UIView *containerView;
@property (nonatomic,weak)id<CZFriendSearchViewControllerDelegate> cz_delegate;

-(void)clearAllData;                            //清空数据
@end
