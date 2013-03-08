//
//  MTDashBoardView.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/5/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTDashBoardView.h"

@implementation MTDashBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //create stuff here
    }
    return self;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset=CGSizeMake(-1, -1);
    self.layer.shadowOpacity = .1;
    self.layer.shadowRadius = 20;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = shadowPath.CGPath;
}

-(void)addMiniTileWithColor:(UIColor *)color andCorrectStatus:(BOOL)rightTile {
//add a mini tile if u want to.
}

-(void)clearMiniTileView {
    
}

-(void)drawRect:(CGRect)rect{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:20.0];
    [path addClip];
    [[UIColor blackColor] setFill];
    [[UIColor whiteColor] setStroke];
    [path fillWithBlendMode:kCGBlendModeNormal alpha:.1];
    [path stroke];
}

@end
