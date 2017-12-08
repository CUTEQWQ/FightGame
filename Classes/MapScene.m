//
//  MapScene.m
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/1
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "MapScene.h"

// -----------------------------------------------------------------

@implementation MapScene{
    CGSize viewSize;
    CGSize playerSize;
    CGSize blockSize;
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
    viewSize = [[CCDirector sharedDirector] viewSize];
    dropNum = 10;
    dropUpdateTime = 4.0f;
    appleNumMax = 5;
    enemyNum = 1;
    
    //set background color
    CCColor *gbColor = [CCColor colorWithRed:0.0f green:0.0f blue:0.3f alpha:0.4f];
    [self setColor:gbColor];
    
    //gen when game started
    [self initApples];
    
    //generate player
    player = [Player node];
    playerSize = [player getEntitySize];
    [self addChild:player z:2 name:@"player"];
    
    //generate enemy
    m_enemy = [Enemy node:player];
    [self addChild:m_enemy z:1 name:@"enemy"];
    
    //bar
    health = [Health node];
    [health setPosition:CGPointMake([player getPosition].x, [player getPosition].y + playerSize.height*0.5f +8)];
    [self addChild:health z:2];
    
    //generate stick
    m_stick = [JoyStick node];
    //active the joystick
    [m_stick Active];
    self.userInteractionEnabled = YES;
    [self addChild:m_stick z:2];
    
    //attack button
    CCSpriteFrame *attackFrame = [CCSpriteFrame frameWithImageNamed:@"attackBtn.png"];
    CCButton *attackBtn = [CCButton buttonWithTitle:@"" spriteFrame:attackFrame];
    CGSize frameSize = attackFrame.originalSize;
    [attackBtn setTarget:self selector:@selector(attack)];
    [attackBtn setPosition:CGPointMake(viewSize.width - frameSize.width*0.5 - 10,frameSize.height*0.5 +10 )];
    [self addChild:attackBtn];
    m_info = [UsrInfo node];
    [self addChild:m_info];
    
    //drop 每4s掉落一次 可在上面重新配置
    [self dropSnow];

    //reduce player's health ervery 7.5 sec
    [self schedule:@selector(tiredOfPlayer) interval:7.5f];
    //generate drop enetity ervery dropUpdateTime sec
    [self schedule:@selector(dropSnow) interval:dropUpdateTime];
    //gengrate apples every 5 sec
    [self schedule:@selector(keepApples) interval:5.0f];
    
    return self;
}
//实时监测点到了哪里
-(void)update:(CCTime)delta{
    
    //just for test
    //[player Damage:10];
    
    //修改浮在上面的圆
    m_stick.getStickFloat.position = ccpAdd(m_stick.getStickFloat.position, ccpMult(ccpSub(m_stick.getCurrentPoint, m_stick.getStickFloat.position), 0.5f));
    
    //[m_block keepPositionWithPlayer:player];

    [health setHp:[player getMyHp]];
    [m_info modifyHp:[player getMyHp]];
    
    [self countEnemyNum];
    //exit the game
    if ((![player getAliveState])||(enemyNum == 0) ){
        [self exitTheGame];
    }
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if (!m_stick.getStickState) {
        return;
    }
    
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    [m_stick setCurrentPoint:touchPoint];
    [m_stick setEndPoint:touchPoint];
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    [m_stick setCurrentPoint:m_stick.getCenterPoint];
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    if (ccpDistance(touchPoint, m_stick.getCenterPoint) > m_stick.getRadius*0.65) {
        [m_stick setCurrentPoint:ccpAdd(m_stick.getCenterPoint, ccpMult(ccpNormalize(ccpSub(touchPoint, m_stick.getCenterPoint)), m_stick.getRadius))];
    }else{
        [m_stick setCurrentPoint:touchPoint];
    }
    [m_stick setEndPoint:m_stick.getCurrentPoint];

//    uodate player's position
    [self updatePlayer];
    
}

-(void)updatePlayer{
    float force = [self getVelocity];
    CGPoint dir = [self getDirection];

    dir = ccpMult(dir, -1);
    
    if (dir.x < 0) {
        [player mirror:YES Dir:dir];
    }else{
        [player mirror:NO Dir:dir];
    }

    //boundary limit
    //still sth wrong here
    //[player setPosition:[MapEdittor boundaryLimitEntity:player Dir:dir Force:force Screen:viewSize]];
    
    CGPoint deltaPos = ccpMult(dir, force*0.1);
    if (deltaPos.x + [player getPosition].x > viewSize.width - playerSize.width*0.5) {
        [player setPosition:CGPointMake(viewSize.width - playerSize.width*0.5, [player getPosition].y)];
    }else if (deltaPos.x + [player getPosition].x < playerSize.width*0.5 ){
        [player setPosition: CGPointMake(playerSize.width*0.5, [player getPosition].y)];
    }else{
        [player setPosition: CGPointMake( [player getPosition].x+ deltaPos.x,  [player getPosition].y)];
    }

    if (deltaPos.y +  [player getPosition].y >viewSize.height - playerSize.height*0.5) {
        [player setPosition: CGPointMake( [player getPosition].x, viewSize.height - playerSize.height*0.5)];
    }else if (deltaPos.y +  [player getPosition].y <playerSize.height*0.5){
        [player setPosition:CGPointMake( [player getPosition].x, playerSize.height*0.5)];
    }else{
        [player setPosition:CGPointMake( [player getPosition].x,  [player getPosition].y + deltaPos.y)];
    }
    //update the bar's position
    [health setPosition:CGPointMake([player getPosition].x, [player getPosition].y + playerSize.height*0.5f +8)];
    
}
//摇杆的方向
-(CGPoint)getDirection{
     return ccpNormalize(ccpSub(m_stick.getCenterPoint, m_stick.getEndPoint));
//    if (ccpSub(m_stick.getCenterPoint, m_stick.getCurrentPoint).x == 0 && ccpSub(m_stick.getCenterPoint, m_stick.getCurrentPoint).y == 0){
//        return CGPointMake(0, 0);
//    }else
//        return ccpNormalize(ccpSub(m_stick.getCenterPoint, m_stick.getEndPoint));
}

//摇杆的力度
-(float)getVelocity{
    return ccpDistance(m_stick.getCenterPoint, m_stick.getEndPoint);
}
-(void)exitTheGame{
    [m_stick InActive];
    self.userInteractionEnabled = NO;

    gameOver = [GameOver node];
    CCButton * againBtn = [gameOver getAgainBtn];
    [againBtn setTarget:self selector:@selector(again)];
        [self addChild:gameOver z:4];
    if (enemyNum == 0) {
        [gameOver setWin:YES];
        //[gameOver again];
    }else{
        [gameOver setWin:NO];
        //[gameOver exit];
    }

}
-(void)attack{
    //action for player
    CCSpriteFrame *frame1 = [CCSpriteFrame frameWithImageNamed:@"bear.png"];
    CCSpriteFrame *frame2 = [CCSpriteFrame frameWithImageNamed:@"beararmmove.png"];
    NSArray* frames = [NSArray arrayWithObjects:frame1, frame2, nil];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
    CCActionAnimate *animate = [CCActionAnimate actionWithAnimation:animation];
    CCActionSequence *seq = [CCActionSequence actions:animate, nil];
    CCActionSpeed *speed = [CCActionSpeed actionWithAction:seq speed:1.0f];
    [player runAct:speed];
 
    //block
    Block* block = [Block node:m_enemy];
    blockSize = [block getEntitySize];
    [block keepPositionWithPlayer:player];
    [self addChild:block];
    
    CGPoint startPoint = [block getPosition];
    CGPoint endPoint;
    
    if ([player getTowardsLeft]) {
        endPoint = CGPointMake(startPoint.x - 550.0, 0);
    }else{
        endPoint = CGPointMake(startPoint.x + 550.0, 0);
    }
    
    [MapEdittor moveWithParabola:block startP:startPoint endP:endPoint startA:0 endA:180 Time:1.5f];
}
-(void)dropSnow{
    for (int i=0; i<dropNum; i++) {
        Drop* drop = [Drop node:player];
        [self addChild:drop z:3];
    }
}
-(void)tiredOfPlayer{
    [player tired];
    [health setHp:[player getMyHp]];
    [m_info modifyHp:[player getMyHp]];
}
//随机位置生成苹果
-(void)initApples{
    apples = [NSMutableArray arrayWithCapacity:appleNumMax];

    for (int i=1; i<=appleNumMax; i++) {
        Apple *apple = [Apple node:player];
        [apples addObject:apple];
        appleNum ++;
    }
    [self showApples];
}
-(void)keepApples{
    appleNum = (int)apples.count;
    for (int i=appleNum; i<=appleNumMax; i++) {
        Apple *apple = [Apple node:player];
        [apples addObject:apple];
        [self addChild:apple z:0 name:@"health"];
    }
    appleNum = appleNumMax;
}
-(void)showApples{
    for (int i=0; i<apples.count; i++) {
        [self addChild:[apples objectAtIndex:i] z:0 name:@"health"];
    }
}

//best way is to reload current scene, but i failed
-(void)again{
//    CCScene *cur = [[CCDirector sharedDirector] runningScene];
//    CCScene *newScene = [[cur class] alloc];
//    [[CCDirector sharedDirector] replaceScene:newScene];
}
-(void)countEnemyNum{
    if (![m_enemy getAliveState]) {
        enemyNum -= 1;
    }
}
// -----------------------------------------------------------------

@end





