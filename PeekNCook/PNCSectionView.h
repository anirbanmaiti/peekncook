//
//  PNCSectionView.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/23/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNCUtilities.h"

@interface PNCSectionView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *headerText;
@property (strong, nonatomic) NSString *contentText;
@property (assign, nonatomic) BOOL showTruncatedText;
@property (assign, nonatomic) BOOL contentHasReducedHeight;
@property (assign, nonatomic) CGFloat targetTruncatedContentHeight;

-(UIView *)makeView;
-(CGFloat)contentHeight;
- (void)addConstraints:(UIView*)parentView viewAbove:(UIView*) aboveView;
@end
