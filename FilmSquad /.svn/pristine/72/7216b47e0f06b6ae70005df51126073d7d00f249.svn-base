//
//  PhotosView.m
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/11.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "PhotosView.h"
#import <UIImageView+AFNetworking.h>
@implementation PhotosView

#pragma mark - 懒加载
-(NSMutableArray<UIImageView *> *)allImageView{
    if(!_allImageView){
        _allImageView = [[NSMutableArray alloc]init];
    }
    return _allImageView;
}


-(void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    [self removeAllImageView];
    float size = (kWIDTH-2*8-10)/self.divCount;
    if (pic_urls.count==1) {
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2*size, 2*size)];
        
        [iv sd_setImageWithURL:[NSURL URLWithString:pic_urls[0]] placeholderImage:[UIImage imageNamed:@"Picture"]];

        [self addSubview:iv];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        //超出内容不显示
        iv.clipsToBounds = YES;
        iv.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage:)];
        
        [iv addGestureRecognizer:gesture];
        [self.allImageView addObject:iv];
        
    }
    else if(pic_urls.count==4){
        for (int i=0; i<4; i++) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i%2*(size+5), i/2*(size+5), size, size)];
            [iv setImageWithURL:[NSURL URLWithString:pic_urls[i]] placeholderImage:[UIImage imageNamed:@"Picture"]];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            //超出内容不显示
            iv.clipsToBounds = YES;
            [self addSubview:iv];
            
            iv.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage:)];
            [iv addGestureRecognizer:tap];
            iv.userInteractionEnabled = YES;
        }
    }
    else{//多张
        for (int i=0; i<pic_urls.count; i++) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i%3*(size+5), i/3*(size+5), size, size)];
            [iv setImageWithURL:[NSURL URLWithString:pic_urls[i]] placeholderImage:[UIImage imageNamed:@"Picture"]];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            //超出内容不显示
            iv.clipsToBounds = YES;
            [self addSubview:iv];
            
            iv.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage:)];
            [iv addGestureRecognizer:tap];
            iv.userInteractionEnabled = YES;

        }
    }
    
    
}
#pragma mark - 清空图片
-(void)removeAllImageView{
    for (UIImageView *iv in self.subviews) {
        [iv removeFromSuperview];
    }
}

#pragma mark - 展示大照片
-(void)showImage:(UIGestureRecognizer*)sender{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.pic_urls.count; // 图片总数
    browser.currentImageIndex = sender.view.tag;
    browser.delegate = self;
    [browser show];

}


// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.pic_urls[index];
    //   urlStr = [urlStr stringByReplacingOccurrencesOfString:@"small" withString:@"big"];
    return [NSURL URLWithString:urlStr];
}

@end
