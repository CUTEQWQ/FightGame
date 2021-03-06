//
//  Health.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/3
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------
//血量条
@interface Health : CCSprite{
    CCSprite* bar;
    CCSprite * blood;
    CCProgressNode *progress;
    float hp;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(float)getHp;
-(void)setHp:(float)m_hp;
-(CGPoint)getPosition;

// -----------------------------------------------------------------

@end




