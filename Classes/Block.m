//
//  Block.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/6
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Block.h"

// -----------------------------------------------------------------

@implementation Block

// -----------------------------------------------------------------

+ (instancetype)node:(Enemy*)enemy
{
    return [[self alloc] initWithEnemy:enemy];
}

- (instancetype)initWithEnemy:(Enemy *)enemy
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    [self initMyPara];
    m_enemy = enemy;
    
    m_scale = 0.4f;
    m_entity = [CCSprite spriteWithImageNamed:@"block.png"];
    [m_entity setScale:m_scale];
    
    CGRect rect = m_entity.boundingBox;
    CGSize size = [self getEntitySize];
    body = [CCPhysicsBody bodyWithRect:rect cornerRadius:size.width*0.5];
    [m_entity setPhysicsBody:body];
    
    [self addChild:m_entity];
    return self;
}

-(void)update:(CCTime)delta{
    [self collisionWithEnemy];
}

//no need to add this method, just easy for understanding
-(void)instantiatePosition:(CGPoint)position{
    [m_entity setPosition:position];
}
-(void)setPlayer:(Player *)player{
    m_player = player;
}
-(void)keepPositionWithPlayer:(Player *)player{
    CGPoint pos = [player getPosition];
    CGSize blockSize = CGSizeMake(m_entity.contentSize.width*m_scale, m_entity.contentSize.height*m_scale);
    CGSize playerSize = [player getEntitySize];
    if ([player getTowardsLeft]) {
        [m_entity setPosition: CGPointMake(pos.x - playerSize.width*0.5 , pos.y - blockSize.height*0.5)];
    }else{
        [m_entity setPosition: CGPointMake(pos.x + playerSize.width*0.5 , pos.y - blockSize.height*0.5)];
    }
}
-(void)collisionWithEnemy{
    //maybe enemy is been killed
    if ([m_enemy getAliveState]) {
        CGRect rectOfBlock = m_entity.boundingBox;
        CGRect rectOfEnemy = [m_enemy getBoundingBox];
        if ([MapEdittor rectIncludeRecta:rectOfBlock Scalea:m_scale Rectb:rectOfEnemy Scaleb:[m_enemy getScale]]) {
            printf("attack enemy!\n");
            [m_enemy Damage:20];
        }
    }else
        return;
}
// -----------------------------------------------------------------

@end





