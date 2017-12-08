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
#import "Enemy.h"
#import "MapEdittor.h"

// -----------------------------------------------------------------

@interface Block : Entity{
    Player *m_player;
    Enemy *m_enemy;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node:(Enemy*)enemy;
- (instancetype)initWithEnemy:(Enemy*)enemy;
-(void)setPlayer:(Player*)player;
-(void)instantiatePosition:(CGPoint)position;
-(void)keepPositionWithPlayer:(Player*)player;
-(void)collisionWithEnemy;
// -----------------------------------------------------------------

@end




