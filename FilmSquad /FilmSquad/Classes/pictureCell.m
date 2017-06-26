//
//  pictureCell.m
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "pictureCell.h"

@implementation pictureCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imageView];
        
        self.addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width*0.6, frame.size.height*0.6)];
        self.addImageView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        self.addImageView.image = [UIImage imageNamed:@"Screenshot"];
        [self addSubview:self.addImageView];
        
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/5, frame.size.width/5)];
        self.deleteButton.center = CGPointMake(frame.size.width, 0);
        self.deleteButton.layer.cornerRadius = frame.size.width/5/2;
        self.deleteButton.layer.masksToBounds = YES;
        [self.deleteButton setImage:[UIImage imageNamed:@"Xion"] forState:(UIControlStateNormal)];
        [self.deleteButton addTarget:self action:@selector(deldeteItem) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.deleteButton];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)deldeteItem{
    [self.cz_delegate deletePictureCell:self];
}

@end
