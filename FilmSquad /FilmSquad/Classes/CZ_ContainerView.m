//
//  CZ_ContainerView.m
//  CZEnglish
//
//  Created by tarena_cz on 16/11/18.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZ_ContainerView.h"

@implementation CZ_ContainerView

#pragma mark - 初始化
-(instancetype)init{
    if(self = [super init]){
        self.textView = [[YYTextView alloc]init];
        self.textView.font = YuanFont(14);
        [Utils faceMappingWithText:self.textView];
        self.textView.userInteractionEnabled = NO;
        
        self.pv = [[PhotosView alloc]init];

        [self addSubview:self.pv];
        [self addSubview:self.textView];
        [self addSubview:self.reContainerView];
        
        
    }
    return self;
}
#pragma mark set方法
-(void)setDynamicFrame:(DynamicFrame *)dynamicFrame{
    _dynamicFrame = dynamicFrame;
    [self setFrameForAll];
    [self setDataForAll];
}

#pragma mark - 设置frame
-(void)setFrameForAll{
    
    if(!self.reContainerView){
        self.reContainerView = [[CZ_ContainerView alloc]init];
        [self addSubview:self.reContainerView];
    }
    self.reContainerView.backgroundColor = kWhiteColor;
    
    //设置图片大小的参数并传给转发的容器
    self.pv.divCount = self.dynamicFrame.divCount;
    self.reContainerView.pv.divCount = self.pv.divCount;
    
    
    [self.reContainerView.pv removeAllImageView];   //清空内容，防止复用出问题
    self.reContainerView.textView.text = @"";       //清空内容，防止复用出问题
    
    self.textView.frame = self.dynamicFrame.textViewF;
    self.pv.frame = self.dynamicFrame.photosViewF;
    self.reContainerView.frame = self.dynamicFrame.reContainerViewF;
    
    //传入数据模型，让reContainerView 设置子视图
    if(self.dynamicFrame.reDynamicFrame){
        self.reContainerView.dynamicFrame = self.dynamicFrame.reDynamicFrame;
    }
}

#pragma mark - 设置data
-(void)setDataForAll{
    Dynamic *dynamic = self.dynamicFrame.dynamic;
    self.textView.text = dynamic.contentText;
    
    [self.pv removeAllImageView];
    self.pv.pic_urls = dynamic.pic_urls;
    
}


#pragma mark - copy协议
-(id)copyWithZone:(NSZone *)zone{
    CZ_ContainerView *cv = [[CZ_ContainerView allocWithZone:zone]init];
    cv.dynamicFrame = self.dynamicFrame;
    return cv;
}

@end














