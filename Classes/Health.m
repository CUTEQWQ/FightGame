//
//  Health.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/3
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Health.h"

// -----------------------------------------------------------------

@implementation Health

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
    
    hp = 100.0f;
    
    bar = [CCSprite spriteWithImageNamed:@"bar_small.png"];
    [self addChild:bar];
    
    blood = [CCSprite spriteWithImageNamed:@"blood_small.png"];
    progress = [CCProgressNode progressWithSprite:blood];
    [progress setType:CCProgressNodeTypeBar];
    [progress setBarChangeRate:CGPointMake(1, 0)];
    progress.midpoint = ccp(0.0, 0.0);
    [progress setPercentage:hp];
    [self addChild:progress];
    
    return self;
}
-(float)getHp{
    return hp;
}
-(void)setHp:(float)m_hp{
    hp = m_hp;
    [progress setPercentage:hp];
}
-(CGPoint)getPosition{
    return progress.position;
}
// -----------------------------------------------------------------

@end





