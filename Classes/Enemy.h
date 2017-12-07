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

// -----------------------------------------------------------------

@interface Enemy : Entity{
    int enemyType;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

// -----------------------------------------------------------------

@end




