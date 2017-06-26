//
//  CZWelcomeViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/1.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZWelcomeViewController.h"
#import "CZRegistAndLoginViewController.h"
@interface CZWelcomeViewController ()

@end

@implementation CZWelcomeViewController
#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag = 1;
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;  //隐藏navigationBar
}

#pragma mark - 设置页面
-(void)setupUI{
    
    //设置背景图片
    UIImageView *backgroundIV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backgroundIV.image = [UIImage imageNamed:@"Welcome"];
    [self.view addSubview:backgroundIV];
 
    
    //设置登录按钮
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWIDTH/2, kWIDTH/8)];
    loginButton.center = CGPointMake(kWIDTH/2, kHEIGHT*0.6);
    [loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginButton addTarget:self action:@selector(actionForLogin:) forControlEvents:(UIControlEventTouchUpInside)];
    loginButton.layer.cornerRadius = loginButton.bounds.size.height/2;
    loginButton.layer.masksToBounds = YES;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:2];
    [loginButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    
    [self.view addSubview:loginButton];
    
    
    
    //设置注册按钮
    UIButton *registButton = [[UIButton alloc]initWithFrame:CGRectMake(loginButton.frame.origin.x, CGRectGetMaxY(loginButton.frame)+loginButton.frame.size.height/2, loginButton.bounds.size.width, loginButton.bounds.size.height)];
    [registButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [registButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    registButton.backgroundColor = [UIColor clearColor];
    [registButton addTarget:self action:@selector(actionForRegist:) forControlEvents:(UIControlEventTouchUpInside)];
    registButton.layer.cornerRadius = registButton.bounds.size.height/2;
    registButton.layer.masksToBounds = YES;
    registButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:2];
    [registButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    [self.view addSubview:registButton];
    
    
    
}

#pragma mark - 控件方法
//登录按钮方法
-(void)actionForLogin:(UIButton*)sender{
    CZRegistAndLoginViewController *loginViewController = [[CZRegistAndLoginViewController alloc]init];
    loginViewController.title = @"登录";
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}
//注册按钮方法
-(void)actionForRegist:(UIButton*)sender{
    CZRegistAndLoginViewController *registViewController = [[CZRegistAndLoginViewController alloc]init];
    registViewController.title = @"注册";
    [self.navigationController pushViewController:registViewController animated:YES];
}
@end
