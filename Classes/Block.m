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

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    m_scale = 0.4f;
    m_entity = [CCSprite spriteWithImageNamed:@"block.png"];
    [m_entity setScale:m_scale];
    [self addChild:m_entity];
    return self;
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
// -----------------------------------------------------------------

@end





