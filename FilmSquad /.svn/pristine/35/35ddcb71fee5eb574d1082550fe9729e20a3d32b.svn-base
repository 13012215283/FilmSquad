//
//  Dynamic.m
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/11.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "Dynamic.h"
#import "YYTextView.h"

@implementation Dynamic

+(NSArray *)getAllDynamicArrayFromArray:(NSArray *)array{
    NSMutableArray *allDynamic = [[NSMutableArray alloc]init];
    for(BmobObject *obj in array){
        Dynamic *dynamic = [[Dynamic alloc]init];
        BmobUser *user = [obj objectForKey:@"User"];
        dynamic.user = user;
        dynamic.name = [user objectForKey:@"Nick"];
        dynamic.title = [obj objectForKey:@"Title"];
        dynamic.created_at = [obj objectForKey:@"createdAt"];
        dynamic.reposts_count = [(NSNumber*)[obj objectForKey:@"Reposts_Num"] stringValue];
        dynamic.comments_count = [(NSNumber*)[obj objectForKey:@"Comments_Num"] stringValue];
        dynamic.zan_count = [(NSNumber*)[obj objectForKey:@"Zan_Num"] stringValue];
        dynamic.zanList = [[obj objectForKey:@"ZanList"] mutableCopy];
        if([obj objectForKey:@"Repost"]){
        dynamic.reposts_status =  [Dynamic getDynamicFromBmobObject:[obj objectForKey:@"Repost"]];
        }
        dynamic.pic_urls = [obj objectForKey:@"ImageURL"];
        dynamic.headURL = [user objectForKey:@"HeadURL"];
        dynamic.recordURL = [obj objectForKey:@"RecordURL"];
        dynamic.created_at = [obj objectForKey:@"createdAt"];
        dynamic.contentText = [obj objectForKey:@"Contents"];
        dynamic.recordDuration = [obj objectForKey:@"RecordDuration"];
        dynamic.bmobObjext = obj;
        if([dynamic.zanList containsObject:[BmobUser currentUser].objectId]){
            dynamic.isZan = YES;
        }else{
            dynamic.isZan= NO;
        }

        [allDynamic addObject:dynamic];
    }
    
    return allDynamic;
}

+(Dynamic*)getDynamicFromBmobObject:(BmobObject*)obj{
    Dynamic *dynamic = [[Dynamic alloc]init];
    BmobUser *user = [obj objectForKey:@"User"];
    dynamic.user = user;
    dynamic.name = [user objectForKey:@"nick"];
    dynamic.title = [obj objectForKey:@"Title"];
    dynamic.created_at = [obj objectForKey:@"createdAt"];
    dynamic.reposts_count = [(NSNumber*)[obj objectForKey:@"Reposts_Num"] stringValue];
    dynamic.comments_count = [(NSNumber*)[obj objectForKey:@"Comments_Num"] stringValue];
    dynamic.zan_count = [(NSNumber*)[obj objectForKey:@"Zan_Num"] stringValue];
    dynamic.reposts_status = [obj objectForKey:@"Repost"];
    dynamic.pic_urls = [obj objectForKey:@"ImageURL"];
    dynamic.zanList = [[obj objectForKey:@"ZanList"] mutableCopy];
    dynamic.headURL = [user objectForKey:@"HeadURL"];
    dynamic.recordURL = [obj objectForKey:@"RecordURL"];
    dynamic.created_at = [obj objectForKey:@"createdAt"];
    dynamic.contentText = [obj objectForKey:@"Contents"];
    dynamic.recordDuration = [obj objectForKey:@"RecordDuration"];
    dynamic.bmobObjext = obj;
    return dynamic;
}



-(NSString *)created_at{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-ddHH:mm:ss";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSDate *weiboDate = [formatter dateFromString:_created_at];
    //得到距1970年秒数
    long weiboTime = [weiboDate timeIntervalSince1970];
    //    得到当前时间距1970年秒数
    long nowTime = [[NSDate new] timeIntervalSince1970];
    long time = nowTime - weiboTime;
    //判断是否在1分钟内
    if (time<=60) {
        return @"刚刚";
    }else if (time>60&&time<=3600) {
        return [NSString stringWithFormat:@"%ld分钟前",time/60];
    }else if (time>3600&&time<=3600*24) {//判断一天内
        return [NSString stringWithFormat:@"%ld小时前",time/3600];
    }else{
        //        显示具体日期
        formatter.dateFormat = @"MM-dd";
        return [formatter stringFromDate:weiboDate];
    }
}
#pragma mark -  NSCoding
//// 返回self的所有对象名称
//+(NSArray *)propertyOfSelf{
//    unsigned int count;
//    
//    // 1. 获得类中的所有成员变量
//    Ivar *ivarList = class_copyIvarList(self, &count);
//    
//    NSMutableArray *properNames =[NSMutableArray array];
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = ivarList[i];
//        
//        // 2.获得成员属性名
//        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        
//        // 3.除去下划线，从第一个角标开始截取
//        NSString *key = [name substringFromIndex:1];
//        
//        [properNames addObject:key];
//    }
//    
//    return [properNames copy];
//}
//
//
//// 归档
//- (void)encodeWithCoder:(NSCoder *)enCoder{
//    // 取得所有成员变量名
//    NSArray *properNames = [[self class] propertyOfSelf];
//    
//    for (NSString *propertyName in properNames) {
//        // 创建指向get方法
//        SEL getSel = NSSelectorFromString(propertyName);
//        // 对每一个属性实现归档
//        [enCoder encodeObject:[self performSelector:getSel] forKey:propertyName];
//    }
//}
//
//// 解档
//- (id)initWithCoder:(NSCoder *)aDecoder{
//    // 取得所有成员变量名
//    NSArray *properNames = [[self class] propertyOfSelf];
//    
//    for (NSString *propertyName in properNames) {
//        // 创建指向属性的set方法
//        // 1.获取属性名的第一个字符，变为大写字母
//        NSString *firstCharater = [propertyName substringToIndex:1].uppercaseString;
//        // 2.替换掉属性名的第一个字符为大写字符，并拼接出set方法的方法名
//        NSString *setPropertyName = [NSString stringWithFormat:@"set%@%@:",firstCharater,[propertyName substringFromIndex:1]];
//        SEL setSel = NSSelectorFromString(setPropertyName);
//        [self performSelector:setSel withObject:[aDecoder decodeObjectForKey:propertyName]];
//    }
//    return  self;
//}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        Class c = self.class;
        // 截取类和父类的成员变量
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {
                
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
                
                id value = [aDecoder decodeObjectForKey:key];
                
                [self setValue:value forKey:key];
                
            }
            // 获得c的父类
            c = [c superclass];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            id value = [self valueForKey:key];
            
            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
    }
    
}
@end
