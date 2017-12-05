//
//  HelloWorldScene.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/11/30
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "HelloWorldScene.h"

// -----------------------------------------------------------------------

@implementation HelloWorldScene

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");

    //backGround picture
    CCSprite9Slice *backGround = [CCSprite9Slice spriteWithImageNamed:@"backGround.png"];
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    CGSize groundSize = backGround.contentSize;
    [backGround setScaleX:viewSize.width*1.0/groundSize.width];
    [backGround setScaleY:viewSize.height*1.0/groundSize.height];
    backGround.anchorPoint = ccp(0, 0);
    [self addChild:backGround];
    
    //button
//    CCButton *playBtn = [CCButton buttonWithTitle:@"playplayplaypl" fontName:@"Verdana-Bold" fontSize:25.0f];
    //bug exists:anywhere is okay
    CCSpriteFrame *btnFrame = [CCSpriteFrame frameWithImageNamed:@"black.png"];
    CCButton *playBtn = [CCButton buttonWithTitle:@"" spriteFrame:btnFrame highlightedSpriteFrame:nil disabledSpriteFrame:nil];
    [playBtn setContentSizeType:CCSizeTypeNormalized];
    playBtn.positionType = CCPositionTypeNormalized;
    playBtn.position = ccp(0.5f,0.31f);
    //playBtn.position = CGPointMake(viewSize.height/2.0, viewSize.height/2.0);
    [playBtn setPreferredSize:CGSizeMake(10, 10)];
    [playBtn setTarget:self selector:@selector(onClicked)];
    [self addChild:playBtn];
    
    return self;
}
-(void)onClicked{
    [[CCDirector sharedDirector] replaceScene:[MapScene node]];
};

// -----------------------------------------------------------------------

@end























// why not add a few extra lines, so we dont have to sit and edit at the bottom of the screen ...
