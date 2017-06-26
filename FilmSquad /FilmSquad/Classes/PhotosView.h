//
//  PhotosView.h
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/11.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosView : UIView<SDPhotoBrowserDelegate>
@property (nonatomic, strong)NSArray *pic_urls;
@property (nonatomic,assign) CGFloat divCount;  //一个参数用于设置图片大小
@property (nonatomic,strong) NSMutableArray<UIImageView*> *allImageView;

-(void)removeAllImageView;
@end
