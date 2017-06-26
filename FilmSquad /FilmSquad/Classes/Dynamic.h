//
//  Dynamic.h
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/11.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dynamic : NSObject<NSCoding>{
    float _dynamicHeight;
}
@property(nonatomic,strong) BmobUser *user;           //用户
@property(nonatomic,strong) NSString *name;           //昵称

@property (nonatomic, copy)NSString *title;           //主题

@property (nonatomic, copy)NSString *contentText;     //内容

@property (nonatomic, strong)NSString *created_at;    //创建时间

@property (nonatomic, copy)NSString *reposts_count;   //转发数

@property (nonatomic, copy)NSString *comments_count;  //评论数

@property (nonatomic, copy)NSString *zan_count;       //点赞数

@property (nonatomic,assign)BOOL isZan;

@property (nonatomic, strong)Dynamic *reposts_status; //转发动态

@property (nonatomic, strong)NSArray *pic_urls;       //图片
@property (nonatomic,strong) NSMutableArray<NSString*> *zanList; //点赞列表

@property (nonatomic, copy)NSString *headURL;         //头像
@property (nonatomic,copy)NSString *recordURL;        //语音地址
@property (nonatomic,copy)NSString *recordDuration;   //语音时间
//@property (nonatomic,copy)NSString *objectId;

@property (nonatomic,strong)BmobObject *bmobObjext;

+(NSArray*)getAllDynamicArrayFromArray:(NSArray*)array;
+(Dynamic*)getDynamicFromBmobObject:(BmobObject*)obj;
@end
