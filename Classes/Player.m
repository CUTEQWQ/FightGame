//
//  Player.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/5
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Player.h"

// -----------------------------------------------------------------

@implementation Player

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
    
    //init player
    [self initMyPara];
    m_scale = 0.3f;
    
    m_entity = [CCSprite spriteWithImageNamed:@"beararmmove.png"];
    [m_entity setScale:m_scale];
    [m_entity setPosition:[MapEdittor GeneratePosition:m_entity Scale:m_scale]];
    [self addChild:m_entity];
    
    return self;
}
-(void)mirror:(BOOL)flip Dir:(CGPoint)dir{
    m_entity.flipX = flip;
    if (dir.x > 0) {
        left = NO;
    }else{
        left = YES;
    }
}
-(BOOL)getTowardsLeft{
    return left;
}
// -----------------------------------------------------------------

@end





