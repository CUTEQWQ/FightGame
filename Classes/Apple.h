//
//  Apple.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/8
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "MapEdittor.h"
#import "Player.h"
// -----------------------------------------------------------------
//increase player's live, can be ate
@interface Apple : Entity{
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




