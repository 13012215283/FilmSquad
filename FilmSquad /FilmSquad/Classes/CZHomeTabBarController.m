//
//  CZHomeTabBarController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/2.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZHomeTabBarController.h"
#import "CZMainNavigationController.h"
#import "CZFilmInfoViewController.h"
#import "CZFriendsViewController.h"
#import "CZDynamicViewController.h"

@interface CZHomeTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CZHomeTabBarController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbar
    [self.tabBar setUnselectedItemTintColor:[UIColor whiteColor]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barStyle = UIBarStyleBlack;

    //影讯
    CZFilmInfoViewController *filemInfoViewController = [[CZFilmInfoViewController alloc]init];
    filemInfoViewController.title = @"影讯";
    filemInfoViewController.tabBarItem.image = [UIImage imageNamed:@"filmInfo"];
    self.title = @"影讯";
    
    //影友
    CZFriendsViewController *friendsViewController = [[CZFriendsViewController alloc]init];
    friendsViewController.title = @"影友";
    friendsViewController.tabBarItem.image = [UIImage imageNamed:@"Contact"];
    
    //动态
    CZDynamicViewController *dynamicViewController = [[CZDynamicViewController alloc]init];
    dynamicViewController.title = @"影评";
    dynamicViewController.tabBarItem.image = [UIImage imageNamed:@"Dynamic"];
   
    [self addChildViewController:[[CZMainNavigationController alloc]initWithRootViewController:filemInfoViewController]];
    [self addChildViewController:[[CZMainNavigationController alloc]initWithRootViewController:friendsViewController]];
    [self addChildViewController:[[CZMainNavigationController alloc]initWithRootViewController:dynamicViewController]];
}




#pragma mark - TabBarControllerDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    self.title = item.title;
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
