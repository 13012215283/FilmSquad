//
//  CZWebUtils.h
//  FilmSquad
//
//  Created by 陈卓 on 17/2/22.
//  Copyright © 2017年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

//回调Block
typedef void (^MyCallback)(id obj);

typedef void (^MyCallbackDetailAndActors)(id filmDetial,id filmPotos,id actors);

@interface CZWebUtils : NSObject

+(void)requestHotFilmsInfoWithCompletion:(MyCallback)callback;
+(void)requestHotFilmsDetailAndActorsWithFilmId:(NSString*)filmId WithCompletion:(MyCallbackDetailAndActors)callback;
@end
