//
//  SpaceDogNode.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/26/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "SpaceDogNode.h"
#import "Utilities.h"

@implementation SpaceDogNode

+(instancetype)spaceDogOfType:(SpaceDogType)type {
    SpaceDogNode *spaceDog;
    NSArray *textures;
    
    if (type == SpaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spaceDog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spaceDog_A_1"],
                     [SKTexture textureWithImageNamed:@"spaceDog_A_2"],
                     [SKTexture textureWithImageNamed:@"spaceDog_A_3"]];
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spaceDog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spaceDog_B_1"],
                     [SKTexture textureWithImageNamed:@"spaceDog_B_2"],
                     [SKTexture textureWithImageNamed:@"spaceDog_B_3"],
                     [SKTexture textureWithImageNamed:@"spaceDog_B_4"]];
    }
    
    float scale = [Utilities randomWithMin:50 max:200] / 100.0f;
    spaceDog.xScale = scale;
    spaceDog.yScale = scale;
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    [spaceDog runAction:[SKAction repeatActionForever:animation]];
    [spaceDog setupPhysicsBody];
    
    return spaceDog;
}

-(void)setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryProjectile | CollisionCategoryGround; // 0010 | 1000 = 1010
}

@end
