//
//  MTDashBoardController.h
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/9/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDashBoardController.h"
#import "MTDashBoardView.h"
#import "FXLabel.h"
#import <QuartzCore/QuartzCore.h>

@protocol dashBoardDelegate <NSObject>
-(void)didPressPlay;
-(void)didPressDisplayNextLevel;
-(void)didPressDisplayNextSequence;
-(void)loadNextLevel;
@end

@interface MTDashBoardController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tileCounter;
@property (weak, nonatomic) IBOutlet UILabel *loadNextSequence;
@property (weak, nonatomic) IBOutlet UIButton *nextSequence;
@property (weak, nonatomic) IBOutlet UILabel *playingSequence;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet MTDashBoardView *dashBoardView;
@property (weak, nonatomic) IBOutlet UITextField *score;
@property (weak, nonatomic) IBOutlet UITextField *level;
@property (weak, nonatomic) IBOutlet UITextField *sequence;
@property (weak, nonatomic) IBOutlet UITextField *highScore;
@property (nonatomic, retain)NSUserDefaults *defaults;
@property (nonatomic) id<dashBoardDelegate> delegate;
@property (nonatomic, retain) FXLabel *scoreDelta;
@property (weak, nonatomic) IBOutlet UILabel *currentTileNum;
@property (weak, nonatomic) IBOutlet UILabel *totalNumTilesInSequence;
@property (nonatomic) NSInteger numTilesInSequence;
@property (weak, nonatomic) IBOutlet UIButton *nextLevelButton;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *openSideBar;

- (IBAction)showOptions:(id)sender;
- (IBAction)loadNextLevel:(id)sender;
- (IBAction)loadNextSequence:(id)sender;
-(void)updateSequence:(NSInteger)curSequenceNum;
-(void)updateScore:(NSInteger)scoreDelta;
-(void)updateLevel:(NSInteger)level;
-(void)didStopPlayingSequence;
-(void)showNextLevelPrompt;
-(void)showNextSequencePrompt;
-(void)setCurrenttPositionInSequence:(NSInteger)position;

@end
