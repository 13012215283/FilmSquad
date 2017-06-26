
//
//  EmotionCell.m
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "EmotionCell.h"

@implementation EmotionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imageView];
    }
    return self;
}
@end
