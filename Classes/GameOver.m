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
    
    //预设为胜利
    win = YES;
    [self loadRes];
    
    return self;
}
-(void)loadRes{
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    if (win) {
        gameOver = [CCSprite spriteWithImageNamed:@"win.png"];
    } else{
        gameOver = [CCSprite spriteWithImageNamed:@"lose.png"];
    }
    [gameOver setPosition:CGPointMake(viewSize.width*0.5, viewSize.height*0.5)];
    
    [self addChild:gameOver];
    
    //exit game
    CCSpriteFrame *exitFrame = [CCSpriteFrame frameWithImageNamed:@"exitBtn.png"];
    exitBtn = [CCButton buttonWithTitle:@"" spriteFrame:exitFrame];
    [exitBtn setPosition:CGPointMake(viewSize.width*0.5+100, viewSize.height*0.5-50)];
    [exitBtn setTarget:self selector:@selector(exit)];
    [self addChild:exitBtn];
    
    //play again
    CCSpriteFrame *againFrame = [CCSpriteFrame frameWithImageNamed:@"againBtn.png"];
    againBtn = [CCButton buttonWithTitle:@"" spriteFrame:againFrame];
    [againBtn setPosition:CGPointMake(viewSize.width*0.5-100, viewSize.height*0.5-50)];
    [againBtn setTarget:self selector:@selector(again)];
    [self addChild:againBtn];
}
-(void)setWin:(BOOL)isWin{
    win = isWin;
}
-(void)exit{
    printf("exit!\n");
    [[CCDirector sharedDirector] end];
    exit(0);
}
-(void)again{
    printf("again\n");
    //重新加载游戏场景
//    CCScene *cur = [[CCDirector sharedDirector] runningScene];
//    CCScene *newScene = [[cur class] alloc];
//    [[CCDirector sharedDirector] replaceScene:newScene];
    
}
-(void)sendMessage:(NSString *)key Sender:(CCNode *)_sender Receiver:(CCNode *)_receiver{
    
}
// -----------------------------------------------------------------

@end





