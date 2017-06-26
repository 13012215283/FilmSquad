//
//  CZRegistAndLoginViewController.m
//  FilmSquad
//
//  Created by 陈卓 on 16/12/7.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZRegistAndLoginViewController.h"
#import <UIViewController+LMSideBarController.h>
#import "CZRootViewController.h"
@interface CZRegistAndLoginViewController ()
@property(nonatomic,strong) UITextField *userNameTextField;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *rePasswordTextField;
@property(nonatomic,strong) UITextField *nickNameTextField;
@property(nonatomic,strong) UIButton *enterButton;
@property(nonatomic,strong) BmobUser *user;
@property(nonatomic,assign) CGRect keyBoardHFrame;

@property(nonatomic,strong) UIView *usernameSeparateView;
@property(nonatomic,strong) UIView *nickSeparateView;
@property(nonatomic,strong) UIView *passwordSeparateView;
@property(nonatomic,strong) UIView *rePasswordSeparateView;
@end

@implementation CZRegistAndLoginViewController
#pragma mark - 页面载入
- (void)viewDidLoad {
    [super viewDidLoad];
    //这种导航栏主题字体
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20 weight:2]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    [self setupUI];
    [self masonry];
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//-(void)viewDidDisappear:(BOOL)animated {
//    //removeObserver 从通知中心 移除 之前监听的通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}

#pragma mark - 键盘通知
////键盘开启
//-(void)openKeyBoard:(NSNotification*)sender{
//    self.keyBoardHFrame = [sender.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyBoardHeight = [sender.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    NSTimeInterval duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    UIViewAnimationOptions option = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    
//}
//
////键盘关闭
//-(void)closeKeyBoard:(NSNotification*)sender{
//    
//    NSTimeInterval duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    UIViewAnimationOptions option = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    
//}

#pragma mark - 设置UI
-(void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = NO; //显示navigationBar
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    //设置背景图片
    UIImageView *backgroundImageView = [Utils darkGlassImageViewWithImage:[UIImage imageNamed:@"Welcome"] andAlpha:0.5];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:(UIBarMetricsDefault)];
    [self.view addSubview:backgroundImageView];
    
    //设置密码输入框
    self.passwordTextField = [[UITextField alloc]init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [self.view addSubview:self.passwordTextField];
    
    //设置用户名输出框
    self.userNameTextField = [[UITextField alloc]init];
    self.userNameTextField.placeholder = @"请输入用户名";
    self.userNameTextField.textAlignment = NSTextAlignmentCenter;
    self.userNameTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];

 
    [self.view addSubview:self.userNameTextField];
    
    //设置确认密码登录框
    if([self.title isEqualToString:@"注册"]){
        self.rePasswordTextField = [[UITextField alloc]init];
        self.rePasswordTextField.textAlignment = NSTextAlignmentCenter;
        self.rePasswordTextField.placeholder = @"请再次输入密码";
        self.rePasswordTextField.secureTextEntry = YES;
        self.rePasswordTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];

        [self.view addSubview:self.rePasswordTextField];
        
        
        //昵称
        self.nickNameTextField = [[UITextField alloc]init];
        self.nickNameTextField.textAlignment = NSTextAlignmentCenter;
        self.nickNameTextField.placeholder = @"请输入昵称";
        self.nickNameTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        [self.view addSubview:self.nickNameTextField];
    }
    //设置登录按钮
    self.enterButton = [[UIButton alloc]init];
    self.enterButton.titleLabel.font = YuanFont(20);
    [self.enterButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    if([self.title isEqualToString:@"注册"]){
        [self.enterButton setTitle:@"注册" forState:(UIControlStateNormal)];
    }
    else{
        [self.enterButton setTitle:@"登录" forState:(UIControlStateNormal)];
    }
    [self.enterButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.enterButton addTarget:self action:@selector(actionForEnter:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.enterButton];
    
    //分割线
    self.usernameSeparateView = [[UIView alloc]init];
    self.nickSeparateView = [[UIView alloc]init];
    self.passwordSeparateView = [[UIView alloc]init];
    self.rePasswordSeparateView = [[UIView alloc]init];
    
    self.usernameSeparateView.backgroundColor = [UIColor whiteColor];
    self.nickSeparateView.backgroundColor = [UIColor whiteColor];
    self.passwordSeparateView.backgroundColor = [UIColor whiteColor];
    self.rePasswordSeparateView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.usernameSeparateView];
    [self.view addSubview:self.nickSeparateView];
    [self.view addSubview:self.passwordSeparateView];
    [self.view addSubview:self.rePasswordSeparateView];
}

#pragma mark - masonry布局
-(void)masonry{
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.618);
        make.height.equalTo(self.view).multipliedBy(0.07);
        make.center.equalTo(self.view);
    }];
    
    [self.rePasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.enterButton);
        make.bottom.equalTo(self.enterButton.mas_top);
        if([self.title isEqualToString:@"登录"]){
            make.height.mas_equalTo(0);
        }else{
            make.height.equalTo(self.enterButton);
        }
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.enterButton);
        if([self.title isEqualToString:@"登录"]){
            make.bottom.equalTo(self.enterButton.mas_top);
        }else{
            make.bottom.equalTo(self.rePasswordTextField.mas_top);
        }
    }];
    
    [self.nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.enterButton);
        make.bottom.equalTo(self.passwordTextField.mas_top);
        if([self.title isEqualToString:@"登录"]){
            make.height.mas_equalTo(0);
        }else{
            make.height.equalTo(self.enterButton);
        }
    }];
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.enterButton);
        if([self.title isEqualToString:@"登录"]){
            make.bottom.equalTo(self.passwordTextField.mas_top);
        }else{
            make.bottom.equalTo(self.nickNameTextField.mas_top);
        }
    }];
    
    [self.usernameSeparateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.userNameTextField);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.userNameTextField);
    }];
    
    [self.passwordSeparateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.passwordTextField);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.passwordTextField);
    }];
    
    if([self.title isEqualToString:@"注册"]){
        [self.nickSeparateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.nickNameTextField);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.nickNameTextField);
        }];
        
        [self.rePasswordSeparateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.rePasswordTextField);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.rePasswordTextField);
        }];
    }
}


#pragma mark -控件方法
-(void)actionForEnter:(UIButton*)sender{
    [SVProgressHUD showWithStatus:@"请稍等"];
    if([self.title isEqualToString:@"注册"]){
        if([self.passwordTextField.text isEqualToString:self.rePasswordTextField.text]){
            NSArray *squadArray = @[@"我的影友"];
            self.user = [[BmobUser alloc]init];
            self.user.username = self.userNameTextField.text;
            self.user.password = self.passwordTextField.text;
            [self.user setObject:self.nickNameTextField.text forKey:@"Nick"];
            [self.user setObject:squadArray forKey:@"Squad"];
            [self.user setObject:@[] forKey:@"MyFriends"];
            [self.user setObject:@[] forKey:@"MyRequest"];
            [self.user setObject:@[] forKey:@"OtherRequest"];
            
            
            [self.user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                if(isSuccessful){
                    //注册环信
                    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.user.objectId password:self.passwordTextField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
                        if(error){
                             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
                        }else{
                            //返回欢迎页面
                            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    } onQueue:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                }
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"输入的密码不一致"];
        }
    }
    
    
    if([self.title isEqualToString:@"登录"]){
        [BmobUser loginInbackgroundWithAccount:self.userNameTextField.text andPassword:self.passwordTextField.text block:^(BmobUser *user, NSError *error) {
            if(user){
                //保存登录用户的信息
//                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//                [ud setObject:user.username forKey:@"username"];
//                [ud setObject:self.passwordTextField.text forKey:@"password"];
//                [ud synchronize];
//                [self showMainVC];
                //登录环信
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.objectId password:self.passwordTextField.text completion:^(NSDictionary *loginInfo, EMError *error) {
                    if (!error && loginInfo) {
                        [SVProgressHUD showInfoWithStatus:@"登录成功"];
                        //自动登录
                        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                        //登录成功自动获取好友列表
                        [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
                        [self showMainViewController];
                        
                        
                    }else{
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",error ]];
                    }
                    
                } onQueue:nil];

                
            }else{
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            }
        }];
    }
    
}

#pragma mark - 跳转主页面
-(void)showMainViewController{
    CZRootViewController *rootViewController = [[CZRootViewController alloc]init];
    [self presentViewController:rootViewController animated:YES completion:nil];

}

@end
