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
    
    //set background color
    CCColor *gbColor = [CCColor colorWithRed:0.0f green:0.0f blue:0.3f alpha:0.4f];
    [self setColor:gbColor];

    //generate enemy
    m_enemy = [Enemy node];
    [self addChild:m_enemy];
    
    //generate player
    player = [Player node];
    playerSize = [player getEntitySize];
    [self addChild:player];
    

    
    //bar
    health = [Health node];
    [health setPosition:CGPointMake([player getPosition].x, [player getPosition].y + playerSize.height*0.5f +8)];
    [self addChild:health];
    
    //generate stick
    m_stick = [JoyStick node];
    //active the joystick
    [m_stick Active];
    self.userInteractionEnabled = YES;
    [self addChild:m_stick];
    
    //attack button
    CCSpriteFrame *attackFrame = [CCSpriteFrame frameWithImageNamed:@"attackBtn.png"];
    CCButton *attackBtn = [CCButton buttonWithTitle:@"" spriteFrame:attackFrame];
    CGSize frameSize = attackFrame.originalSize;
    [attackBtn setTarget:self selector:@selector(attack)];
    [attackBtn setPosition:CGPointMake(viewSize.width - frameSize.width*0.5 - 10,frameSize.height*0.5 +10 )];
    [self addChild:attackBtn];
    

    m_info = [UsrInfo node];
    [self addChild:m_info];
    return self;
}
//实时监测点到了哪里
-(void)update:(CCTime)delta{
    //修改浮在上面的圆
    m_stick.getStickFloat.position = ccpAdd(m_stick.getStickFloat.position, ccpMult(ccpSub(m_stick.getCurrentPoint, m_stick.getStickFloat.position), 0.5f));
    
    //[m_block keepPositionWithPlayer:player];
    
    
    //collision
    [self collision];
    if ([player getMyHp]>0) {
//        [player setMyHp:[player getMyHp] - 10];
    }

    [health setHp:[player getMyHp]];
    [m_info modifyHp:[player getMyHp]];
    
    //detect death
    [self deathDetect];
    //exit the game
    if (![player getAliveState]) {
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
    
    CGPoint deltaPos = ccpMult(dir, force*0.05);
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
    
    //update block's position
//    CGPoint pos = [player getPosition];
//    if ([player getTowardsLeft]) {
//        [m_block setPosition: CGPointMake(pos.x - playerSize.width*0.5 , pos.y - blockSize.height*0.5)];
//    }else{
//        [m_block setPosition: CGPointMake(pos.x + playerSize.width*0.5 , pos.y - blockSize.height*0.5)];
//    }
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

-(void)collision{
    CGRect rectOfPlayer = [player getBoundingBox];
    CGRect rectOfEnemy = [m_enemy getBoundingBox];

    if ([MapEdittor rectIncludeRecta:rectOfPlayer Scalea:0.3f Rectb:rectOfEnemy Scaleb:0.5f]) {
        printf("Clicked\n");
        //eat the enemy
        [m_enemy setVisible:NO];
        [player killOne];
        [m_info modifyKilled:[player getKillNum]];

        //after removing the obj doesnt exist->problem
        //[self removeChild:m_enemy];
    }
}
-(void)deathDetect{
    if ([player getMyHp]<=0) {
        [player entityDied];
    }
}
-(void)exitTheGame{
    [m_stick InActive];
    self.userInteractionEnabled = NO;

    gameOver = [GameOver node];
    //改成lose
    [gameOver setWin:NO];
    [gameOver loadRes];
    [self addChild:gameOver];
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
    Block* block = [Block node];
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
    printf("attack!\n");
}
// -----------------------------------------------------------------

@end





