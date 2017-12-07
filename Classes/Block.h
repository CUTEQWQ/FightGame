//
//  Block.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/6
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "Player.h"

// -----------------------------------------------------------------

@interface Block : Entity{
    Player *m_player;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(void)setPlayer:(Player*)player;
-(void)instantiatePosition:(CGPoint)position;
-(void)keepPositionWithPlayer:(Player*)player;
// -----------------------------------------------------------------

@end




