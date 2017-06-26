//
//  Utils.m
//  LanYiEnglish
//
//  Created by tarena on 16/11/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(BOOL)checkingString:(NSString *)string{
    //去掉文本两端空格和换行符
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //判断长度是否大于0
    if (newString.length==0) {
        return NO;
    }
    
    return YES;
}

//毛玻璃
+(UIImageView*)glassImageViewWithImage:(UIImage*)image andAlpha:(CGFloat)alpha{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    imageView.image = image;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *ve = [[UIVisualEffectView alloc]initWithEffect:effect];
    ve.frame = imageView.bounds;
    ve.alpha = alpha;
    [imageView addSubview:ve];
    return imageView;
}

+(UIImageView*)extraLightglassImageViewWithImage:(UIImage*)image andAlpha:(CGFloat)alpha{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    imageView.image = image;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *ve = [[UIVisualEffectView alloc]initWithEffect:effect];
    ve.frame = imageView.bounds;
    ve.alpha = alpha;
    [imageView addSubview:ve];
    return imageView;
}

+(UIImageView*)darkGlassImageViewWithImage:(UIImage*)image andAlpha:(CGFloat)alpha{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    imageView.image = image;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *ve = [[UIVisualEffectView alloc]initWithEffect:effect];
    ve.frame = imageView.bounds;
    ve.alpha = alpha;
    [imageView addSubview:ve];
    return imageView;
    
}

//匹配表情
+(void)faceMappingWithText:(YYTextView *)tv{
    
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    
    NSMutableDictionary *mapperDic = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"];
    NSArray *faceArr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *faceDic in faceArr) {
        
        NSString *imageName = faceDic[@"png"];
        NSString *text = faceDic[@"chs"];
        
        [mapperDic setObject:[UIImage imageNamed:imageName] forKey:text];
        
        
    }
    
    
    parser.emoticonMapper = mapperDic;
    
    tv.textParser = parser;
}

+(void)runAnimationWithImageView:(UIImageView *)imageView imageFileName:(NSString *)fileName imageCount:(NSInteger)imageCount speed:(CGFloat)speed{
    NSMutableArray *allImages = [NSMutableArray array];
    for (NSInteger i = 0; i < imageCount; i++) {
        //拼接图片的名称
        NSString *imageName = [NSString stringWithFormat:@"%@%02ld",fileName,i+1];
        //创建图片对象
        UIImage *image = [UIImage imageNamed:imageName];
        //将创建好的图片 添加到数组中
        [allImages addObject:image];
    }
    //设置 动画所需图片 （需要的是一个图片数组）
    imageView.animationImages = allImages;
    //设置动画的时长  （一次多长时间）
    imageView.animationDuration = speed * imageCount;
    //设置动画运行次数   值为0 是无限运行
    imageView.animationRepeatCount = 0;
    //运行动画
    [imageView startAnimating];
    
    if (imageView.animationRepeatCount != 0) {
        //动画运行完 要释放动画数组
        //获取动画总时间
        CGFloat afterDelay = imageView.animationDuration * imageView.animationRepeatCount;
        //等待 afterDelay 时间后 向 self.npcImageView 发送setAnimationImages 消息 并把 nil 做为参数传给 setAnimationImages 方法
        [imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:afterDelay];
    }

}

//图片画圆
+(UIImage*)drawImage:(UIImage*)image drawRect:(CGRect)rect andLineWidth:(CGFloat)width andStrokeColor:(UIColor*)color{
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    //裁切
    //裁切范围
    //以下两种方法都可以
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = width;
    [path stroke];
    [path addClip];
    //绘制图片
    [image drawInRect:rect];
    //从上下文中获得裁切好的图片
    UIImage *imageNew=UIGraphicsGetImageFromCurrentImageContext();
//    //关闭图片上下文
    UIGraphicsEndImageContext();
    return imageNew;
    
}

//获取用户信息

@end
