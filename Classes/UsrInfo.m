//
//  UsrInfo.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/4
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "UsrInfo.h"

// -----------------------------------------------------------------

@implementation UsrInfo

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
    
    portrait = [CCSprite spriteWithImageNamed:@"portraitInfo.png"];
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    CGSize portraitSize = portrait.contentSize;
    [portrait setPosition:CGPointMake(portraitSize.width*0.5, viewSize.height - portraitSize.height*0.5)];
    [self addChild:portrait];
    
    
    //info string, can be modified
    m_nickName = @"SuperBear";
    m_killed = 0;
    m_hp = 100;
    infoStr = [[NSMutableString alloc] initWithFormat:@"Nickname:%@   health:%3d   killed:%2d",m_nickName,m_hp,m_killed];
    
    //info bar
    info = [CCLabelTTF labelWithString:infoStr fontName:@"MarkerFelt-Thin" fontSize:17.0f];
    [info setPosition:CGPointMake(portraitSize.width*0.5+23, viewSize.height - portraitSize.height*0.5-5)];
    [info setFontColor:[CCColor colorWithWhite:0.2 alpha:0.8]];
    [self addChild:info];
    return self;
}
-(CGPoint)getPosition{
    return portrait.position;
}
-(void)modifyHp:(int)hp{
    m_hp = hp;
    infoStr = [NSMutableString stringWithFormat:@"Nickname:%@   health:%3d   killed:%2d",m_nickName,m_hp,m_killed];
    if (m_hp <=0 ) {
        infoStr = [NSMutableString stringWithFormat:@"Nickname:%@   health:  0   killed:%2d",m_nickName,m_killed];
    }
    [info setString:infoStr];
}
-(void)modifyKilled:(int)killed{
    m_killed = killed;
    infoStr = [NSMutableString stringWithFormat:@"Nickname:%@   health:%3d   killed:%2d",m_nickName,m_hp,m_killed];
    [info setString:infoStr];
}
// -----------------------------------------------------------------

@end





