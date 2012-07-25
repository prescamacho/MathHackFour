//
//  OperationsViewController.m
//  MathHackFour
//
//  Created by Ben Butler on 8/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OperationsViewController.h"
#import "DDMathParser.h"
#import "HintView.h"

#import "UIGlossyButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+LayerEffects.h"

@interface OperationsViewController () {
    int actualAnswer;
    NSString *actualAnswerStr;
    NSTimer *timer;
    HintView *hintView;
}

@end

@implementation OperationsViewController

@synthesize answerLabel, problemLabel, probGen, operation;

- (void)setProblemFromSegue:(NSString *)op withHint:(NSString *)newHint
{
    self->operation = op;

    self.probGen = [[ProblemGenerator alloc] init];
    HintView *hv = [[HintView alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 280.0f, 90.0f)
                                           andHint:newHint];
//    [hv setHint:newHint];
    hv.backgroundColor = [UIColor clearColor];
    self->hintView = hv;
    //;    


    NSLog(@"setProblemFromSegue type: %@ --- hint:%@", op, newHint);
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)respondsToSelector:(SEL)aSelector {
    NSLog(@"%@", NSStringFromSelector(aSelector));
    return [super respondsToSelector:(aSelector)];
}


- (void)viewDidLoad
{
    UIGlossyButton *b;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initialiseProblem];
    [self.view addSubview:self->hintView];

    for (int i = 1000; i < 1012; i++) {
    b = (UIGlossyButton*) [self.view viewWithTag: i];
    [b setActionSheetButtonWithColor: [UIColor blackColor]];
    }
    
    b = (UIGlossyButton*) [self.view viewWithTag: 15];
    [b setActionSheetButtonWithColor: [UIColor colorWithRed:204.0f/255.0f green:255.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
}

-(void)viewDidLayoutSubviews
{
    NSLog(@"OVC vewDidLayoutSubviews");    
}

-(void)initialiseProblem
{
    NSString *str = [self.probGen newProblem:self.operation];
    self.problemLabel.text = str;
    self->actualAnswer = [self evaluateToInt:str];
    self->actualAnswerStr = [NSString stringWithFormat:@"%d", self->actualAnswer];
    self.answerLabel.text = @"";
    self.answerLabel.textColor = [UIColor blueColor];
}

- (void)viewDidUnload
{
    [self setProblemLabel:nil];
    self.probGen = nil;
    [self setAnswerLabel:nil];
    self->actualAnswerStr = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)isCorrectOrPartiallyCorrect:(NSString *)updatedAnsStr
{
    if ([self isCorrect:updatedAnsStr]) {
        self.answerLabel.text = updatedAnsStr;
        self.answerLabel.textColor = [UIColor greenColor];   
        self->timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                       target:self 
                                                     selector:@selector(nextProblem) 
                                                     userInfo:nil 
                                                      repeats:NO];
        return;
    }
    
    if (![self isPartiallyCorrect:updatedAnsStr]) {
        self.answerLabel.textColor = [UIColor redColor];
        self->timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                       target:self 
                                                     selector:@selector(clearAnswer) 
                                                     userInfo:nil 
                                                      repeats:NO];
    } else 
        self.answerLabel.textColor = [UIColor blackColor];        
    self.answerLabel.text = updatedAnsStr;
}

/* Handles the pressing of all buttons except C and +/- */
-(IBAction)numberPressed:(id)sender
{
    /* If timer is valid, correct answer is answered and user input is temporarily ignored */
    if ([self->timer isValid])
        return;
    
    UIButton *btn = (UIButton *)sender;
    NSString *updatedAnsStr = [NSString stringWithFormat: @"%@%d", self.answerLabel.text, btn.tag - 1000];

    [self isCorrectOrPartiallyCorrect:updatedAnsStr];
    //[self colourAnswer];
}

/* Handles the C button pressed event */
- (IBAction)decimalPressed:(UIButton *)sender {
    /* If timer is valid, correct answer is answered and user input is temporarily ignored */
    if ([self->timer isValid])
        return;
    UIButton *btn = (UIButton *)sender;
    NSString *updatedAnsStr = [NSString stringWithFormat: @"%@%@", self.answerLabel.text, btn.titleLabel.text];
    [self isCorrectOrPartiallyCorrect:updatedAnsStr];
    
}

- (IBAction)hintPressed:(id)sender {
        //HintView *hv = (HintView *)[self.view.subviews objectAtIndex:0];
        //[hv toggleShowHints];

    [self->hintView toggleShowHints];
}

/* Alters the sign of the answerLabel text */
- (IBAction)changeSignPressed:(UIButton *)sender {
    /* If timer is valid, correct answer is answered and user input is temporarily ignored */
    if ([self->timer isValid])
        return;
    /* If answerLabel text is empty, just add the minus sign */
    if (self.answerLabel.text.length == 0) {
        self.answerLabel.text = @"-";
        [self colourAnswer];
        return;
    }

    if ([self.answerLabel.text characterAtIndex:0] == '-') 
        self.answerLabel.text = [self.answerLabel.text substringFromIndex:1];
    else
        self.answerLabel.text = [NSString stringWithFormat: @"%@%@", @"-", self.answerLabel.text];
    
    if (![self isPartiallyCorrect:answerLabel.text]) {
            self.answerLabel.textColor = [UIColor redColor];
            self->timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                           target:self 
                                                         selector:@selector(clearAnswer) 
                                                         userInfo:nil 
                                                          repeats:NO];
        }
}

#pragma mark Helper methods
/* Checks if a string's intValue is equal to the current problem's answerLabel.text value */
-(BOOL)isCorrect:(NSString *)userAnsStr
{
    return self->actualAnswer == [userAnsStr intValue];
}

/*  Determines if answerString is partially correct. ie The first digits are the same a the actual answser's digits. */
-(BOOL)isPartiallyCorrect:(NSString *)userAnsStr
{
    NSString *compStr = [self->actualAnswerStr substringToIndex:userAnsStr.length];
    NSLog(@"Testing Act:%@ --- User:%@", compStr, userAnsStr);
    return [compStr isEqualToString:userAnsStr];
}

/*  Colors answerLabel.text red if incorrect, green if at least partially correct */
-(void)colourAnswer
{
    if ([self isPartiallyCorrect:self.answerLabel.text]) {
        self.answerLabel.textColor = [UIColor blackColor];
    } else {
        self.answerLabel.textColor = [UIColor redColor];
    }
}

/* String must be of form "a <operation> b =" */
-(int)evaluateToInt:(NSString *)expressionStr
{
    /* Strip spaces and '=' */
    NSString *trimmedString = [expressionStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"=" withString:@""];    
    
    /* Evaluate to int */
    NSNumber *answer = [trimmedString numberByEvaluatingString];
    return answer.intValue;
}

/* Clears answerLabel.text */
-(void)clearAnswer
{
    self.answerLabel.text = @"";
}

/* Generates a new problem */
-(void)nextProblem
{
    [self initialiseProblem];
}




@end
