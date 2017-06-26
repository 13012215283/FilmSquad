//
//  CZActorsCellTableViewCell.m
//  FilmSquad
//
//  Created by zol on 2017/3/16.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "CZActorsCellTableViewCell.h"
#import "CollectionViewCell.h"
@implementation CZActorsCellTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.flowLaout = [[UICollectionViewFlowLayout alloc]init];
        self.flowLaout.scrollDirection            = UICollectionViewScrollDirectionHorizontal;
        self.actorsCollectionView                 = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLaout];
        self.actorsCollectionView.delegate        = self;
        self.actorsCollectionView.dataSource      = self;
        self.actorsCollectionView.backgroundColor = [UIColor whiteColor];
        self.actorsCollectionView.showsHorizontalScrollIndicator = NO;
        [self.actorsCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"actorCell"];
        [self.contentView addSubview:self.actorsCollectionView];
        [self masonry];
    }
    return self;
}
#pragma mark - 布局
-(void)masonry{
    [self.actorsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
#pragma mark - collectionView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allActorInfo.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"actorCell" forIndexPath:indexPath];
    item.actor               = self.allActorInfo[indexPath.row];
    return item;
}

#pragma mark - collectionViewFlowLayout代理方法

#define ITEM_COUNT 3
#define Interval 10

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%f",collectionView.bounds.size.width);
    return CGSizeMake((collectionView.bounds.size.width - Interval*(ITEM_COUNT+1))/ITEM_COUNT, collectionView.bounds.size.height - 2*Interval);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(Interval, Interval, Interval, Interval);
}
//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return Interval;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return Interval;
}

@end
