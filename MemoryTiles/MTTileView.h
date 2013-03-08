//
//  MTTileView.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTile.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@protocol tileViewDelegate <NSObject>
-(void)tileDidGetSelected:(id)tileView;
@end

@interface MTTileView : UIButton
@property (nonatomic) BOOL touched;
@property (nonatomic) float shadowRadius;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic)id<tileViewDelegate> delegate;
@property (nonatomic) int index;



-(void)setTile:(MTTile*)tile;
-(void)playTile;
-(void)stopPlayingTileAtIndex:(int)index;

@end
