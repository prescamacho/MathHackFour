//
//  ProblemGenerator.m
//  MathHackFour
//
//  Created by Ben Butler on 8/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProblemGenerator.h"

@implementation ProblemGenerator 


-(NSString *)newProblem:(NSString *)type
{
    NSString *prob = @"ERROR";
    int a = arc4random() % 100;
    int b = arc4random() % 100;
    
    if ([type isEqualToString:@"Addition"])
        prob = [NSString stringWithFormat: @"%d + %d =", a, b];
    if ([type isEqualToString:@"Subtraction"])
        prob = [NSString stringWithFormat: @"%d - %d =", a, b];
    if ([type isEqualToString:@"Division"])
        prob = [NSString stringWithFormat: @"%d / %d =", a, b];
    if ([type isEqualToString:@"Multiplication"])
        prob = [NSString stringWithFormat: @"%d × %d =", a, b];
    if ([type isEqualToString:@"11 Times"]) 
        prob = [self elevenTimes];
    if ([type isEqualToString:@"Quick Square"]) 
        prob = [self quickSquare];    
    if ([type isEqualToString:@"5 Times"]) 
        prob = [self fiveTimes];        
    if ([type isEqualToString:@"9 Times"]) 
        prob = [self nineTimes]; 
    if ([type isEqualToString:@"4 Times"]) 
        prob = [self fourTimes];              
//    if ([type isEqualToString:@"Tough Multiplication"]) 
//        prob = [self toughMultiplication];              
    if ([type isEqualToString:@"Divide by 5"]) 
        prob = [self divFive];  
    if ([type isEqualToString:@"1000 Minus"])
        prob = [self subtractFrom1000];      
    if ([type isEqualToString:@"15 Times"])
        prob = [self fifteenTimes];          
    return prob;
}

-(NSString *)fifteenTimes
{
    int a = 10 + arc4random() % 89;
    int b = 15;
    
    return [NSString stringWithFormat:@"%d × %d =", a, b];
}
-(NSString *)subtractFrom1000
{
    int a = 100 + arc4random() % 899;
    int b = 1000;
    
    return [NSString stringWithFormat:@"%d - %d =", b, a];
}

-(NSString *)divFive
{
    int a = 100 + arc4random() % 899;
    int b = 5;
    
    return [NSString stringWithFormat:@"%d / %d =", a, b];
}

-(NSString *)toughMultiplication
{
    int a = 100 + arc4random() % 899;
    int b = 2 * (arc4random() % 50);

    return [NSString stringWithFormat:@"%d × %d =", a, b];
}

-(NSString *)elevenTimes
{
    int a = arc4random() % 999;
    int b = 11;
    
    return [NSString stringWithFormat:@"%d × %d =", a, b];
}

-(NSString *)fourTimes
{
    int a = 10 + arc4random() % 89;
    int b = 4;
    
    return [NSString stringWithFormat:@"%d × %d =", a, b];
}

-(NSString *)nineTimes
{
    int a = 1 + arc4random() % 9;
    int b = 9;
    
    return [NSString stringWithFormat:@"%d × %d =", a, b];
}

-(NSString *)quickSquare
{
    int a = 1 + arc4random() % 8;
    NSString *aStr = [NSString stringWithFormat:@"%d%d", a, 5];
    
    return [NSString stringWithFormat:@"%@ × %@ =", aStr, aStr];
}

-(NSString *)fiveTimes
{
    int a = 10 + arc4random() % 9990;
    
    NSString *aStr = [NSString stringWithFormat:@"%d × %d =", a, 5];
    
    return aStr;
}
@end
