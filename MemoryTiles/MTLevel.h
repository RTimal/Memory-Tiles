//
//  MTLevel.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/7/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//
//number of levels
#define nlvls 6
//level 1 settings (Num Tiles, Number per Row, Number of Rows)
#define ntl1 8
#define numPerRow1 4
#define numRows1 3

//Level 2 Settings
#define ntl2 12
#define numPerRow2 6
#define numRows2 4

//Level 3 settings
#define ntl3 15
#define numPerRow3 6
#define numRows3 4

//Level 4 settings
#define ntl4 18
#define numPerRow4 6
#define numRows4 4

//Level 5 settings
#define ntl5 25
#define numPerRow5 7
#define numRows5 5

//Level 6 settings
#define ntl6 35
#define numPerRow6 8
#define numRows6 6

#import <Foundation/Foundation.h>
#import "MTSequence.h"

@protocol levelDelegate <NSObject>
-(void)sequenceDidFinishPlaying;
-(void)sequenceDidStartPlaying;
-(void)sequencePlayingIndex:(int)index;
-(void)sequenceStoppedPlayingIndex:(int)index;
-(void)readyToDisplayNextLevel;
-(void)readyToDisplayNextSequence;
-(void)reachedEndOfGame;
@end

@interface MTLevel : NSObject

@property (nonatomic) int curLevel;
@property (nonatomic) int curSeqNum;
@property (nonatomic, retain) MTSequence *curSequence;
@property (nonatomic) NSMutableArray* sequences;
@property (nonatomic, retain) NSUserDefaults *defaults;
@property (nonatomic) int ntls;
@property (nonatomic) int numPerRow;
@property (nonatomic) int numRows;
@property (nonatomic) int numInSequence;
@property (nonatomic) id <levelDelegate> delegate;
@property (nonatomic, retain) NSTimer *t;
@property (nonatomic) int scorePerTile;

-(void)playCurrentSequence;
-(void)loadNextSequence;
-(BOOL)doesTileIndex:(int)index matchSeqPosition:(int)pos;
-(BOOL)sequenceLength;
-(void)loadNextLevel;

@end
