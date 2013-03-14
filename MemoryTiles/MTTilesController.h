//
//  MTTileController.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTSequence.h"
#import "MTTile.h"
#import "MTTileView.h"
#import <QuartzCore/QuartzCore.h>
#import "MTDashBoardView.h"
#import "MTLevel.h"
#import "MTDashBoardController.h"
#import <QuartzCore/QuartzCore.h>


@interface MTTilesController : UIViewController<tileViewDelegate, levelDelegate, dashBoardDelegate>
@property (nonatomic, retain) NSMutableArray *tiles;
@property (nonatomic, retain) NSMutableArray *tileViews; 
@property (nonatomic) float numPerRow;
@property (nonatomic) float numRows;
@property (nonatomic) int numTiles;
@property (nonatomic) float tileHeight;
@property (nonatomic) float tileWidth;
@property (nonatomic, retain) MTDashBoardView *dbView;
@property (nonatomic, retain) MTLevel* level;
@property (nonatomic, retain) MTDashBoardController *dashBoard;
@property (nonatomic) int lastSelectedIndex;

-(void)reachedEndOfGame;
-(void)resetGame;

@end
