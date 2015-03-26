//
//  DorianKittyNode.h
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/25/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DorianKittyNode : SKSpriteNode

+ (instancetype) dorianKittyAtPosition:(CGPoint)position;

- (void) performTap;

@end
