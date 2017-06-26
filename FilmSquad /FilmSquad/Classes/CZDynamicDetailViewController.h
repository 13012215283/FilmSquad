//
//  CZDynamicDetailViewController.h
//  FilmSquad
//
//  Created by 陈卓 on 16/12/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicFrame.h"

@protocol CZDynamicDetailViewControllerDelegate <NSObject>

-(void)CZDynamicDetailViewControllerWillDismiss;

@end

@interface CZDynamicDetailViewController : UIViewController
@property (nonatomic,strong) DynamicFrame *dynamicFrame;
@property (nonatomic,assign) BOOL isComment;
@end
