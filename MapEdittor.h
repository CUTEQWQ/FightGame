//
//  MapEdittor.h
//  FightGame
//
//  Created by 陈倩文 on 2017/12/1.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"

@interface MapEdittor : CCNode
+(CGPoint)GeneratePosition:(CCSprite *)m_sprite Scale:(float)m_scale;
+(BOOL)rectIncludeRecta:(CGRect)recta Scalea:(float)scalea Rectb:(CGRect)rectb Scaleb:(float)scaleb;
@end
