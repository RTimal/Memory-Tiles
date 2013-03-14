//
//  MTLevel.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/7/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTLevel.h"


@implementation MTLevel


-(id)init {
    self = [super init];
    if(self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
        self.curLevel = [self.defaults integerForKey:@"CurrentLevel"];
        if(!self.curLevel) {
            self.curLevel = 1;
            [self.defaults setInteger:self.curLevel forKey:@"CurrentLevel"];
        }
    }
   // NSLog(@"current level: %d", self.curLevel);
    //hardcode level
     self.curLevel = 1;
    [self loadLevelSettings];
    [self loadSequences];
    
    self.scorePerTile = self.curLevel * (self.curSeqNum+1)*3;
   // NSLog(@"%i", self.scorePerTile);
    return self;
}

-(BOOL)sequenceLength {
    return [self.curSequence count];
}

-(void)loadLevelSettings {
    switch(self.curLevel) {
        case 1: {
            self.ntls = ntl1;
            self.numInSequence = sequencesperlevel;
            self.numPerRow = numPerRow1;
            self.numRows = numRows1;
        }
            break;
        case 2: {
            self.ntls = ntl2;
            self.numInSequence = sequencesperlevel;
            self.numRows = numRows2;
            self.numPerRow = numPerRow2;
        }
            break;
        case 3: {
            self.ntls = ntl3;
            self.numInSequence = sequencesperlevel;
            self.numRows = numRows3;
            self.numPerRow = numPerRow3;

        }
            break;
        case 4: {
            self.ntls = ntl4;
            self.numInSequence = sequencesperlevel;
            self.numPerRow = numPerRow4;
            self.numRows = numRows4;
        }
            break;
        case 5: {
            self.ntls = ntl5;
            self.numInSequence = sequencesperlevel;
            self.numPerRow = numPerRow5;
            self.numRows = numRows5;
        }
            break;
        case 6: {
            self.ntls = ntl6;
            self.numInSequence = sequencesperlevel;
            self.numPerRow = numPerRow6;
            self.numRows = numRows6;
        }
            break;
    }
}

-(void)loadSequences {
    self.sequences = nil;
    self.sequences = [[NSMutableArray alloc]init];
    for(int i = 0 ; i <  self.numInSequence; i++) {
        [self.sequences insertObject:[[MTSequence alloc]initWithTileNum:self.ntls andLevel:self andSeqnum:i] atIndex:i];
    }
    self.curSeqNum = 0;
    self.curSequence = self.sequences[0];

}

-(void)loadNextSequence {
        self.curSequence = self.sequences[++self.curSeqNum];
        self.scorePerTile = self.curLevel * self.curSeqNum;
}

-(void)loadNextLevel {
    self.curLevel++;
    if (self.curLevel == (nlvls+1)) {
        NSLog(@"you won");
        self.curLevel = 1;
        self.curSeqNum = 0;
        [self.defaults setInteger:0 forKey:@"CurrentLevel"];
        [self loadLevelSettings];
        [self loadSequences];
        [self.delegate reachedEndOfGame];
        return ;
    }
    [self loadLevelSettings];
    [self loadSequences];
    [self.defaults setInteger:self.curLevel forKey:@"CurrentLevel"];
}

-(void)playCurrentSequence {
    [self.delegate sequenceDidStartPlaying];
    self.t = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(sendNextSequenceValue) userInfo:nil repeats:YES];
}

-(void)sendNextSequenceValue {
    int nextSeqValue = [self.curSequence nextSequenceValue];
    if(nextSeqValue >= 0 ) {
        [self.delegate sequencePlayingIndex:nextSeqValue];
        return;
    }
    [self.t invalidate];
    [self.delegate sequenceDidFinishPlaying];

}


-(BOOL)doesTileIndex:(int)index matchSeqPosition:(int)pos{
    if(([self.curSequence count]-1) == pos) {
        if((self.curSeqNum + 1) == ([self.sequences count])) {
            [self.delegate readyToDisplayNextLevel];
        }
        else {
            [self.delegate readyToDisplayNextSequence];
        }
    } else {
        return [self.curSequence doesTileIndex:index matchSeqPosition:pos];
    }
}

@end
