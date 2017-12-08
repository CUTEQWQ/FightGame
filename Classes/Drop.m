//
//  Drop.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/7
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Drop.h"

// -----------------------------------------------------------------

@implementation Drop

// -----------------------------------------------------------------

+ (instancetype)node:(Player*)player
{
    return [[self alloc] initWithPlayer:player];
}

- (instancetype)initWithPlayer:(Player *)player
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    [self initMyPara];
    m_player = player;
    
    dropType = 0;
    m_scale = 0.2f;
    NSMutableString * tag = [NSMutableString stringWithFormat:@"drop"];
    [self setTag:tag];
    
    switch (dropType) {
        case 0:
            m_entity = [CCSprite spriteWithImageNamed:@"snow.png"];
            break;
            
        default:
            break;
    }
    CGPoint dropPos = [MapEdittor GeneratePositionOnTop:m_entity Scale:m_scale];
    [m_entity setPosition:dropPos];
    [m_entity setScale:m_scale];
    
    CGRect rect = m_entity.boundingBox;
    CGSize size = [self getEntitySize];
    body = [CCPhysicsBody bodyWithRect:rect cornerRadius:size.width*0.5];
    [m_entity setPhysicsBody:body];
    
    [self addChild:m_entity];
    
    float duration = CCRANDOM_0_1() * 10.0f;
    move = [CCActionMoveTo actionWithDuration:duration position:CGPointMake(dropPos.x, -20)];
    [m_entity runAction:move];
    //[self schedule:@selector(HurtPlayer) interval:0.01f];
    
    return self;
}
-(void)update:(CCTime)delta{
    [self HurtPlayer];
}
-(void)setPlayer:(Player *)player{
    m_player = player;
}
-(void)HurtPlayer{
    if (m_player) {
        CGRect rectOfPlayer = [m_player getBoundingBox];
        CGRect rectOfDrop = m_entity.boundingBox;
        if ([MapEdittor rectIncludeRecta:rectOfDrop Scalea:m_scale Rectb:rectOfPlayer Scaleb:[m_player getScale]]) {
            [m_player Damage:10];
        }
    }else
        return;
}
// -----------------------------------------------------------------

@end





