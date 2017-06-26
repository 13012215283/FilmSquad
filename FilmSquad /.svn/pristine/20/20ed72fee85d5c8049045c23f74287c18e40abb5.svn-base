//
//  DynamicFrame.h
//  CZEnglish
//
//  Created by tarena_cz on 16/11/18.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dynamic.h"

@interface DynamicFrame : NSObject<NSCoding>
@property (nonatomic,strong) Dynamic *dynamic;              //动态模型，用于计算frame
@property (nonatomic,strong) DynamicFrame *reDynamicFrame;  //转发Frame

@property (nonatomic,assign) CGRect headerImageViewF;       //头像Frame

@property (nonatomic,assign) CGRect nameLabelF;             //名字Frame

@property (nonatomic,assign) CGRect timeLabelF;             //时间Frame


@property (nonatomic,assign) CGRect titleTextViewF;         //主题Frame

@property (nonatomic,assign) CGRect containerViewF;         //容器Frame
@property (nonatomic,assign) CGRect textViewF;              //正文Frame
@property (nonatomic,assign) CGRect photosViewF;            //图片Frame

@property (nonatomic,assign) CGRect reContainerViewF;       //转发容器Frame

@property (nonatomic,assign) CGRect bottomBarF;             //底部barFrame

@property (nonatomic,assign) CGRect topButtonF;             //顶部，右上角按钮
@property (nonatomic,copy)   NSString *topButtoImageName;   //顶部按钮图片名字

@property (nonatomic,assign) CGRect playControlF;           //播放语音按钮
@property (nonatomic,assign) CGRect repostControlF;         //转发按钮
@property (nonatomic,assign) CGRect commentContolF;         //点赞按钮
@property (nonatomic,assign) CGRect zanControlF;

@property (nonatomic,assign) CGRect topSeparatViewF;        //顶部分割线
@property (nonatomic,assign) CGRect bottomSeparatViewF;     //底部分割线

@property (nonatomic,assign) CGFloat padding;               //间隙
@property (nonatomic,assign) CGFloat divCount;              //一个参数用于设置图片大小,默认为3
@property (nonatomic,assign) BOOL bottomBarHidden;          //隐藏底部bar
@property (nonatomic,assign) BOOL bottomPaddingHidden;        //底部间隔
//得到Cell总高度
-(CGFloat)getTotalHeight;


@end


