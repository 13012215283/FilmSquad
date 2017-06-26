//
//  pictureCell.h
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pictureCell;
@protocol pictureCellDelegate <NSObject>

-(void)deletePictureCell:(pictureCell*)item;

@end

@interface pictureCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *addImageView;
@property(nonatomic,strong) UIButton *deleteButton;
@property(nonatomic,strong) id<pictureCellDelegate> cz_delegate;
@end
