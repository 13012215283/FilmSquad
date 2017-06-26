//
//  CZSettingViewController.m
//  FilmSquad
//
//  Created by tarena_cz on 16/12/2.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZSettingViewController.h"
#import "AppDelegate.h"

@interface CZSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSArray *groups;

@end

@implementation CZSettingViewController
#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.dataSource =  self;
    self.tableView.delegate = self;
    
    self.groups = [NSMutableArray array];
    
    NSArray *g1 = @[@[@"清除缓存",@"user"]];
    NSArray *g2 = @[@[@"切换账户",@"user"]];
    NSArray *g3 = @[@[@"修改密码",@"user"]];
    self.groups = @[g1,g2,g3];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *group = self.groups[section];
    return group.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSArray *group = self.groups[indexPath.section];
    
    NSArray *item = group[indexPath.row];
    cell.textLabel.text = item[0];
    cell.textLabel.font = YuanFont(16);
    cell.imageView.image = [UIImage imageNamed:item[1]];
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认切换账号吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BmobUser logout];
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                if(!error){
                    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
                }
            } onQueue:nil];
            
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [app showWelcomeViewController];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [ac addAction:action1];
        [ac addAction:action2];
        [self presentViewController:ac animated:YES completion:nil];
        
        
    }
    if (indexPath.section == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认修改密码?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            UpdataPasswordViewController *vc = [[UpdataPasswordViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    
}

@end
