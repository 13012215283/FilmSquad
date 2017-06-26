//
//  EmotionCollectionView.h
//  LanYiEnglish
//
//  Created by tarena_cz on 16/11/10.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionCollectionView;
@protocol EmotionCollectionViewDelegate <NSObject>
-(void)EmotionCollectionView:(EmotionCollectionView*)collectionView selectEmotion:(NSDictionary*)emotion;
@end

@interface EmotionCollectionView : UICollectionView
@property(nonatomic,strong) id<EmotionCollectionViewDelegate> cz_delegate;
@end
