//
//  PNCSectionSeperator.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/23/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNCSectionSeperator : UIViewController

-(UIView *)makeView;
-(CGFloat)contentHeight;
-(void)addConstraints:(UIView*)parentView viewAbove:(UIView*) aboveView;
- (void) updateHeightConstraint;

@property (assign, nonatomic) BOOL isLastSeperator;

@end
