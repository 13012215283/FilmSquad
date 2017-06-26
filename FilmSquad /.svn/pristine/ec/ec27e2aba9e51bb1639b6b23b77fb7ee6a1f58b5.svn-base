//
//  CZ_Control.m
//  CZEnglish
//
//  Created by 陈卓 on 16/11/19.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CZ_Control.h"

@implementation CZ_Control

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
        self.imageView.center = CGPointMake(frame.size.width/2-self.imageView.frame.size.width/2, frame.size.height/2);
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame), self.imageView.frame.origin.y, frame.size.width/2, frame.size.height*0.8)];
        self.titleLabel.font = YuanFont(12);
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

#pragma mark - 重写set方法
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.imageView.frame = CGRectMake(0, 0, frame.size.height*0.8, frame.size.height*0.8);
    self.imageView.center = CGPointMake(frame.size.width/2-self.imageView.frame.size.width/2, frame.size.height/2);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), self.imageView.frame.origin.y, frame.size.width/2, frame.size.height*0.8);
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
