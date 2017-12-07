//
//  Entity.h
//  FightGame
//
//  Created by 陈倩文 on 2017/12/5.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "CCSprite.h"

//for each sprite entity in game

@interface Entity : CCSprite{
    @protected
    CCSprite* m_entity;
    int m_hp;
    BOOL m_alive;
    int m_killed;
    float m_scale;
}
-(void)Damage:(int)hurt;
-(void)initMyPara;
-(int)getMyHp;
-(void)setMyHp:(int)hp;
-(BOOL)getAliveState;
-(CGPoint)getPosition;
-(CGRect)getBoundingBox;
-(void)setKilled:(int)kil;
-(int)getKillNum;
-(void)killOne;
-(void)entityDied;
-(CGSize)getEntitySize;
-(void)runAct:(CCAction *)action;
@end
