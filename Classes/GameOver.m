//
//  GameOver.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/4
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameOver.h"

// -----------------------------------------------------------------

@implementation GameOver

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
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    gameOverWin = [CCSprite spriteWithImageNamed:@"win.png"];
    gameOverLose = [CCSprite spriteWithImageNamed:@"lose.png"];

    [gameOverWin setPosition:CGPointMake(viewSize.width*0.5, viewSize.height*0.5)];
    [gameOverLose setPosition:CGPointMake(viewSize.width*0.5, viewSize.height*0.5)];
    
    //exit game
    CCSpriteFrame *exitFrame = [CCSpriteFrame frameWithImageNamed:@"exitBtn.png"];
    exitBtn = [CCButton buttonWithTitle:@"" spriteFrame:exitFrame];
    [exitBtn setPosition:CGPointMake(viewSize.width*0.5+100, viewSize.height*0.5-50)];
    [exitBtn setTarget:self selector:@selector(exit)];
    [self addChild:exitBtn z:4];
    
    //play again
    CCSpriteFrame *againFrame = [CCSpriteFrame frameWithImageNamed:@"againBtn.png"];
    againBtn = [CCButton buttonWithTitle:@"" spriteFrame:againFrame];
    [againBtn setPosition:CGPointMake(viewSize.width*0.5-100, viewSize.height*0.5-50)];
    //[againBtn setTarget:self selector:@selector(again)];
    [self addChild:againBtn z:4];
    
    return self;
}

//load res put here
-(void)setWin:(BOOL)isWin{
    win = isWin;
    if (win) {
        [self addChild:gameOverWin];
    }else{
        [self addChild:gameOverLose];
    }
}

-(void)exit{
    [[CCDirector sharedDirector] end];
    exit(0);
}
-(CCButton*)getAgainBtn{
    return againBtn;
}
// -----------------------------------------------------------------

@end





