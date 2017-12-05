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

@end
