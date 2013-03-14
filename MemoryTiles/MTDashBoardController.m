//
//  MTDashBoardController.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/9/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTDashBoardController.h"
#import "MTOptionsController.h"

@interface MTDashBoardController ()

@end

@implementation MTDashBoardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)didStopPlayingSequence {
    NSLog(@"sequence stopped playing");
    self.currentTileNum.text = [NSString stringWithFormat:@"%i", 0];
    [UIView animateWithDuration:.5 animations:^{
        self.playingSequence.alpha = 0;
    }];
    
    self.playingSequence.text = @"Your turn, repeat the sequence!";
    
    [UIView animateWithDuration:.4f animations:^{
        self.playingSequence.alpha = 1;
    } completion:^(BOOL success) {
        [UIView animateWithDuration:2.f animations:^{
            self.playingSequence.alpha = 0;
        }];
    }];
}

- (IBAction)loadNextSequence:(id)sender {
    [self.delegate didPressDisplayNextSequence];
    self.totalNumTilesInSequence.text = [NSString stringWithFormat:@"%i", self.numTilesInSequence];
    self.playButton.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:.5 animations:^{
        self.nextSequence.alpha = 0;
        self.loadNextSequence.alpha  = 0;
        self.playButton.alpha = 1;
    }];
    self.scoreDelta.alpha = 0;
    self.scoreDelta.hidden = NO;
    self.currentTileNum.text = [NSString stringWithFormat:@"%i", 0];
}

-(void)showNextLevelPrompt {
    self.nextLevelButton.hidden = NO;
    self.playButton.hidden = YES;
}

- (IBAction)showOptions:(id)sender {

  MTOptionsController *options = [[MTOptionsController alloc]initWithNibName:@"MTOptionsController" bundle:nil];
    options.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:options];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}

-(void)resetGame {
    [self.delegate resetGame];
    [self reset];
}
-(void)reset {
    self.playButton.alpha = 1;
    self.nextSequence.alpha = 0;
    self.nextLevelButton.alpha = 0;
}


- (IBAction)loadNextLevel:(id)sender {
    [self.delegate loadNextLevel];
    self.playButton.hidden = NO;
    self.nextLevelButton.hidden = YES;
}

-(void)showNextSequencePrompt {
    //self.scoreDelta.hidden = YES;
    self.playButton.userInteractionEnabled = NO;
    self.playingSequence.alpha = 0;
    [UIView animateWithDuration:.5 animations:^{
        self.nextSequence.alpha = 1;
        self.loadNextSequence.alpha = 1;
        self.playButton.alpha = 0;
    }];
}

#pragma mark update score
-(void)updateScore:(NSInteger)scoreDelta {
  //  NSLog(@"score delta, %i", scoreDelta);
    NSInteger currentScore = [self.score.text integerValue];
    currentScore += scoreDelta;
    self.score.text = [NSString stringWithFormat:@"%i",currentScore];
    if([self.score.text integerValue] < 0){
        self.score.text = [NSString stringWithFormat:@"%i", 0];
    }
    
    if([self.highScore.text integerValue] < [self.score.text integerValue]) {
        self.highScore.text = self.score.text;
        [self saveHighScore];
        [self showPopUp:@"New High Score"];
    }
    
    [self popUpDelta:scoreDelta];
}

-(void)popUpDelta:(NSInteger)delta {
    if(delta<=0) {
        self.scoreDelta.textColor = [UIColor redColor];
        [self showPopUpDelta:[NSString stringWithFormat:@"%i", delta]];
    } else {
        self.scoreDelta.textColor = [UIColor greenColor];
        [self showPopUpDelta:[NSString stringWithFormat:@"+%i", delta]];
    }
}

-(void)showPopUp:(NSString*)text {
    self.highScoreLabel.frame = CGRectMake(700.f, 36.f, 274.f, 34.f);
    self.highScoreLabel.alpha = 1;
    [UIView beginAnimations:@"popup2" context:nil];
    [UIView setAnimationDuration:.8f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationWillStartSelector:@selector(startingPopupAnimation)];
    [UIView setAnimationDidStopSelector:@selector(stoppedPopupAnimation)];
    self.highScoreLabel.frame = CGRectOffset(self.highScoreLabel.frame, 0.f, -500.f);
    self.highScoreLabel.alpha = 0;
    //self.highScoreLabel.alpha = 0;
    [UIView commitAnimations];
}

-(void)showPopUpDelta:(NSString *)delta {
    self.scoreDelta.text = delta;
   // NSLog(@"delta: %@", delta);
    self.scoreDelta.frame = CGRectMake(640.f, -40.f, 80.f, 80.f);
     self.scoreDelta.alpha = 1;
    [self.dashBoardView addSubview:self.scoreDelta];
    [UIView beginAnimations:@"popup" context:nil];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationWillStartSelector:@selector(startingPopupAnimation)];
    [UIView setAnimationDidStopSelector:@selector(stoppedPopupAnimation)];
    self.scoreDelta.frame = CGRectOffset(self.scoreDelta.frame, 0, -200.f);
    self.scoreDelta.alpha = 0;
    [UIView commitAnimations];
}

-(void)startingAnimation {
    [self.view.layer removeAllAnimations];
}

-(void)viewDidDisappear:(BOOL)animated {
  //  [self saveHighScore];
}

-(void)loadHighScore {
  
    NSLog(@"%@",self.defaults);
    NSLog(@"loading high score");
    NSLog(@"%@",[self.defaults objectForKey:@"highscore"]);
    self.highScore.text = [self.defaults objectForKey:@"highscore"];
    NSLog(@"high score: %@", self.highScore.text);
}


-(void)saveHighScore {
    NSLog(@"saving high score");
        NSLog(@"%@", self.highScore.text);
    [self.defaults setObject:self.highScore.text forKey:@"highscore"];
    [self.defaults synchronize];
}

-(void)gameOver {
    self.score.text = [NSString stringWithFormat:@"%i", 0];
    self.sequence.text = [NSString stringWithFormat:@"%i", 1];
    self.level.text = [NSString stringWithFormat:@"%i", 1];

}

-(void)updateSequence:(NSInteger)curSequenceNum {
    self.sequence.text = [NSString stringWithFormat:@"%i", curSequenceNum+1];
}

-(void)updateLevel:(NSInteger)level {
    self.level.text = [NSString stringWithFormat:@"%i", level];
}

-(void)didPressPlay {
    self.playingSequence.text = @"Playing tile sequence, watch carefully!";
    [UIView animateWithDuration:1.0 animations:^{} completion:^(BOOL finished) {
        self.playingSequence.alpha = 1;
        self.playButton.alpha = 0;
    }];
    [self.delegate didPressPlay];
}


#pragma mark Current position in sequence

-(void)setCurrenttPositionInSequence:(NSInteger)position {
    self.currentTileNum.text = [NSString stringWithFormat:@"%i", position];
}

-(void)setNumTilesInSequence:(NSInteger)numTilesInSequence {
    _numTilesInSequence = numTilesInSequence;
    self.totalNumTilesInSequence.text = [NSString stringWithFormat:@"%i", numTilesInSequence];
}

#pragma mark Initialization methods

-(void)viewDidAppear:(BOOL)animated {
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self loadHighScore];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.playButton addTarget:self action:@selector(didPressPlay) forControlEvents:UIControlEventTouchUpInside];
    self.scoreDelta = [[FXLabel alloc] init];
    self.scoreDelta.adjustsFontSizeToFitWidth = YES;
    self.scoreDelta.minimumFontSize = 10.f;
    self.scoreDelta.font = [UIFont fontWithName:@"Helvetica" size:60.f];
    self.scoreDelta.shadowOffset = CGSizeMake(0.f, 1.f);
    self.scoreDelta.shadowColor = [UIColor darkGrayColor];
    self.scoreDelta.innerShadowColor = [UIColor blackColor];
    self.scoreDelta.backgroundColor = [UIColor clearColor];
    self.scoreDelta.opaque = NO;
    self.scoreDelta.innerShadowOffset = CGSizeMake(1,0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
