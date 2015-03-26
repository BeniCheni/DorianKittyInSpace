//
//  GamePlayScene.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/25/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "GamePlayScene.h"
#import "MachineNode.h"
#import "DorianKittyNode.h"
#import "ProjectileNode.h"

@implementation GamePlayScene

-(id)initWithSize:(CGSize)size {
    /* Setup title scene here */
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        MachineNode *machine = [MachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        DorianKittyNode *dorianKitty = [DorianKittyNode dorianKittyAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
        [self addChild:dorianKitty];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:position];
    }
}

-(void)shootProjectileTowardsPosition:(CGPoint)position {
    DorianKittyNode *dorianKitty = (DorianKittyNode *) [self childNodeWithName:@"DorianKitty"];
    [dorianKitty performTap];
    
    MachineNode *machine = (MachineNode *) [self childNodeWithName:@"Machine"];
    
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y+machine.frame.size.height-15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
}

@end
