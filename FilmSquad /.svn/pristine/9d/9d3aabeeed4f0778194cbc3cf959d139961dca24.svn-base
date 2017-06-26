//
//  EmotionCollectionView.m
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "EmotionCollectionView.h"
#import "EmotionCell.h"


#define ITEM_COUNT 8
#define PROPORTION 30
#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height
@interface EmotionCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) NSMutableArray *faceArray;
@end


@implementation EmotionCollectionView
#pragma mark - 懒加载
-(NSMutableArray *)faceArray{
    if(!_faceArray){
        _faceArray = [[NSMutableArray alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"];
        _faceArray = [[NSArray arrayWithContentsOfFile:path] mutableCopy];
    }
    return _faceArray;
}
#pragma mark - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[EmotionCell class] forCellWithReuseIdentifier:@"pictureItem"];
        [self setupCollectionView];
    }
    return self;
}

#pragma mark - 设置collectionView
-(void)setupCollectionView{
    self.backgroundColor = kWhiteColor;
    self.showsHorizontalScrollIndicator = NO;
}

#pragma mark - collectionView代理方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.faceArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureItem" forIndexPath:indexPath];
    cell.emotionDic = self.faceArray[indexPath.section*50+indexPath.item];
    cell.imageView.image = [UIImage imageNamed:cell.emotionDic[@"png"]];

    return cell;
}

//选择Item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EmotionCell *cell = (EmotionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self.cz_delegate EmotionCollectionView:self selectEmotion:cell.emotionDic];
}


#pragma mark - collectionViewFlowLayout代理方法

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




@end
