//
//  FilmPhotosCell.m
//  FilmSquad
//
//  Created by 陈卓 on 17/3/6.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "FilmPhotosCell.h"

@implementation FilmPhotosCell
//加载pickCardScollView
-(CZ_pickCarScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[CZ_pickCarScrollView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kWIDTH*0.618) andImages:self.allImagesUrl];
        _scrollView.backgroundColor = [UIColor whiteColor];
        
    }
    return _scrollView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

-(void)setAllImagesUrl:(NSMutableArray *)allImagesUrl{
    _allImagesUrl = allImagesUrl;
    self.scrollView.allImages = allImagesUrl;
    [self.scrollView setDefaultImageForAllSubView];
}

@end
