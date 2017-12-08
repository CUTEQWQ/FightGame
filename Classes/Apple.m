//
//  Apple.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/8
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Apple.h"

// -----------------------------------------------------------------

@implementation Apple

// -----------------------------------------------------------------

+ (instancetype)node:(Player*)player
{
    return [[self alloc] initWithPlayer:player];
    //return [[self alloc] init];
}

- (instancetype)initWithPlayer:(Player*)player
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    [self initMyPara];
    m_player = player;
    
    NSMutableString * tag = [NSMutableString stringWithFormat:@"health"];
    [self setTag:tag];
    
    m_entity = [CCSprite spriteWithImageNamed:@"apple.png"];
    m_scale = 0.2f;
    [m_entity setScale:m_scale];
    
    CGPoint pos = [MapEdittor GeneratePosition:m_entity Scale:m_scale];
    printf("apple:%f,%f\n",pos.x,pos.y);
    [m_entity setPosition:pos];
    
    CGRect rect = m_entity.boundingBox;
    CGSize size = [self getEntitySize];
    body = [CCPhysicsBody bodyWithRect:rect cornerRadius:size.width*0.5];
    [m_entity setPhysicsBody:body];
    
    [self addChild:m_entity];

    return self;
}
-(void)update:(CCTime)delta{
    [self collisionWithPlayer];
}
-(void)collisionWithPlayer{
    if (m_alive) {
        CGRect rectOfApple = m_entity.boundingBox;
        CGRect rectOfPlayer = [m_player getBoundingBox];
        
        if ([MapEdittor rectIncludeRecta:rectOfApple Scalea:m_scale Rectb:rectOfPlayer Scaleb:[m_player getScale]]) {
            printf("clicked with apple\n");
            //repair player's life
            [m_player repair];
            //apple is ate
            [m_entity setVisible:NO];
            //the apple is not alive?
            m_alive = NO;
            //[self removeChild:m_entity];
        }
    }else{
        return ;
    }

}
// -----------------------------------------------------------------

@end





