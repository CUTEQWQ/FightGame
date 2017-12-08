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

+ (instancetype)node:(Player*)player
{
    return [[self alloc] initWithPlayer:player];
}

- (instancetype)initWithPlayer:(Player *)player
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    //for test
    enemyType = 0;
    
    //init enemy
    [self initMyPara];
    m_player = player;
    m_scale = 0.5f;
    NSMutableString * tag = [NSMutableString stringWithFormat:@"enemy"];
    [self setTag:tag];
    
    switch (enemyType) {
        case 0:
            m_entity = [CCSprite spriteWithImageNamed:@"waitingpenguin.png"];
            break;
            
        default:
            break;
    }
    CGPoint pos =[MapEdittor GeneratePosition:m_entity Scale:m_scale];
    [m_entity setPosition:pos];
    printf("enemy:%f,%f\n",m_entity.position.x,m_entity.position.y);
    [m_entity setScale:m_scale];
    
    CGRect rect = m_entity.boundingBox;
    CGSize size = [self getEntitySize];
    body = [CCPhysicsBody bodyWithRect:rect cornerRadius:size.width*0.5];
    [m_entity setPhysicsBody:body];
    
    [self addChild:m_entity];
    
    //label
    show = [CCLabelTTF labelWithString:@"100" fontName:@"MarkerFelt-Thin" fontSize:12.0f];
    [show setColor:[CCColor colorWithRed:1 green:0 blue:0]];
    [show setPosition:CGPointMake(pos.x, pos.y+m_entity.contentSize.height*m_scale*0.5+10)];
    [self addChild:show];
    
    return self;
}
-(void)update:(CCTime)delta{
    [self deathDetection];
    [self collisionWithPlayer];
}
-(void)setMyHp:(int)hp{
    m_hp = hp;
    NSString *s = [NSString stringWithFormat:@"%d",hp];
    [show setString:s];
}
-(void)deathDetection{
    if (m_hp<=0) {
        m_alive = NO;
        //暂时设为不可见，而不是移除
        [m_entity setVisible:NO];
        [show setVisible:NO];
    }
}
-(void)Damage:(int)hurt{
    m_hp -= hurt;
    [self setMyHp:m_hp];
}
-(void)collisionWithPlayer{
    if ([m_player getAliveState]) {
        CGRect rectOfEnemy = m_entity.boundingBox;
        CGRect rectOfPlayer = [m_player getBoundingBox];
        if ([MapEdittor rectIncludeRecta:rectOfEnemy Scalea:m_scale Rectb:rectOfPlayer Scaleb:[m_player getScale]]) {
            [self Damage:10];
        }
    }else
        return;
}
// -----------------------------------------------------------------

@end





