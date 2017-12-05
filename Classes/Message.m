//
//  Message.m
//  FightGame
//
//  Created by 陈倩文 on 2017/12/4.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "Message.h"

@implementation Message

-(void)send{
    CCNode* s;
    CCNode* r;
    [m_Delegate sendMessage:@"cqw" Sender:s Receiver:r];
}
@end
