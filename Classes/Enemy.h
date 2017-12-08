//
//  Enemy.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/3
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MapEdittor.h"
#import "Entity.h"
#import "Player.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------

@interface Enemy : Entity{
    int enemyType;
    CCLabelTTF *show;
    Player* m_player;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node:(Player*)player;
- (instancetype)initWithPlayer:(Player*)player;
-(void)collisionWithPlayer;
// -----------------------------------------------------------------

@end




