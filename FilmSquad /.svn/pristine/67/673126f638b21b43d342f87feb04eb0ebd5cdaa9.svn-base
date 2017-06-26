//
//  pickPictureCollectionView.m
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "pickPictureCollectionView.h"
#import "pictureCell.h"
@interface pickPictureCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,pictureCellDelegate>

@end

@implementation pickPictureCollectionView

#pragma mark - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[pictureCell class] forCellWithReuseIdentifier:@"pictureItem"];
        [self setupCollectionView];
    }
    return self;
}

#pragma mark - 设置collectionView
-(void)setupCollectionView{
    self.backgroundColor = kWhiteColor;
    self.alwaysBounceHorizontal = YES;
}
#pragma mark - pictureCell代理方法
-(void)deletePictureCell:(pictureCell *)item{
    NSIndexPath *indexPath = [self indexPathForCell:item];
    [self.allPictures removeObjectAtIndex:indexPath.item];
    [self deleteItemsAtIndexPaths:@[indexPath]];
    [self.cz_delegate pickPictureCollectionView:self DidDeleteItemAtIndexpath:indexPath];
}
#pragma mark - collectionView代理方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allPictures.count+1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    pictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureItem" forIndexPath:indexPath];
    if(indexPath.item == self.allPictures.count){
        cell.imageView.image = nil;
        cell.addImageView.hidden = NO;
        cell.deleteButton.hidden = YES;

    }else{
        cell.imageView.image = self.allPictures[indexPath.item];
        cell.addImageView.hidden = YES;
        cell.deleteButton.hidden = NO;
    }
    cell.cz_delegate = self;
    return cell;
}

//选择Item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item == self.allPictures.count){
        [self.cz_delegate pickPictureCollectionViewAddImage];
    }
}


#pragma mark - collectionViewFlowLayout代理方法

#define ITEM_COUNT 3
#define PROPORTION 20
#define WIDTH self.bounds.size.width

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH-WIDTH/PROPORTION*(ITEM_COUNT+1))/ITEM_COUNT, (WIDTH-WIDTH/PROPORTION*(ITEM_COUNT+1))/ITEM_COUNT);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(WIDTH/PROPORTION,WIDTH/PROPORTION,WIDTH/PROPORTION,WIDTH/PROPORTION);
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return WIDTH/PROPORTION-1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return WIDTH/PROPORTION-1;
}




//#pragma mark - touch方法
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    [[self nextResponder] touchesBegan:touches withEvent:event];
//}


@end
