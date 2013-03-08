//
//  MTTile.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTTile.h"

@implementation MTTile


-(id)init {
    self = [super init];
    
    if(self) {
        self.color = [self getRandomColor];
    }
    return self;
    
}


- (UIColor *) getRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = 1;  //  0.5 to 1.0, away from white
    CGFloat brightness = 1;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
