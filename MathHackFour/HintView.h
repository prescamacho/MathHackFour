//
//  HintView.h
//  MathHackFour
//
//  Created by Ben Butler on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HintView : UIView
//@property (strong, nonatomic) UILabel* hint;
-(void)toggleShowHints;
-(void) setHint:(NSString *)newHint;
- (id)initWithFrame:(CGRect)frame andHint:(NSString *)newHint;
@end
