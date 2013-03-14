//
//  MTTileController.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTTilesController.h"


@interface MTTilesController ()

@property (nonatomic) int seqPositionCount;

@end

@implementation MTTilesController

#pragma mark @protocol tileViewDelegate

-(void)tileDidGetSelected:(MTTileView *)tileView {
    BOOL matched = [self.level doesTileIndex:tileView.index matchSeqPosition:_seqPositionCount];
    [self respondToTileSelection:matched];
    _seqPositionCount++;
     [self.dashBoard setCurrenttPositionInSequence:self.seqPositionCount];
}

-(void)respondToTileSelection:(BOOL)matched {
    int scoreDelta = [self.level scorePerTile];
  //  NSLog(@"matched: %x", matched);
    (matched == YES) ? (scoreDelta = scoreDelta) : (scoreDelta = -scoreDelta);
    [self.dashBoard updateScore:scoreDelta];
}

#pragma mark @protocol levelDelegate

-(void)sequenceDidFinishPlaying {
    for( MTTile *tile in _tiles) {
        [self sequenceStoppedPlayingIndex:tile.index];
    }
    [self.dashBoard didStopPlayingSequence];
    self.seqPositionCount = 0;
    [self enableTileViews];
   // NSLog(@"finished sequence");
}

-(void)sequenceDidStartPlaying {
   // NSLog(@"starting sequence");
}

-(void)reachedEndOfGame {
    NSLog(@"end of game, restarting at level 1");
    self.view.userInteractionEnabled = NO;
    
    [self tearDown];
    [self.view setNeedsDisplay];
    [self setup];
    //NSLog(@"Ready to load next level");
    self.view.userInteractionEnabled = YES;
}

-(void)readyToDisplayNextLevel {
    [self disableTileViews];
    [self.dashBoard showNextLevelPrompt];
   // [self displayNextLevel];
    //NSLog(@"Ready to load next level");
    
}

-(void)loadNextLevel {
    [self.level loadNextLevel];
    [self displayNextLevel];
}

-(void)readyToDisplayNextSequence {
    //NSLog(@"Ready to load next sequence");
    [self.dashBoard setNumTilesInSequence:[self.level sequenceLength]];
    self.view.userInteractionEnabled = YES;
    [self disableTileViews];
    [self.dashBoard showNextSequencePrompt];
}

-(void)displayNextLevel {
    [self.dashBoard updateLevel:[self.level curLevel]];
    self.seqPositionCount = 0;
    [self.dashBoard updateSequence:[self.level curSeqNum]];
    self.view.userInteractionEnabled = NO;
    [self tearDown];
    [self setup];
    [self.dashBoard setNumTilesInSequence: [self.level sequenceLength]];
    self.view.userInteractionEnabled = YES;
    self.dashBoard.playButton.userInteractionEnabled = YES;
    [self.dashBoard setCurrenttPositionInSequence:self.seqPositionCount];
}

-(void)displayNextSequence {
    [self tearDown];
    [self setup];
    [self.level loadNextSequence];
    [self.dashBoard setNumTilesInSequence: [self.level sequenceLength]];
    [self enableTileViews];
    [self.dashBoard updateSequence:[self.level curSeqNum]];
}

-(void)sequencePlayingIndex:(int)index {
    MTTileView *tileView = [self.tileViews objectAtIndex:index];
    self.seqPositionCount++;
    [self.dashBoard setCurrenttPositionInSequence:self.seqPositionCount];
    [tileView playTile];
}

-(void)sequenceStoppedPlayingIndex:(int)index {
    MTTileView *tileView = [self.tileViews objectAtIndex:index];
    [tileView stopPlayingTileAtIndex:index];
    self.view.userInteractionEnabled = YES;
}

#pragma mark @protocal dashboardDelegate

-(void)didPressDisplayNextLevel {
    [self displayNextLevel];
}

-(void)didPressDisplayNextSequence {
    [self displayNextSequence];
}

-(void)didPressPlay {
    self.seqPositionCount = 0;
    [self.level playCurrentSequence];
    self.view.userInteractionEnabled = NO;
}

-(void)didPressRepeat {
    _seqPositionCount = 0;
    [self didPressPlay];
}

#pragma mark changeTileviewState

-(void)disableTileViews {
    for(MTTileView* tileview in self.tileViews){
        tileview.userInteractionEnabled = NO;
    }
}

-(void)enableTileViews {
    for(MTTileView* tileview in self.tileViews){
        tileview.userInteractionEnabled = YES;
    }
}

#pragma mark Initialization methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"abg.png"]];
    self.dashBoard = [[MTDashBoardController alloc] initWithNibName:@"MTDashBoardController" bundle:nil];
    self.dashBoard.delegate = self;
       [self addChildViewController:self.dashBoard];
    self.view.userInteractionEnabled = YES;
    [self setup];
    [self.dashBoard setNumTilesInSequence: [self.level sequenceLength]];
}

//resize frame cause it gets messed up when it comes out of storyboard


-(void)setup {
    if(!self.level) {
        self.level = [[MTLevel alloc] init];
        _level.delegate = self;
        [self.dashBoard updateLevel:[self.level curLevel]];
        [self.dashBoard updateSequence:[self.level curSeqNum]];
    }
      _seqPositionCount = 0;
    self.numPerRow = _level.numPerRow;
    self.numRows = _level.numRows;
    self.numTiles = _level.ntls;
    self.tileHeight = (self.view.frame.size.width)/self.numRows;
    self.tileWidth = (self.view.frame.size.height)/self.numPerRow;
    [self loadTiles];
    [self loadTileViews];
}

-(void)loadTiles {
    _tiles = [[NSMutableArray alloc] initWithCapacity:_numTiles];
    float curRow = 0;
    float curColumn = 0;
    for (int i = 0; i< _numTiles; i++) {
        MTTile *tile = [[MTTile alloc] init];
        tile.index = i;
        tile.frame = CGRectMake(curColumn*self.tileWidth, curRow*self.tileHeight, self.tileWidth, self.tileHeight);
        [_tiles insertObject:tile atIndex:i];
        ((int)(i+1) % ((int)self.numPerRow) == 0) ? (curColumn = 0, curRow++) : curColumn++;
    }
}

-(void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
     childController.view.frame = CGRectMake(
        ([UIScreen mainScreen].bounds.size.height - childController.view.frame.size.width)/2,
        ([UIScreen mainScreen].bounds.size.width - childController.view.frame.size.height-10),
        childController.view.frame.size.width,
        childController.view.frame.size.height
    );
    [childController didMoveToParentViewController:self];
    [self.view addSubview:childController.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark cleanup

-(void)tearDown {
    for(MTTileView *tileView  in self.tileViews){
        [tileView removeFromSuperview];
    }
    self.tiles = nil;
    self.tileViews = nil;
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

-(void)loadTileViews {
    _tileViews = [[NSMutableArray alloc] initWithCapacity:_numTiles];
    for (int i = 0 ; i<_numTiles; i++) {
        MTTile *tile = [_tiles objectAtIndex:i];
        MTTileView *tileView = [MTTileView buttonWithType:UIButtonTypeCustom];
        [tileView setTile:tile];
        tileView.delegate = self;
        tileView.exclusiveTouch = YES;
        tileView.showsTouchWhenHighlighted = YES;
        [_tileViews insertObject:tileView atIndex:i];
        [self.view addSubview:tileView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
