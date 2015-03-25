//
//  GamePlayScene.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/25/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "GamePlayScene.h"
#import "MachineNode.h"

@implementation GamePlayScene

-(id)initWithSize:(CGSize)size {
    /* Setup title scene here */
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        MachineNode *machine = [MachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime {
    NSLog(@"%f", fmod(currentTime, 60));
}

@end
