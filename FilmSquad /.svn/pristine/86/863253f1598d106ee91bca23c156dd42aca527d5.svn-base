//
//  CZSendingViewController.h
//  FilmSquad
//
//  Created by 陈卓 on 16/12/13.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dynamic.h"
@class CZSendingViewController;
@protocol CZSendingViewControllerDelegate <NSObject>
@optional
-(void)sendingViewControllerHadSendDynamic;
-(void)sendingViewControllerHadSendComment;
-(void)sendingViewControllerHadSendRepost;
@end

@interface CZSendingViewController : UIViewController
@property(nonatomic,weak)id<CZSendingViewControllerDelegate> cz_delegate;
@property(nonatomic,strong) Dynamic *dynamic;
@end
