//
//  CZRootViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/1.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZRootViewController.h"
#import <LMSideBarDepthStyle.h>
#import "CZLeftMenuViewController.h"
#import "CZMessagesViewController.h"
#import "CZMainNavigationController.h"
#import <UIViewController+LMSideBarController.h>
@interface CZRootViewController ()

@end

@implementation CZRootViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化 side bar styles
        LMSideBarDepthStyle *sideBarDepthStyle = [[LMSideBarDepthStyle alloc]init];
        sideBarDepthStyle.menuWidth = kWIDTH*0.618;
        
        //初始化 view controller
        CZMessagesViewController *messeagesViewController = [[CZMessagesViewController alloc]init];
        CZLeftMenuViewController *leftMenuViewController = [[CZLeftMenuViewController alloc]init];
        CZMainNavigationController *mainNavigationContoller = [[CZMainNavigationController alloc]init];
        
        //设置 side bar controller
        [self setPanGestureEnabled:YES];
        [self setDelegate:self];
        [self setMenuViewController:leftMenuViewController forDirection:(LMSideBarControllerDirectionLeft)];
        [self setMenuViewController:messeagesViewController forDirection:(LMSideBarControllerDirectionRight)];
        [self setSideBarStyle:sideBarDepthStyle forDirection:(LMSideBarControllerDirectionLeft)];
        [self setSideBarStyle:sideBarDepthStyle forDirection:(LMSideBarControllerDirectionRight)];
        [self setContentViewController:mainNavigationContoller];
        [mainNavigationContoller showHomeTabBarController];
        
    }
    return self;
}
#pragma mark - SIDE BAR DELEGATE

- (void)sideBarController:(LMSideBarController *)sideBarController willShowMenuViewController:(UIViewController *)menuViewController
{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)sideBarController:(LMSideBarController *)sideBarController didShowMenuViewController:(UIViewController *)menuViewController
{
    
}

- (void)sideBarController:(LMSideBarController *)sideBarController willHideMenuViewController:(UIViewController *)menuViewController
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [UIApplication sharedApplication].statusBarHidden = NO;

}

- (void)sideBarController:(LMSideBarController *)sideBarController didHideMenuViewController:(UIViewController *)menuViewController
{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
