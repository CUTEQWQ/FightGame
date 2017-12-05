//
//  UsrInfo.h
//
//  Created by : 陈倩文
//  Project    : FightGame
//  Date       : 2017/12/4
//
//  Copyright (c) 2017年 chenqianwen.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------

@interface UsrInfo : CCSprite{
    CCSprite * portrait;

    NSMutableString *infoStr;
    NSString *m_nickName;
    int m_hp;
    int m_killed;
    
    CCLabelTTF * info;
}

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(CGPoint)getPosition;
-(void)modifyHp:(int)hp;
-(void)modifyKilled:(int)killed;
// -----------------------------------------------------------------

@end




