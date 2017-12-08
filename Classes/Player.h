//
//  Player.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/5
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "MapEdittor.h"
//#import "CCAnimation.h"

// -----------------------------------------------------------------

@interface Player : Entity{
    CGSize playerSize;
    CCAnimation *animation;
    CCAction *action;
    BOOL left;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(void)mirror:(BOOL)flip Dir:(CGPoint)dir;
-(BOOL)getTowardsLeft;
-(void)tired;
-(void)repair;
// -----------------------------------------------------------------

@end




