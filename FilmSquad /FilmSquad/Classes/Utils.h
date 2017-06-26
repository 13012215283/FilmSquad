//
//  Utils.h
//  LanYiEnglish
//
//  Created by tarena on 16/11/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYTextView.h"
#import <objc/runtime.h>
@interface Utils : NSObject
//检查字符串
+(BOOL)checkingString:(NSString *)string;

//添加白色毛玻璃
+(UIImageView*)glassImageViewWithImage:(UIImage*)image andAlpha:(CGFloat)alpha;
//添加加强白色毛玻璃
+(UIImageView*)extraLightglassImageViewWithImage:(UIImage*)image andAlpha:(CGFloat)alpha;

//添加黑色毛玻璃
+(UIImageView*)darkGlassImageViewWithImage:(UIImage*)image andAlpha:(CGFloat)alpha;

//匹配表情
+(void)faceMappingWithText:(YYTextView *)tv;

//imageView动画
+(void)runAnimationWithImageView:(UIImageView*)imageView imageFileName:(NSString*)fileName imageCount:(NSInteger)imageCount speed:(CGFloat)speed;

//图片画圆
+(UIImage*)drawImage:(UIImage*)image drawRect:(CGRect)rect andLineWidth:(CGFloat)wideth andStrokeColor:(UIColor*)color;
@end
