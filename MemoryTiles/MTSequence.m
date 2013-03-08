//
//  MTSequence.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTSequence.h"
#import "MTTile.h"
#import "MTLevel.h"



@implementation MTSequence
-(id)initWithTileNum:(int)tileNum andLevel:(MTLevel *)level andSeqnum:(int)seqNum {
    self = [super init];
    if(self) {
        self.numTiles = tileNum;
   //     NSLog(@"number of tiles, %i", tileNum);
        self.tileDelay = 0.5;
        self.level = (MTLevel*)level;
    }
    self.sequence = [[NSMutableArray alloc]initWithCapacity:[self.level curLevel]*(seqNum+2)];
    self.curSeqNum = seqNum;

    [self generateSequence];
    self.curPositionInSequence = 0;
    self.curValueInSequence = [[self.sequence objectAtIndex:self.curPositionInSequence]integerValue];
    return self;
}

-(void)generateSequence {
   // NSLog(@"Generating Sequence");
    for(int j = 0; j < ([self.level curLevel]*(self.curSeqNum+2)); j++) {
        NSNumber *randomTile = [NSNumber numberWithInteger:arc4random()% ([self.level ntls] - 0) + 0];//range from 0 to number of tiles
        //NSLog(@"Random Tile Int Value: %i", [randomTile integerValue]);
        [self.sequence insertObject:randomTile atIndex:j];
    }
}

-(BOOL)matchTile:(MTTile*)tile withIndex:(int)index {
    if(tile.index == index)
        return YES;
        return NO;
}

-(BOOL)doesTileIndex:(int)index matchSeqPosition:(int)pos{
    NSNumber *tile = self.sequence[pos];
    if([tile intValue] == index) {
        return YES;
    }
    return NO;
}

-(NSUInteger)count {
   // NSLog(@"sequence count from sequence class: %i", [self.sequence count]);
    return [self.sequence count];
}

-(int)nextSequenceValue {
    if(self.curPositionInSequence == 0) {
        self.curPositionInSequence++;
        return  self.curValueInSequence;
    } else {
        if(self.curPositionInSequence == [self.sequence count]) {
            self.curPositionInSequence = 0;
            self.curValueInSequence = [self.sequence[self.curPositionInSequence]integerValue];
            return -1;
        }
        self.curValueInSequence = [[self.sequence objectAtIndex:self.curPositionInSequence]integerValue];
  
        self.curPositionInSequence++;
        return self.curValueInSequence;
    }
}
@end
