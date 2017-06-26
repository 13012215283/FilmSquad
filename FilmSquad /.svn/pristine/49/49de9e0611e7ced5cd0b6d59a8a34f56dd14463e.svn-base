//
//  AppDelegate.m
//  FilmSquad
//
//  Created by tarena_cz on 16/11/30.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"
#import "CZWelcomeViewController.h"
#import "CZRootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationType types = UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    //注册
    [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //添加背景图片
    UIImageView *imageView = [Utils glassImageViewWithImage:nil andAlpha:kGlassAlpha];
    [self.window addSubview:imageView];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //初始化Bmob
    [Bmob registerWithAppKey:@"11c98f8229a7a386f913916c9f6aa12a"];
    
    //初始化环信
    [self initEaseMobWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    //判断是否登录过来显示不同页面
    if([BmobUser currentUser]){
        [self showMainViewController];
    }else{
        [self showWelcomeViewController];
    }
    application.statusBarStyle = UIStatusBarStyleLightContent;
    

    
    return YES;
}
#pragma mark - 懒加载
-(UIView *)statusBarInterceptView{
    if(!_statusBarInterceptView){
        _statusBarInterceptView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
        _statusBarInterceptView.backgroundColor=[UIColor clearColor];
        [[[UIApplication sharedApplication].delegate window] addSubview:_statusBarInterceptView];
    }
    return _statusBarInterceptView;
}

#pragma mark - 显示首页
-(void)showMainViewController{
    CZRootViewController *rootViewController = [[CZRootViewController alloc]init];
    self.window.rootViewController = rootViewController;
}


#pragma mark - 显示欢迎页面
-(void)showWelcomeViewController{
    CZWelcomeViewController *welcomeViewController = [[CZWelcomeViewController alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:welcomeViewController];
}



- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    }


- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
        [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FilmSquad"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
