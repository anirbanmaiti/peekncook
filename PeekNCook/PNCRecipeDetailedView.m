//
//  PNCRecipeDetailedView.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/10/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCRecipeDetailedView.h"
#import "PNCRecipeDetailsTableViewCell.h"

@interface PNCRecipeDetailedView (){
    CGSize _intrensicContentSize;
    PNCRecipe *_recipe;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation PNCRecipeDetailedView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _intrensicContentSize = self.bounds.size;
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _intrensicContentSize = self.bounds.size;
    }
    return self;
}

- (void)initRecipeDetailedView:(PNCRecipe *)recipe{
    _recipe = recipe;
    CGRect bound = self.bounds;
    
//    UINib *nib = [UINib nibWithNibName:@"RecipeDetailedView" bundle:nil];
//    [[self tableView] registerNib:nib forCellReuseIdentifier:@"detailedCell"];
    
    [self tableView].backgroundColor = [UIColor greenColor];
//    [self tableView].translatesAutoresizingMaskIntoConstraints = NO;
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:5.0f]];
//    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-5.0f]];
//    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
//    
////    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-100.0f]];
//    
//    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeCenterXWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterXWithinMargins multiplier:1.0f constant:0.0f]];
    
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    NSLog(@"%f, %f", rect.size.width, rect.size.height);
//}


-(CGSize)intrinsicContentSize{
    return _intrensicContentSize;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"detailedCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

@end
