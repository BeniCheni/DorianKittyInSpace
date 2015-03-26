//
//  DorianKittyNode.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/25/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "DorianKittyNode.h"

@interface DorianKittyNode ()
@property (nonatomic) SKAction *tapAction;
@end

@implementation DorianKittyNode

+(instancetype)dorianKittyAtPosition:(CGPoint)position {
    DorianKittyNode *dorianKitty = [self spriteNodeWithImageNamed:@"spacecat_1"];
    dorianKitty.position = position;
    dorianKitty.anchorPoint = CGPointMake(0.5, 0);
    dorianKitty.name = @"DorianKitty";
    
    return dorianKitty;
}

-(void)performTap {
    [self runAction:self.tapAction];
}

-(SKAction *)tapAction {
    if (_tapAction != nil) {
        return _tapAction;
    }
    
    NSArray *texture = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                         [SKTexture textureWithImageNamed:@"spacecat_1"]];
    
    _tapAction = [SKAction animateWithTextures:texture timePerFrame:0.25];
    
    return _tapAction;
}

@end
