//
//  MapEdittor.h
//  FightGame
//
//  Created by 陈倩文 on 2017/12/1.
//  Copyright © 2017年 chenqianwen. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "Entity.h"

@interface MapEdittor : CCNode
+(CGPoint)GeneratePosition:(CCSprite *)m_sprite Scale:(float)m_scale;
+(BOOL)rectIncludeRecta:(CGRect)recta Scalea:(float)scalea Rectb:(CGRect)rectb Scaleb:(float)scaleb;
+(CGPoint)boundaryLimitEntity:(Entity*)m_entity Dir:(CGPoint)dir Force:(float)force Screen:(CGSize)screenSize;
+(void)moveWithParabola:(Entity*)m_entity startP:(CGPoint)startPoint endP:(CGPoint)endPoint Time:(float)duration;
+(void)moveWithParabola:(Entity*)m_entity startP:(CGPoint)startPoint endP:(CGPoint)endPoint startA:(float)startAngle endA:(float)endAngle Time:(float)duration;
@end
