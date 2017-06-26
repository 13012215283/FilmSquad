//
//  CZMainNavigationController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/1.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZMainNavigationController.h"
#import <UIViewController+LMSideBarController.h>
@interface CZMainNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CZMainNavigationController
#pragma mark - 懒加载
-(CZHomeTabBarController *)homeTabBarController{
    if(!_homeTabBarController){
        _homeTabBarController = [[CZHomeTabBarController alloc]init];
    }
    return _homeTabBarController;
}

-(CZCollectionViewController *)collectionViewContoller{
    if(!_collectionViewContoller){
        _collectionViewContoller = [[CZCollectionViewController alloc]init];
    }
    return _collectionViewContoller;
}

-(CZSettingViewController *)settingViewController{
    if(!_settingViewController){
        _settingViewController = [[CZSettingViewController alloc]init];
    }
    return _settingViewController;
}
-(CZPersonViewController *)personViewController{
    if(!_personViewController){
        _personViewController = [[CZPersonViewController alloc]init];
        _personViewController.hideNavigationButtonItem = YES;
    }
    return _personViewController;
}

#pragma mark - 显示页面
-(void)showHomeTabBarController{
    [self setViewControllers:@[self.homeTabBarController] animated:YES];
    self.navigationBar.hidden = YES;
}

-(void)showCollectionViewController{
    [self setViewControllers:@[self.collectionViewContoller] animated:YES];
    self.navigationBar.hidden = NO;
}

-(void)showSettingViewController{
    [self setViewControllers:@[self.settingViewController] animated:YES];
    self.navigationBar.hidden = NO;
}
-(void)showPersonViewController{
    self.personViewController.user = [BmobUser currentUser];
    [self setViewControllers:@[self.personViewController] animated:YES];
    self.navigationBar.hidden = NO;
}

#pragma mark - 控件方法
-(void)leftMenuAction:(UIBarButtonItem*)sender{
    [self.sideBarController showMenuViewControllerInDirection:(LMSideBarControllerDirectionLeft)];
}
-(void)messageMuneAction:(UIBarButtonItem*)sender{
    [self.sideBarController showMenuViewControllerInDirection:(LMSideBarControllerDirectionRight)];
}
#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //设置导航栏
//    [navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:(UIBarMetricsDefault)];
//    navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //这种导航栏主题字体
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:YuanFont(20)}];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    if(viewController.view.tag == 0){
    //设置左边菜单按钮
    UIImage *leftImage = [[UIImage imageNamed:@"List"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(leftMenuAction:)];
    
    //设置右边消息按钮
    UIImage *messageImage = [[UIImage imageNamed:@"IM"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:messageImage style:(UIBarButtonItemStyleDone) target:self action:@selector(messageMuneAction:)];
    }
    
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

#pragma mark - 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
