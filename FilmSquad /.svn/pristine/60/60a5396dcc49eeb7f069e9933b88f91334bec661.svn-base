//
//  pickPictureCollectionView.h
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pickPictureCollectionView;
@protocol pickPictureCollectionViewDelegate <NSObject>
-(void)pickPictureCollectionViewAddImage;
-(void)pickPictureCollectionView:(pickPictureCollectionView*)collectionView DidDeleteItemAtIndexpath:(NSIndexPath*)indexPath;


@end

@interface pickPictureCollectionView : UICollectionView
@property(nonatomic,strong) NSMutableArray *allPictures;
@property(nonatomic,weak) id<pickPictureCollectionViewDelegate> cz_delegate;
@end
