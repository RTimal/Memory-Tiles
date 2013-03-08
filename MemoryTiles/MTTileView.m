//
//  MTTileView.m
//  MemoryTiles
//
//  Created by Rajiev Timal on 2/2/13.
//  Copyright (c) 2013 HappyBrain. All rights reserved.
//

#import "MTTileView.h"




 
@implementation MTTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
        
    }
    return self;
}


-(void)setTile:(MTTile *)tile {
    self.color = tile.color;
    self.index = tile.index;
    self.frame = CGRectInset(tile.frame, 2, 2);
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    self.opaque = YES;
    [self.layer setNeedsDisplay];
    
}

-(void)playTile {
    [self spin];
}

-(void)spin {
    float duration = .5;
    float rotations = 2;
    float repeat = YES;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
-(void)stopPlayingTileAtIndex:(int)index {
    [UIView animateWithDuration:1.0 animations:^{
        
    }];
    self.layer.borderWidth = 0;
    self.alpha = 1;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 1, self.frame.size.width, self.frame.size.height);
    self.alpha = 0.8;


    [self.delegate tileDidGetSelected:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 1, self.frame.size.width, self.frame.size.height);
    self.alpha = 1;


}

-(void)drawRect:(CGRect)rect {
    //// General Declarations

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor = [UIColor whiteColor];
    CGFloat whiteColorOffset = 0.2f;
   // NSLog(@"self.isselected:%x", self.isSelected);

    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)gradientColor.CGColor,
                               (id)self.color.CGColor,
                               (id)[UIColor blackColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, whiteColorOffset, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, -1.1);
    CGFloat shadowBlurRadius = 6;
    
    //// Abstracted Attributes
    CGRect roundedRectangleRect = CGRectInset(rect, 15, 15);
    CGFloat roundedRectangleStrokeWidth = 15;
    CGFloat roundedRectangleCornerRadius = 20;
    
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: roundedRectangleCornerRadius];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width/2, -0), CGPointMake(rect.size.width/2, rect.size.height), 0);
    CGContextEndTransparencyLayer(context);
    
    ////// Rounded Rectangle Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:0.4] setStroke];
    roundedRectanglePath.lineWidth = roundedRectangleStrokeWidth;
    [roundedRectanglePath stroke];
    CGContextRestoreGState(context);

    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);



    
    
}

-(void)dealloc {

}

@end
