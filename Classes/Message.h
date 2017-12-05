//
//  Message.h
//  FightGame
//
//  Created by 陈倩文 on 2017/12/4.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"

@protocol MessageDelegate
-(void)sendMessage:(NSString*)key Sender:(CCNode*)_sender Receiver:(CCNode*)_receiver;
@end

@interface Message : CCNode{
    id<MessageDelegate> m_Delegate;
}
@property(assign, nonatomic)id<MessageDelegate> m_delegate;

-(void)send;
@end
