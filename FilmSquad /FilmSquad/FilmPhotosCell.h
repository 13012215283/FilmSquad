//
//  FilmPhotosCell.h
//  FilmSquad
//
//  Created by 陈卓 on 17/3/6.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZ_pickCarScrollView.h"
@interface FilmPhotosCell : UITableViewCell
@property (nonatomic,strong) CZ_pickCarScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *allImagesUrl;
@end
