//
//  Enemy.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/3
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Enemy.h"

// -----------------------------------------------------------------

@implementation Enemy

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    //for the first test
    enemyType = 0;
    
    switch (enemyType) {
        case 0:
            m_enemy = [CCSprite spriteWithImageNamed:@"waitingpenguin.png"];
            break;
            
        default:
            break;
    }
    [m_enemy setPosition:[MapEdittor GeneratePosition:m_enemy Scale:0.5f]];
    [m_enemy setScale:0.5f];
    
    [self addChild:m_enemy];
    
    
    return self;
}

-(CGPoint)getPosition{
    return m_enemy.position;
}
-(CGRect)getBoundingBox{
    return m_enemy.boundingBox;
}
// -----------------------------------------------------------------

@end





