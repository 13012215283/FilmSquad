//
//  CZ_ImageViewForScrollView.h
//  狼人小分队
//
//  Created by 陈卓 on 16/10/4.
//  Copyright © 2016年 陈卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZ_ImageViewForScrollView : UIImageView
@property(nonatomic,assign,getter=isSelected) BOOL state;
@property(nonatomic,strong) NSURL *imageUrl;
@end
