//
//  CZSearchResultsViewController.h
//  FilmSquad
//
//  Created by 陈卓 on 16/12/20.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZSearchResultsViewController;
@protocol CZSearchResultsViewControllerDelegate  <NSObject>

-(void)czSearchResultsViewContoller:(CZSearchResultsViewController*)resultsViewController didFinishedSearchUsers:(NSMutableArray*)searchReults;


@end

@interface CZSearchResultsViewController : UIViewController
@property (nonatomic,strong) NSString *searchContents;
@property (nonatomic,weak)   id <CZSearchResultsViewControllerDelegate> cz_delegate;
@end
