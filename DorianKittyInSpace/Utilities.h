//
//  Utilities.h
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/26/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int ProjectileSpeed = 380;
static const int SpaceDogMinSpeed = -100;
static const int SpaceDogMaxSpeed = -50;

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryEnemy      = 1 << 0,   // 0001
    CollisionCategoryProjectile = 1 << 1,   // 0010
    CollisionCategoryDebris     = 1 << 2,   // 0100
    CollisionCategoryGround     = 1 << 3    // 1000
};

@interface Utilities : NSObject

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
