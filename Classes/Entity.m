//
//  Entity.m
//  FightGame
//
//  Created by 陈倩文 on 2017/12/5.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "Entity.h"

@implementation Entity

-(void)Damage:(int)hurt{
    m_hp -= hurt;
}
-(void)initMyPara{
    m_hp = 100;
    m_alive = YES;
    m_killed = 0;
    m_scale = 1.0f;
}
-(int)getMyHp{
    return m_hp;
}
-(void)setMyHp:(int)hp{
    m_hp = hp;
}
-(BOOL)getAliveState{
    return m_alive;
}
-(CGPoint)getPosition{
    return m_entity.position;
}
-(CGRect)getBoundingBox{
    return m_entity.boundingBox;
}
-(void)setKilled:(int)kil{
    m_killed = kil;
}
//kill one people
-(void)killOne{
    m_killed ++;
}
-(int)getKillNum{
    return m_killed;
}
//set entity is died
-(void)entityDied{
    m_alive = NO;
}
-(CGSize)getEntitySize{
    return CGSizeMake(m_entity.contentSize.width*m_scale, m_entity.contentSize.height*m_scale);
}
-(void)setPosition:(CGPoint)position{
    m_entity.position = position;
}
-(void)setRotation:(float)rotation{
    m_entity.rotation = rotation;
}
//rewrite the method runAction
-(void)runAct:(CCAction *)action{
    [m_entity runAction:action];
}
@end
