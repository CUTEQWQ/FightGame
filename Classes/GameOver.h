//
//  GameOver.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/4
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "Message.h"

// -----------------------------------------------------------------

@interface GameOver : CCLayout <MessageDelegate>
{
    BOOL win;
    CCSprite *gameOverWin;
    CCSprite *gameOverLose;
    CCButton *exitBtn;
    CCButton *againBtn;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(void)setWin:(BOOL)isWin;
-(void)exit;
-(CCButton*)getAgainBtn;
//-(void)again;
// -----------------------------------------------------------------

@end




