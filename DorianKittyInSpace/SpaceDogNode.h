//
//  SpaceDogNode.h
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/26/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, SpaceDogType) {
    SpaceDogTypeA,
    SpaceDogTypeB
};

@interface SpaceDogNode : SKSpriteNode

+(instancetype)spaceDogOfType:(SpaceDogType)type;

@end
