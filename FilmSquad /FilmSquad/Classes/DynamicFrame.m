//
//  DynamicFrame.m
//  CZEnglish
//
//  Created by tarena_cz on 16/11/18.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "DynamicFrame.h"
#import "YYTextView.h"

@implementation DynamicFrame
#pragma mark - 懒加载
//若没有值，返回默认值3
-(CGFloat)divCount{
    if(_divCount == 0){
        _divCount = 3;
    }
    return _divCount;
}

#pragma mark - set方法计算所有frame

-(void)setDynamic:(Dynamic *)dynamic{
    _dynamic = dynamic;
    
    //判断是否有转发并设置转发内容的Frame
    if(_dynamic.reposts_status){
        self.reDynamicFrame = [[DynamicFrame alloc]init];
        self.reDynamicFrame.dynamic = _dynamic.reposts_status;
    }
    
    //设置间隙
    self.padding = 8;
    
    //设置头像的frame
    self.headerImageViewF = CGRectMake(self.padding, self.padding, kWIDTH/10,kWIDTH/10);
    
    //设置名字的frame
    self.nameLabelF = CGRectMake(CGRectGetMaxX(self.headerImageViewF)+self.padding, self.headerImageViewF.origin.y, kWIDTH*0.6, self.headerImageViewF.size.height/2);
    
    //设置时间的frame
    self.timeLabelF = CGRectMake(self.nameLabelF.origin.x, CGRectGetMaxY(self.nameLabelF), self.nameLabelF.size.width,self.nameLabelF.size.height);
    
    //设置主题的frame
    YYTextView *tv = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 0)];
    [Utils faceMappingWithText:tv];
    tv.font = YuanFont(15);
    tv.text = _dynamic.title;
    
    
    CGFloat titleHeight = [tv.text isEqualToString:@""]?0:tv.textLayout.textBoundingSize.height;

    self.titleTextViewF = CGRectMake(0,CGRectGetMaxY(self.headerImageViewF)+self.padding, kWIDTH,titleHeight);
    
    //设置正文的frame
    YYTextView *tv2 = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH-2*self.padding, 0)];
    [Utils faceMappingWithText:tv2];
    tv2.font = YuanFont(15);
    tv2.text = _dynamic.contentText;
    CGFloat textHeight = [tv2.text isEqualToString:@""]?0:tv2.textLayout.textBoundingSize.height;
    self.textViewF = CGRectMake(self.padding, 0, kWIDTH-2*self.padding,textHeight);
    
    //设置图片的frame
    self.photosViewF = CGRectMake(self.padding,CGRectGetMaxY(self.textViewF),kWIDTH-2*self.padding,[self imageHeight]);
    
    //设置转发容器Frame
    self.reContainerViewF = CGRectMake(0, CGRectGetMaxY(self.photosViewF), kWIDTH, self.reDynamicFrame.containerViewF.size.height);
    
    //容器Frame
    self.containerViewF = CGRectMake(0, CGRectGetMaxY(self.titleTextViewF), kWIDTH,self.textViewF.size.height+self.photosViewF.size.height+self.reContainerViewF.size.height);
    
    //设置底部Bar
    self.bottomBarF = CGRectMake(0, CGRectGetMaxY(self.containerViewF)+self.padding, kWIDTH,self.bottomBarHidden?0:self.headerImageViewF.size.height*0.8);
    
    //设置播放语音按钮
    self.playControlF = CGRectMake(0, 0, self.bottomBarF.size.width/5, self.bottomBarF.size.height);
    //设置转发按钮
    self.repostControlF = CGRectMake(self.bottomBarF.size.width/5*2, 0, self.bottomBarF.size.width/5, self.bottomBarF.size.height);
    //设置评论按钮
    self.commentContolF = CGRectMake(self.bottomBarF.size.width/5*3, 0, self.bottomBarF.size.width/5, self.bottomBarF.size.height);
    //设置点赞按钮
    self.zanControlF = CGRectMake(self.bottomBarF.size.width/5*4, 0, self.bottomBarF.size.width/5, self.bottomBarF.size.height);
    //设置顶部右上角按钮
    self.topButtonF = CGRectMake(kWIDTH- self.headerImageViewF.size.height-self.padding, self.padding, self.headerImageViewF.size.height,[self.topButtoImageName isEqualToString:@""]?0:self.headerImageViewF.size.height);
    
    //设置顶部分割线
    self.topSeparatViewF = CGRectMake(self.padding,CGRectGetMaxY(self.headerImageViewF)+self.padding*0.5,kWIDTH-2*self.padding, 1);
    
    //设置底部分割线
    self.bottomSeparatViewF = CGRectMake(self.padding,0,kWIDTH-2*self.padding, 1);

}

#pragma mark - 获得显示图片所需高度
-(float)imageHeight{
    //宫格式图片的大小
    float size = ([UIScreen mainScreen].bounds.size.width-2*8-10)/self.divCount;
    if (self.dynamic.pic_urls.count==1){
        return 2*size;
    }else if (self.dynamic.pic_urls.count>1&&self.dynamic.pic_urls.count<=3){
        return size;
    }else if (self.dynamic.pic_urls.count>3&&self.dynamic.pic_urls.count<=6){
        return 2*size+5;
    }else if (self.dynamic.pic_urls.count>6&&self.dynamic.pic_urls.count<=9){
        return 3*size+2*5;
    }
    return 0;
}



#pragma mark - 通过文本获取宽高
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

#pragma mark - 得到总高度
-(CGFloat)getTotalHeight{
    CGFloat height = self.headerImageViewF.size.height + +self.titleTextViewF.size.height + self.containerViewF.size.height + self.bottomBarF.size.height + 3*self.padding;

    if(self.bottomPaddingHidden){
        return height;
    }
    return height+self.padding;
}

#pragma mark -  NSCoding
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
