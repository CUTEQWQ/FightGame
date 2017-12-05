//
//  JoyStick.h
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

// -----------------------------------------------------------------

@interface JoyStick : CCSprite{
    CGPoint centerPoint;
    CGPoint currentpoint;
    CGPoint endPoint;//摇杆的最外层值
    BOOL active;//是否被激活
    float radius;//摇杆半径，大圆
    CCSprite *stick_float;//up circle
    CCSprite *stick_back;//down circle
    float stickScale;//缩放比例
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

- (CCSprite*) getStickFloat;
- (CCSprite*) getStickBack;
-(BOOL)getStickState;
-(float)getRadius;
-(CGPoint)getCenterPoint;
-(CGPoint)getCurrentPoint;
-(CGPoint)getEndPoint;
-(void)setCenterPoint:(CGPoint)point;
-(void)setCurrentPoint:(CGPoint)point;
-(void)setEndPoint:(CGPoint)point;

-(void)Active;
-(void)InActive;
// -----------------------------------------------------------------

@end




