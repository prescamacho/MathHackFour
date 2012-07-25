//
//  OperationsViewController.h
//  MathHackFour
//
//  Created by Ben Butler on 8/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProblemGenerator.h"
@class HintView;

@interface OperationsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *problemLabel;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;
@property (strong, nonatomic) ProblemGenerator *probGen;
@property (strong, nonatomic) NSString *operation;


- (IBAction)numberPressed:(id)sender;
- (IBAction)decimalPressed:(UIButton *)sender;
- (IBAction)hintPressed:(id)sender;
- (IBAction)changeSignPressed:(UIButton *)sender;

- (void)setProblemFromSegue:(NSString *)op withHint:(NSString *)newHint;

@end
