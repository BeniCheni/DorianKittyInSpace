//
//  TitleScene.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/25/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"

@implementation TitleScene

-(id)initWithSize:(CGSize)size {
    /* Setup title scene here */
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_new"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition doorwayWithDuration: 1.0];
    [self.view presentScene:gamePlayScene transition:transition];
}
@end
