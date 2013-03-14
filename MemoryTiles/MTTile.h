//
//  MTTile.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTTile : NSObject


@property (nonatomic) CGRect frame;
@property (nonatomic) NSInteger numberInSequence;
@property (nonatomic) int index;
@property (nonatomic, strong) UIColor *color;

-(UIColor*)getRandomColor;

@end
