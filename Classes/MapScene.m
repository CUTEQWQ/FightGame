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
    m_killed = 0;
    died = NO;
    
    //set background color
    CCColor *gbColor = [CCColor colorWithRed:0.0f green:0.0f blue:0.3f alpha:0.4f];
    [self setColor:gbColor];

    //generate enemy
    m_enemy = [Enemy node];
    [self addChild:m_enemy];
    
    //generate player
    m_player = [CCSprite spriteWithImageNamed:@"bear.png"];
    [m_player setScale:0.3f];
    [m_player setPosition:[MapEdittor GeneratePosition:m_player Scale:0.3f]];
    playerSize = CGSizeMake(m_player.contentSize.width*0.3f, m_player.contentSize.height*0.3f);
    [self addChild:m_player];
    
    //bar
    m_hp = 100.0f;
    health = [Health node];
    [health setPosition:CGPointMake(m_player.position.x, m_player.position.y+playerSize.height-12.0f)];
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
    
    //collision
    [self collision];
    if (m_hp>0) {
        m_hp -= 10;
    }
    [health setHp:m_hp];
    [m_info modifyHp:m_hp];
    
    //detect death
    [self deathDetect];
    //exit the game
    if (died) {
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
        m_player.flipX = YES;
    }else{
        m_player.flipX = NO;
    }
    
    //boundary limit
    CGPoint deltaPos = ccpMult(dir, force*0.05);
    if (deltaPos.x + m_player.position.x > viewSize.width - playerSize.width*0.5) {
        m_player.position = CGPointMake(viewSize.width - playerSize.width*0.5, m_player.position.y);
    }else if (deltaPos.x + m_player.position.x < playerSize.width*0.5 ){
        m_player.position = CGPointMake(playerSize.width*0.5, m_player.position.y);
    }else{
        m_player.position = CGPointMake(m_player.position.x + deltaPos.x, m_player.position.y);
    }
    
    if (deltaPos.y + m_player.position.y >viewSize.height - playerSize.height*0.5) {
        m_player.position = CGPointMake(m_player.position.x, viewSize.height - playerSize.height*0.5);
    }else if (deltaPos.y + m_player.position.y <playerSize.height*0.5){
        m_player.position = CGPointMake(m_player.position.x, playerSize.height*0.5);
    }else{
        m_player.position = CGPointMake(m_player.position.x, m_player.position.y + deltaPos.y);
    }
    //update the bar's position
    [health setPosition:CGPointMake(m_player.position.x, m_player.position.y+playerSize.height-12.0f)];
    //player.position = ccpAdd(player.position, deltaPos);
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
    CGRect rectOfPlayer = [m_player boundingBox];
    CGRect rectOfEnemy = [m_enemy getBoundingBox];

    if ([MapEdittor rectIncludeRecta:rectOfPlayer Scalea:0.3f Rectb:rectOfEnemy Scaleb:0.5f]) {
        printf("Clicked\n");
        //eat the enemy
        [m_enemy setVisible:NO];
        m_killed ++;
        [m_info modifyKilled:m_killed];
        
        //after removing the obj doesnt exist->problem
        //[self removeChild:m_enemy];
    }
}
-(void)deathDetect{
    if (m_hp <=0 ) {
        died = YES;
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
    printf("attack!\n");
}
// -----------------------------------------------------------------

@end





