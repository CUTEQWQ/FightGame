//
//  JoyStick.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/1
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "JoyStick.h"

// -----------------------------------------------------------------

@implementation JoyStick{
    CCSprite *myPlayer;
}

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
    
    stickScale = 0.65f;
    
    stick_float = [CCSprite spriteWithImageNamed:@"stick_float.png"];
    stick_back = [CCSprite spriteWithImageNamed:@"stick_back.png"];
    [stick_back setScale:stickScale];
    [stick_float setScale:stickScale];
    
    active = NO;
    radius = stick_back.contentSize.width*0.5;
    centerPoint = CGPointMake(stick_back.contentSize.width*0.5*stickScale, stick_back.contentSize.height*0.5*stickScale);
    currentpoint = centerPoint;
    endPoint = centerPoint;
    [stick_back setPosition:centerPoint];
    [stick_float setPosition:centerPoint];
    
    [self addChild:stick_back];
    [self addChild:stick_float];
    //[self Active];
    
    return self;
}

-(void)Active{
    if (!active) {
        active = YES;
        //要记得在原来的布局中打开接受用户触屏
        self.userInteractionEnabled = TRUE;
    }
}
-(void)InActive{
    if (active) {
        active = false;
        //[self unschedule:@selector(updatePos:)];
        self.userInteractionEnabled = NO;
        self.exclusiveTouch = NO;
    }
}

-(float)getRadius{
    return radius;
}
-(CCSprite*)getStickBack{
    return stick_back;
}
-(CCSprite*)getStickFloat{
    return stick_float;
}
-(BOOL)getStickState{
    return active;
}
-(CGPoint)getCenterPoint{
    return centerPoint;
}
-(CGPoint)getCurrentPoint{
    return currentpoint;
}
-(CGPoint)getEndPoint{
    return endPoint;
}
-(void)setEndPoint:(CGPoint)point{
    endPoint = point;
}
-(void)setCurrentPoint:(CGPoint)point{
    currentpoint = point;
}
-(void)setCenterPoint:(CGPoint)point{
    centerPoint = point;
}

// -----------------------------------------------------------------

@end





