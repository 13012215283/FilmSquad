//
//  parseChattingMessage.m
//  FilmSquad
//
//  Created by 陈卓 on 17/2/19.
//  Copyright © 2017年 cz. All rights reserved.
//

#import "parseChattingMessage.h"
#import <YYTextView.h>
@implementation parseChattingMessage
+(NSArray*)parseChattingCellHeightWithMessageArray:(NSArray*)messages{
    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:messages.count];
    
    for (EMMessage* m in messages) {
        id<IEMMessageBody> msgBody = m.messageBodies.firstObject;
        switch ((int)msgBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                YYTextView* textContent = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, BubbleWidth-4*kSpacing, 0)];
                [Utils faceMappingWithText:textContent];
                textContent.font = YuanFont(14);
                textContent.text = ((EMTextMessageBody *)msgBody).text;
                CGFloat height = textContent.textLayout.textBoundingSize.height;
                [arr addObject:@(height)];
            }
                break;
            case eMessageBodyType_Image:
            {
                [arr addObject:@(BubbleWidth*0.6)];
            }
                break;
            case eMessageBodyType_Voice:
            {
                [arr addObject:@(44)];
            }
                break;
        }
    }
    return arr;
    
}

+(NSNumber*)parseChattingCellHeightWithMessage:(EMMessage*)message{
    
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            YYTextView* textContent = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, BubbleWidth-4*kSpacing, 0)];
            textContent.font = YuanFont(14);
            [Utils faceMappingWithText:textContent];
            textContent.text = ((EMTextMessageBody *)msgBody).text;
            CGFloat height = textContent.textLayout.textBoundingSize.height;
            return @(height);
        }
            break;
        case eMessageBodyType_Image:
        {
            return @(BubbleWidth*0.6);
        }
            break;
        case eMessageBodyType_Voice:
        {
            return @(44);
        }
            break;
    }
    return @(0);
    
}

@end
