//
//  CZRequestCell.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/13.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRequestUserInfo.h"
@class CZRequestCell;

@protocol CZRequestCellDelegate <NSObject>

-(void)czRequestCell:(CZRequestCell*)cell acceptRequestFromUser:(CZRequestUserInfo*)requestUser;

-(void)czRequestCell:(CZRequestCell*)cell refuseRequestFromUser:(CZRequestUserInfo*)requestUser;

@end

@interface CZRequestCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImageView;  //头像
@property (nonatomic,strong) UILabel     *nameLabel;      //名字
@property (nonatomic,strong) UILabel     *messageLabel;   //请求信息
@property (nonatomic,strong) UIButton    *acceptButton;   //同意按钮
@property (nonatomic,strong) UIButton    *refuseButton;   //拒绝按钮
@property (nonatomic,strong) UILabel     *resultLabel;    //处理结果

@property (nonatomic,strong) CZRequestUserInfo    *requestUser;    //申请用户


@property (nonatomic,weak  ) id<CZRequestCellDelegate> cz_delegate; //代理

@end
