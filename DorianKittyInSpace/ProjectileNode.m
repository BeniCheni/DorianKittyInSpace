//
//  ProjectileNode.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/25/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "ProjectileNode.h"
#import "Utilities.h"

@implementation ProjectileNode

+(instancetype)projectileAtPosition:(CGPoint)position {
    ProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    
    [projectile setupAnimation];
    
    return projectile;
}

-(void)setupAnimation {
    NSArray *texture =@[[SKTexture textureWithImageNamed:@"projectile_1"],
                        [SKTexture textureWithImageNamed:@"projectile_2"],
                        [SKTexture textureWithImageNamed:@"projectile_3"]];
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:0.1];
    SKAction *repeatedAction = [SKAction repeatActionForever:action];
    [self runAction:repeatedAction];
}

-(void)moveTowardsPosition:(CGPoint)position {
    // slope = (Y3 - Y1) / (X3 - X1)
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    // slope = (Y2 - Y1) / (X2 - X1)
    // Y2 - Y1 = slope (X2 - X1)
    // Y2 = slope * X2 - slope * X1 + Y1
    
    float offScreenX;
    
    if (position.x <= self.position.x) {
        offScreenX = -10;
    } else {
        offScreenX = self.parent.frame.size.width + 10;
    }
    
    float offScreenY = slope * offScreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffScreen = CGPointMake(offScreenX, offScreenY);
    
    // Distance C = sqrt root of (a's power of 2 + b's power of 2) - Pythagorean http://en.wikipedia.org/wiki/Pythagorean_theorem
    float distanceA = pointOffScreen.y - self.position.y;
    float distanceB = pointOffScreen.x - self.position.x;
    float distanceC = sqrt(powf(distanceA, 2) + powf(distanceB, 2));
    
    // distance = speed * time
    // time = distance / speed
    float time = distanceC / ProjectileSpeed;
    float waitToFade = time * 0.75;
    float fadeTime = time - waitToFade;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffScreen duration:time];
    [self runAction:moveProjectile];
    
    NSArray *sequence = @[[SKAction waitForDuration:waitToFade],
                         [SKAction fadeOutWithDuration:fadeTime],
                         [SKAction removeFromParent]];
    [self runAction:[SKAction sequence:sequence]];
}

@end
