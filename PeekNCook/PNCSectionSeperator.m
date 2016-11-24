//
//  PNCSectionSeperator.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/23/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCSectionSeperator.h"

@interface PNCSectionSeperator ()
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) NSMutableArray *autoLayoutConstraints;
@property (strong, nonatomic) NSArray *autoLayoutHeightConstraint;
@end

@implementation PNCSectionSeperator

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLastSeperator = NO;
    self.autoLayoutConstraints = [NSMutableArray array];
    self.autoLayoutHeightConstraint = nil;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)makeView{
    self.separatorView = [UIView new];
    self.separatorView.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];//[UIColor colorWithRed:0.95 green:0.47 blue:0.48 alpha:1.0];
    
    //CGFloat borderWidth = 0.5f;
    //self.separatorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.separatorView.layer.borderWidth = borderWidth;
    return self.separatorView;
}

-(CGFloat)contentHeight{
    if (self.isLastSeperator) {
        return 22.0f;
    }
    return self.separatorView.bounds.size.height;
}

- (void) updateHeightConstraint{
    [self.separatorView removeConstraints:self.autoLayoutHeightConstraint];
    
    NSString *contentHeight = @"22";
    if (self.isLastSeperator) {
        contentHeight = @"500";
    }
    NSString *heightVisualFormat = [NSString stringWithFormat:@"V:[thisView(%@)]", contentHeight];
    NSDictionary *viewsDictionary = @{@"thisView":self.separatorView};
    self.autoLayoutHeightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:heightVisualFormat
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
    
    [self.separatorView addConstraints:self.autoLayoutHeightConstraint];
}

- (void)addConstraints:(UIView*)parentView viewAbove:(UIView*) aboveView{
 
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView removeConstraints:self.autoLayoutConstraints];
    [self.autoLayoutConstraints removeAllObjects];
    
    [self updateHeightConstraint];
    
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:aboveView attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual toItem:self.separatorView
                                                                   attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    [parentView addConstraint:constraint];
    [self.autoLayoutConstraints addObject:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:parentView
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual toItem:self.separatorView
                                              attribute:NSLayoutAttributeTrailing
                                             multiplier:1.0 constant:0.0];
    [parentView addConstraint:constraint];
    [self.autoLayoutConstraints addObject:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:parentView
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.separatorView
                                              attribute:NSLayoutAttributeLeading
                                             multiplier:1.0 constant:0.0];
    [parentView addConstraint:constraint];
    [self.autoLayoutConstraints addObject:constraint];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
