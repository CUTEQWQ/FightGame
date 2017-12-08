//
//  MapScene.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/1
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "MapEdittor.h"
#import "JoyStick.h"
#import "Enemy.h"
#import "Health.h"
#import "UsrInfo.h"
#import "GameOver.h"
#import "Player.h"
#import "Block.h"
#import "Drop.h"
#import "Apple.h"

// -----------------------------------------------------------------

@interface MapScene : CCScene{
    JoyStick *m_stick;
    Player *player;
    Enemy *m_enemy;
    Health *health;
    UsrInfo* m_info;
    GameOver* gameOver;
    int dropNum;
    
    NSMutableArray *apples;
    int appleNum;
    int appleNumMax;
    int enemyNum;
    float dropUpdateTime;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

//stick
//-(void)updatePos:(CCTime)delta;
-(float)getVelocity;
-(CGPoint)getDirection;
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
-(void)updatePlayer;
-(void)attack;
-(void)exitTheGame;
-(void)dropSnow;
-(void)tiredOfPlayer;
-(void)initApples;
-(void)keepApples;
-(void)showApples;
-(void)again;
-(void)countEnemyNum;
// -----------------------------------------------------------------

@end




