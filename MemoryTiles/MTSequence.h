//
//  MTSequence.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#define sequencesperlevel 10

#import <Foundation/Foundation.h>


@interface MTSequence : NSObject

@property (nonatomic) float tileDelay;
@property (nonatomic) float numTiles;
@property (nonatomic) NSMutableArray *sequence;
@property (nonatomic, retain) id level;
@property (nonatomic) int curSeqNum;
@property (nonatomic) int curPositionInSequence;
@property (nonatomic) int curValueInSequence;



-(id)initWithTileNum:(int)tileNum andLevel:(id)level andSeqnum:(int)seqNum;
-(int)nextSequenceValue;
-(NSUInteger)count;
-(BOOL)doesTileIndex:(int)index matchSeqPosition:(int)pos;

@end
