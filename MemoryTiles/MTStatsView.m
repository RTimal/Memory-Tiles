//
//  MTStatsView.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 3/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTStatsView.h"

@implementation MTStatsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib {
    self.clipsToBounds = YES;
}

- (void)drawRect:(CGRect)rect {
        [super drawRect:rect];
    NSLog(@"drawing rect");
    UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(20.f, 20.f)];
    [path addClip];
    CGContextClip(UIGraphicsGetCurrentContext());
    [[UIColor colorWithRed:0.f green:1.f blue:.0f alpha:1.f] setFill];
    [path fillWithBlendMode:kCGBlendModeNormal alpha:.04];
    [[UIColor greenColor] setStroke];
    [path strokeWithBlendMode:kCGBlendModeNormal alpha:0.2];
}


@end
