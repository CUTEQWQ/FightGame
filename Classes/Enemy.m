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
    
    //for test
    enemyType = 0;
    
    //init enemy
    [self initMyPara];
    m_scale = 0.5f;
    
    switch (enemyType) {
        case 0:
            m_entity = [CCSprite spriteWithImageNamed:@"waitingpenguin.png"];
            break;
            
        default:
            break;
    }
    [m_entity setPosition:[MapEdittor GeneratePosition:m_entity Scale:m_scale]];
    printf("enemy:%f,%f\n",m_entity.position.x,m_entity.position.y);
    [m_entity setScale:m_scale];
    [self addChild:m_entity];
    
    
    return self;
}
// -----------------------------------------------------------------

@end





