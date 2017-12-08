//
//  MapEdittor.m
//  FightGame
//
//  Created by 陈倩文 on 2017/12/1.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "MapEdittor.h"

@implementation MapEdittor

+(CGPoint)GeneratePosition:(CCSprite *)m_sprite Scale:(float)m_scale{
    //for size boundary
    CCSprite* info = [CCSprite spriteWithImageNamed:@"portraitInfo.png"];
    CGSize infoSize = info.contentSize;
    CCSprite* stick = [CCSprite spriteWithImageNamed:@"stick_back.png"];
    CGSize stickSize = CGSizeMake(stick.contentSize.width*0.65f, stick.contentSize.height*0.65f);
    CCSprite* atk = [CCSprite spriteWithImageNamed:@"attackBtn.png"];
    CGSize atkSize = CGSizeMake(atk.contentSize.width+10, atk.contentSize.height+10);
    
    CGSize spriteSize = m_sprite.contentSize;
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    int width = CCRANDOM_0_1() * (viewSize.width - 0.5f*spriteSize.width*m_scale);
    int height = CCRANDOM_0_1() * (viewSize.height - 0.5f*spriteSize.height*m_scale);
    if (width < 0.5f*spriteSize.width*m_scale)
        width += 0.5f*spriteSize.width*m_scale;
    if (height < 0.5f*spriteSize.height*m_scale) {
        height += 0.5f*spriteSize.height*m_scale;
    }
    //bottom info shelter
    if (height >= infoSize.height-0.5f*spriteSize.height*m_scale && width <= infoSize.width - 0.5f*spriteSize.width*m_scale) {
        //统一策略：下移
        height = infoSize.height-0.5f*spriteSize.height*m_scale;
    }
    //left stick
    if (width <= stickSize.width + 0.5f*spriteSize.width*m_scale && height <= stickSize.height+0.5f*spriteSize.height*m_scale) {
        //随机右移或者上移
        int r = CCRANDOM_0_1()* 2;
        if (r==0) {
            height = stickSize.height+0.5f*spriteSize.height*m_scale;
        }else{
            width = stickSize.width + 0.5f*spriteSize.width*m_scale;
        }
        
    }
    //right attack
    if (width >= viewSize.width - atkSize.width - 0.5f*spriteSize.width*m_scale && height<= atkSize.height +0.5f*spriteSize.height*m_scale) {
        //随机上移或者左移
        int l = CCRANDOM_0_1() * 2;
        if (l==0) {
            height = atkSize.height +0.5f*spriteSize.height*m_scale;
        }else
            width = viewSize.width - atkSize.width - 0.5f*spriteSize.width*m_scale ;
    }
    
    CGPoint randomPoint = CGPointMake(width, height);
    return randomPoint;
}
//for drop-entity
+(CGPoint)GeneratePositionOnTop:(CCSprite *)m_sprite Scale:(float)m_scale{
    CGSize spriteSize = CGSizeMake(m_sprite.contentSize.width*m_scale, m_sprite.contentSize.height*m_scale);
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    float x = CCRANDOM_0_1() * (viewSize.width - spriteSize.width*0.5);
    if (x < spriteSize.width*0.5) {
        x = spriteSize.width*0.5;
    }
    return CGPointMake(x, spriteSize.height+viewSize.height);
}

+(BOOL)rectIncludeRecta:(CGRect)recta Scalea:(float)scalea Rectb:(CGRect)rectb Scaleb:(float)scaleb{
//    CGPoint aleftup = recta.origin;
//    CGPoint aleftdown = CGPointMake(recta.origin.x, recta.origin.y - recta.size.height*scalea*2.0);
//    CGPoint arightup = CGPointMake(recta.origin.x + recta.size.width*scalea*2.0, recta.origin.y);
//    CGPoint arightdown = CGPointMake(recta.origin.x + recta.size.width*scalea*2.0,  recta.origin.y - recta.size.height*scalea*2.0);
    
    float left = recta.origin.x;
    float right = recta.origin.x + recta.size.width*scalea;
    float up = recta.origin.y;
    float down = recta.origin.y - recta.size.height*scalea;
    
    CGPoint bleftup = rectb.origin;
    CGPoint bleftdown = CGPointMake(rectb.origin.x, rectb.origin.y - rectb.size.height*scaleb*2.0);
    CGPoint brightup = CGPointMake(rectb.origin.x + rectb.size.width*scaleb*2.0, rectb.origin.y);
    CGPoint brightdown = CGPointMake(rectb.origin.x + rectb.size.width*scaleb*2.0,  rectb.origin.y - rectb.size.height*scaleb*2.0);
    
    //left
    if (bleftup.x >= left && bleftup.x <= right) {
        //up
        if (bleftup.y >= down && bleftup.y <= up) {
            return true;
        }
        //down
        if (bleftdown.y >= down && bleftdown.y <= up) {
            return true;
        }
    }
    //right
    if (brightup.x >= left && brightup.x <= right) {
        //up
        if (brightup.y >= down && brightup.y <= up) {
            return true;
        }
        //down
        if (brightdown.y >= down && brightdown.y <= up) {
            return true;
        }
    }
    return false;
}
//limit the entity can't go out of the screen
//modify the position of entity
+(CGPoint)boundaryLimitEntity:(Entity*)m_entity Dir:(CGPoint)dir Force:(float)force Screen:(CGSize)screenSize{
    
    CGPoint deltaPos = ccpMult(dir, force*0.05);
    CGSize entitySize = m_entity.contentSize;
    CGPoint newPos;
    if (deltaPos.x + [m_entity getPosition].x > screenSize.width - entitySize.width*0.5) {
        newPos = CGPointMake(screenSize.width - entitySize.width*0.5, [m_entity getPosition].y);
    }else if (deltaPos.x + [m_entity getPosition].x < entitySize.width*0.5 ){
        newPos = CGPointMake(entitySize.width*0.5, [m_entity getPosition].y);
    }else{
        newPos = CGPointMake([m_entity getPosition].x + deltaPos.x, [m_entity getPosition].y);
    }
    
    if (deltaPos.y + [m_entity getPosition].y >screenSize.height - entitySize.height*0.5) {
        newPos = CGPointMake([m_entity getPosition].x, screenSize.height - entitySize.height*0.5);
    }else if (deltaPos.y + [m_entity getPosition].y <entitySize.height*0.5){
        newPos = CGPointMake([m_entity getPosition].x, entitySize.height*0.5);
    }else{
        newPos = CGPointMake([m_entity getPosition].x, [m_entity getPosition].y + deltaPos.y);
    }
    return newPos;
}

+(void)moveWithParabola:(Entity *)m_entity startP:(CGPoint)startPoint endP:(CGPoint)endPoint Time:(float)duration{
    float sx = startPoint.x;
    float sy = startPoint.y;
    float ex = endPoint.x;
    float ey = endPoint.y;
    int height = [m_entity getEntitySize].height * 0.5;
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(sx, sy);
    bezier.controlPoint_2 = ccp(sx+(ex-sx)*0.5, sy-(ey-sy)*0.5+200);
    bezier.endPosition = ccp(endPoint.x-30, endPoint.y+height);
    CCActionBezierTo *actionMove = [CCActionBezierTo actionWithDuration:duration bezier:bezier];
    [m_entity runAction:actionMove];
}
+(void)moveWithParabola:(Entity *)m_entity startP:(CGPoint)startPoint endP:(CGPoint)endPoint startA:(float)startAngle endA:(float)endAngle Time:(float)duration{
    float sx = startPoint.x;
    float sy = startPoint.y;
    float ex = endPoint.x;
    float ey = endPoint.y;
    //int height = [m_entity getEntitySize].height * 0.5;
    int height = [m_entity getEntitySize].height;
    [m_entity setRotation:startAngle];
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(sx, sy);
    
    //随机曲线
    float tmp_a = CCRANDOM_0_1()*5;
    float tmp_b = CCRANDOM_0_1()*2;
    
    bezier.controlPoint_2 = ccp(sx+(ex-sx)*tmp_a, sy-(ey-sy)*tmp_b+120);
    //bezier.endPosition = ccp(endPoint.x-30, endPoint.y+height);
    bezier.endPosition = endPoint;
    
    
    CCActionBezierTo *actionMove = [CCActionBezierTo actionWithDuration:duration bezier:bezier];
    CCActionRotateTo *actionRotate = [CCActionRotateTo actionWithDuration:duration angle:endAngle];
    CCAction *action = [CCActionSpawn actions:actionMove,actionRotate, nil];
    [m_entity runAct:action];
}

@end
