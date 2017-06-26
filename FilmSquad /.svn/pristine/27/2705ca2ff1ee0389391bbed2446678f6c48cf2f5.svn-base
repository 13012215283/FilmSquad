//
//  Repost.m
//  CZEnglish
//
//  Created by 陈卓 on 16/11/20.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "Repost.h"

@implementation Repost
+(NSArray *)getAllRepostArrayFromArray:(NSArray *)array{
    NSMutableArray *allRepost = [[NSMutableArray alloc]init];
    for(BmobObject *obj in array){
        Repost *repost = [[Repost alloc]init];
        repost.user = [obj objectForKey:@"User"];
        repost.headURL = [repost.user objectForKey:@"HeadURL"];
        repost.name = [repost.user objectForKey:@"Nick"];
        repost.created_at = [obj objectForKey:@"createdAt"];
        repost.bmobObjext = obj;
        repost.contentText = [obj objectForKey:@"Contents"];
        [allRepost addObject:repost];
    }
    return allRepost;
    
}
#pragma mark - NSCoding
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
