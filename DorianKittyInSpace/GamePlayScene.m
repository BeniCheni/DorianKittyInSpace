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
#import "SpaceDogNode.h"
#import "GroundNode.h"
#import "Utilities.h"

@interface GamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdated;
@property (nonatomic) NSTimeInterval timeElpsedSinceLastEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSTimeInterval minSpeed;
@property (nonatomic) NSTimeInterval addEnemyInterval;

@end

@implementation GamePlayScene

-(id)initWithSize:(CGSize)size {
    /* Setup title scene here */
    if (self = [super initWithSize:size]) {
        self.lastUpdated = 0;
        self.timeElpsedSinceLastEnemyAdded = 0;
        self.totalGameTime = 0;
        self.minSpeed = SpaceDogMinSpeed;
        self.addEnemyInterval = 1.5;
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        MachineNode *machine = [MachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        DorianKittyNode *dorianKitty = [DorianKittyNode dorianKittyAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
        [self addChild:dorianKitty];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        
        GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 20)];
        [self addChild:ground];
    }
    return self;
}

-(void)addSpaceDog {
    NSUInteger randomSpaceDog = [Utilities randomWithMin:0 max:2]; // max is not inclusive
    SpaceDogNode *spaceDog = [SpaceDogNode spaceDogOfType:randomSpaceDog];
    float deltaY = [Utilities randomWithMin:SpaceDogMinSpeed max:SpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, deltaY);
    
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [Utilities randomWithMin:10 + spaceDog.size.width max:self.frame.size.width - 10];
    
    spaceDog.position = CGPointMake(x, y);
    [self addChild:spaceDog];
}

-(void)update:(NSTimeInterval)currentTime {
    if (self.lastUpdated) {
        self.timeElpsedSinceLastEnemyAdded += currentTime - self.lastUpdated;
        self.totalGameTime += currentTime - self.lastUpdated;
    }
    
    if (self.timeElpsedSinceLastEnemyAdded > self.addEnemyInterval) {
        [self addSpaceDog];
        self.timeElpsedSinceLastEnemyAdded = 0;
    }
    
    self.lastUpdated = currentTime;
    
    if (self.totalGameTime > 180) { // 3 minutes
        self.addEnemyInterval = 0.50;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 120) { // 2 minutes
        self.addEnemyInterval = 0.65;
        self.minSpeed = -150;
    } else if (self.totalGameTime > 60) { // 1 minutes
        self.addEnemyInterval = 0.75;
        self.minSpeed = -140;
    } else if (self.totalGameTime > 20) { // 20 seconds
        self.addEnemyInterval = 0.85;
        self.minSpeed = -130;
    } else if (self.totalGameTime > 10) { // 10 seconds
        self.addEnemyInterval = 1.0;
        self.minSpeed = -120;
    }
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

-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy
            && secondBody.categoryBitMask == CollisionCategoryProjectile) {
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
    } else if (firstBody.categoryBitMask == CollisionCategoryEnemy
                   && secondBody.categoryBitMask == CollisionCategoryGround) {
        [firstBody.node removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
    }
}

-(void)createDebrisAtPosition:(CGPoint)position {
    NSInteger numberOfPieces = [Utilities randomWithMin:5 max:20];
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [Utilities randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld",(long)randomPiece];
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([Utilities randomWithMin:-150 max:150],
                                                   [Utilities randomWithMin:150 max:350]);
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
        
//        NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
//        SKEffectNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
//        explosion.position = position;
//        [self addChild:explosion];
//        
//        [explosion runAction:[SKAction waitForDuration:2.0] completion:^{
//            [explosion removeFromParent];
//        }];
    }
}

@end
