//
//  HintView.m
//  MathHackFour
//
//  Created by Ben Butler on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HintView.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAShapeLayer.h>

@implementation HintView
{
    CAShapeLayer *sl;
    CGRect rect;
    UILabel* hintLabel;
}

//@synthesize hint;

- (id)initWithFrame:(CGRect)frame andHint:(NSString *)newHint
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self->rect = frame;
        NSLog(@"initWithFramed HintView");
//        UILabel *labl = [[UILabel new] initWithFrame:CGRectMake(15.0f, 5.0f, 250.0f, 80.0f)];
        UILabel *labl = [[UILabel new] initWithFrame: CGRectInset(frame, 10.0f, 10.0f)];

        [labl setCenter:CGPointMake(140.0f, 45.0f)];
        [labl setBaselineAdjustment:YES];
        [labl setNumberOfLines:3];
//        self.contentMode
        labl.font = [UIFont fontWithName:@"Noteworthy" size:14.0f];
        labl.text = newHint;
        labl.textColor = [UIColor blackColor];
        labl.textAlignment = UITextAlignmentCenter;
        self->hintLabel = labl;
        
        [self addSubview:self->hintLabel];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSLog(@"init HintView");
        //self->rect = CGRectMake(0.0f, 0.0f, 280.0f, 90.0f);
    }
    return self;
}

-(void) drawRect:(CGRect)rect 
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGRect shapeRect = self->rect;
    [shapeLayer setBounds:shapeRect];
    [shapeLayer setPosition:CGPointMake(140.0f, 45.0f)];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setLineWidth:0.5f];
    [shapeLayer setLineJoin:kCALineJoinRound];
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:
//                                    [NSNumber numberWithInt:10], 
//                                    [NSNumber numberWithInt:5], 
//                                    nil]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:15.0];
    [shapeLayer setPath:path.CGPath];
    self->sl = shapeLayer;
    [[self layer] addSublayer:shapeLayer];
    [self bringSubviewToFront:hintLabel];

    //[self toggleMarching];
    
    NSLog(@"%@", @"Done drawRect");
    
}

-(void) setHint:(NSString *)newHint
{

    self->hintLabel.text = newHint;
}

- (void)toggleMarching
{
    if ([self->sl animationForKey:@"linePhase"])
        [self->sl removeAnimationForKey:@"linePhase"];
    else {
        CABasicAnimation *dashAnimation;
        dashAnimation = [CABasicAnimation 
                         animationWithKeyPath:@"lineDashPhase"];
        
        [dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
        [dashAnimation setToValue:[NSNumber numberWithFloat:15.0f]];
        [dashAnimation setDuration:0.75f];
        [dashAnimation setRepeatCount:10000];
        
        [self->sl addAnimation:dashAnimation forKey:@"linePhase"];
        
    }
}

-(void)toggleShowHints
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect newHintsFrame = self.frame;
        int currY = newHintsFrame.origin.y;
        if (currY == 0.0f) {
            newHintsFrame.origin.y = -91;
        } else {
            newHintsFrame.origin.y = 0;

        }
        self.frame = newHintsFrame;        
        NSLog(@"HintView origin.y = %f", self.frame.origin.y);
        NSLog(@"Superview origin.y = %f", self.superview.frame.origin.y);        
    }];

}

@end
