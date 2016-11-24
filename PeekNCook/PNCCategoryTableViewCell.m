//
//  PNCCategoryTableViewCell.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/9/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCCategoryTableViewCell.h"

@implementation PNCCategoryTableViewCell{
    UIBezierPath *_path;
    UIBezierPath *_insidePath;
    CGRect _currentRect;
}

- (void)awakeFromNib {
    // Initialization code
    
    _currentRect = CGRectZero;
    //create triangle path
//    UIBezierPath* path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 30)];
//    [path addLineToPoint:CGPointMake(100, 30)];
//    [path addLineToPoint:CGPointMake(100, 0)];
//    [path addLineToPoint:CGPointMake(0, 30)];
//    
//    //apply path to shapelayer
//    CAShapeLayer* greenPath = [CAShapeLayer layer];
//    greenPath.path = path.CGPath;
//    [greenPath setFillColor:[UIColor whiteColor].CGColor];
//    [greenPath setStrokeColor:[UIColor blueColor].CGColor];
//    greenPath.frame=CGRectMake(0, 0,100,30);
//    
//    //add shape layer to view's layer
//    [[self layer] addSublayer:greenPath];

//    self.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:0.85f alpha:1.0f];
//    [self.layer setCornerRadius:5.0f];
//    [self.layer setMasksToBounds:NO];
//    [self.layer setBorderWidth:0.0f];
//    [self.layer setShadowOffset:CGSizeMake(2.0f, 2.0f)];
//    [self.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
//    [self.layer setShadowRadius:3.0];
//    [self.layer setShadowOpacity:0.5];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
//    frame.origin.y += 2;
    frame.size.height -= 3 * 4;
    //frame.origin.x += 4;
    //frame.size.width -= 2 * 4;
    [super setFrame:frame];
}

- (void)drawRect:(CGRect)rect {
    
    // rotation would change the rect
    if (!CGRectEqualToRect(rect, _currentRect)) {
        _path = nil;
        _insidePath = nil;
        _currentRect = rect;
    }
    
    if (_path == nil || _insidePath == nil) {
        CGFloat radius =  4;
        CGFloat leftSpacing = 5.0f;
        CGFloat rightSpacing = 5.0f;
        CGFloat borderWidth = 0.7f;
        CGRect bounds = self.bounds;
        CGRect area = CGRectMake(leftSpacing ,0,bounds.size.width - leftSpacing - rightSpacing ,bounds.size.height);
        CGRect insideArea = CGRectMake(leftSpacing + borderWidth ,
                                       0 + borderWidth,
                                       bounds.size.width - leftSpacing - rightSpacing - borderWidth * 2,
                                       bounds.size.height - borderWidth * 2);
        _path = [UIBezierPath bezierPathWithRoundedRect:area cornerRadius:radius];
        _insidePath = [UIBezierPath bezierPathWithRoundedRect:insideArea cornerRadius:radius];
    }
    [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2] setFill];
    [_path fill];
    [[UIColor whiteColor] setFill];
    [_insidePath fill];

    //CGRect bounds = self.bounds;
    
//    [[UIColor whiteColor] setFill];
//    UIRectFill(dirtyRect);
//    
//    CGRect rect = self.bounds;
//    CGFloat size = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect)) - 20;
//    size = round(size / 2) * 2;
//    rect = CGRectMake(round(CGRectGetMidX(rect) - size / 2), round(CGRectGetMidY(rect) - size / 2), size, size);
//    CGFloat radius = size / 4;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
//    [[UIColor colorWithRed:0.90 green:0.93 blue:1.0 alpha:1.0] setFill];
//    [path fill];
    
//    CGPathRef cgPath = path.CGPath;
//    CGPathApply(cgPath, (__bridge void *)(self), pathInspector);
    
    /*CGFloat borderWidth = 0.5f;
    UIColor *topBorderColor = [UIColor colorWithRed:138./255. green:138./255. blue:141./255. alpha:1.0f];
    UIColor *bottomBorderColor = [UIColor colorWithRed:138./255. green:138./255. blue:141./255. alpha:1.0f];
    [topBorderColor set];
    UIRectFill(CGRectMake(5.0f, 0.0f, bounds.size.width - 10.0f, 1.0f));
    [bottomBorderColor set];
    UIRectFill(CGRectMake(5.0f, bounds.size.height - borderWidth, bounds.size.width -9.f, borderWidth));
    // left
    UIRectFill(CGRectMake(5.0f, 0.0f , borderWidth, bounds.size.height - borderWidth));
    // right
    UIRectFill(CGRectMake(bounds.size.width - 5.0f, 0.0f , borderWidth, bounds.size.height - borderWidth));
    
    [[UIColor whiteColor] set];
    UIRectFill(CGRectMake(5.0f + borderWidth, borderWidth, bounds.size.width + borderWidth - 10.0f, bounds.size.height - borderWidth * 2));*/

}


@end
