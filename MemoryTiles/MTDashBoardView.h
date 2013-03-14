//
//  MTDashBoardView.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/5/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MTDashBoardView : UIView

@property(nonatomic, retain) UILabel *score;
@property(nonatomic, retain) NSMutableArray* currentTilesInSequence;
@property(nonatomic) BOOL sequencePlaying;
@property(nonatomic) BOOL sequenceStarted;

@end
