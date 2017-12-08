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
    
    NSMutableString * tag = [NSMutableString stringWithFormat:@"player"];
    [self setTag:tag];
    
    m_scale = 0.3f;
    
    m_entity = [CCSprite spriteWithImageNamed:@"beararmmove.png"];
    [m_entity setScale:m_scale];
    [m_entity setPosition:[MapEdittor GeneratePosition:m_entity Scale:m_scale]];
    
    CGRect rect = m_entity.boundingBox;
    CGSize size = [self getEntitySize];
    body = [CCPhysicsBody bodyWithRect:rect cornerRadius:size.width*0.5];
    [m_entity setPhysicsBody:body];
    
    
    [self addChild:m_entity];
    
    return self;
}
-(void)update:(CCTime)delta{
    [self deathDetection];
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
-(void)tired{
    m_hp -= 8;
}
-(void)repair{
    m_hp += 10;
    if (m_hp > 100) {
        m_hp = 100;
    }
}
-(void)deathDetection{
    if (m_hp<=0) {
        m_alive = NO;
    }
}
// -----------------------------------------------------------------

@end





