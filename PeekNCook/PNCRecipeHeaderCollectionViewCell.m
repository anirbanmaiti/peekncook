//
//  PNCRecipeHeaderCollectionViewCell.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/12/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCRecipeHeaderCollectionViewCell.h"

@interface PNCRecipeHeaderCollectionViewCell ()
@property (nonatomic, strong) PNCRecipe *recipe;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@end

@implementation PNCRecipeHeaderCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setupRecipeHeader:(PNCRecipe *)recipe{
    self.recipe = recipe;
    UIImage *imageData = self.recipe.dashboardImage;
    if (imageData) {
        self.headerImage.image = imageData;
    }
    self.headerLabel.text = recipe.name_long;
    
    
    UIView *headerViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0,self.headerImage.bounds.origin.y + self.headerImage.bounds.size.height, self.bounds.size.width, 20)];
    [headerViewFooter setBackgroundColor:[UIColor clearColor]];
    headerViewFooter.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerViewFooter.layer.borderWidth = 0.5f;
    [headerViewFooter setOpaque:YES];
    [self addSubview:headerViewFooter];

//    CAShapeLayer *line = [CAShapeLayer layer];
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint: CGPointMake(0,10)]; // X and Y, start point
//    [path addLineToPoint:CGPointMake(self.bounds.size.width,10)];
//    //[path closePath];
////    line.lineWidth = 10.0;
////    line.path=path.CGPath;
//    [[UIColor blackColor] setStroke];
//    [[UIColor redColor] setFill];
//    [path stroke];
//    [path fill];
}
@end
