//
//  Utilities.m
//  DorianKittyInSpace
//
//  Created by Beni Cheni on 3/26/15.
//  Copyright (c) 2015 Prince Of Darkness. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random() % (max - min) + min;
}

@end
