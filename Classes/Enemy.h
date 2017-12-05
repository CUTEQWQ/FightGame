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

// -----------------------------------------------------------------

@interface Enemy : CCSprite{
    int enemyType;
    CCSprite* m_enemy;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(CGPoint)getPosition;
-(CGRect)getBoundingBox;

// -----------------------------------------------------------------

@end




