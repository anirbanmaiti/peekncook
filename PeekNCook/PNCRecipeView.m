//
//  PNCRecipeView.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/11/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCRecipeView.h"
#import "PNCRecipeHeaderCollectionViewCell.h"

@interface PNCRecipeView (){
    CGSize _intrensicContentSize;
    PNCRecipe *_recipe;
}
//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@end

@implementation PNCRecipeView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initRecipeView:(PNCRecipe *)recipe{
    _intrensicContentSize = self.superview.bounds.size;
    _recipe = recipe;
//    [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        UINib *nib = [UINib nibWithNibName:@"RecipeHeaderView" bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:@"detailHeaderCell"];

    nib = [UINib nibWithNibName:@"RecipeDetailsView" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:@"recipeDetailsDataViewCell"];

//
//    [self tableView].backgroundColor = [UIColor greenColor];
//        self.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:5.0f]];
    //
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-5.0f]];
    //
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //
    ////    [self addConstraint:[NSLayoutConstraint constraintWithItem:[self tableView] attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-100.0f]];
    //
    //    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeCenterXWithinMargins relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterXWithinMargins multiplier:1.0f constant:0.0f]];
}


- (void)handleInterfaceOrientationChangedNotification:(NSNotification *)not
{
    [self addOrUpdateCustomContraints:self.bounds.size];
//    if ([self.currentActiveNVC shouldAutorotate])
//    {
//        CGRect bounds = self.view.bounds;
//        self.rightMenu.view.frame = CGRectMake(bounds.size.width - [self rightMenuWidth],0,[self rightMenuWidth],bounds.size.height);
//        self.leftMenu.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);
//        if (self.overlayView && self.overlayView.superview)
//        {
//            self.overlayView.frame = CGRectMake(0, 0, self.currentActiveNVC.view.frame.size.width, self.currentActiveNVC.view.frame.size.height);
//        }
//        
//        double delayInSeconds = 0.25f;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self configureSlideLayer:self.currentActiveNVC.view.layer];
//        });
//    }
}

-(void) addOrUpdateCustomContraints:(CGSize)size{
    
    [self.superview removeConstraints:self.constraints];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    
    //[self needsUpdateConstraints];
    
}


-(CGSize)intrinsicContentSize{
    return self.superview.bounds.size;;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.row == 0) {
    cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"detailHeaderCell" forIndexPath:indexPath];
        
        PNCRecipeHeaderCollectionViewCell *header = (PNCRecipeHeaderCollectionViewCell*) cell;
        [header setupRecipeHeader:_recipe];
    }else{
    
    cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"recipeDetailsDataViewCell" forIndexPath:indexPath];
    }
    
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return CGSizeMake(self.superview.bounds.size.width, 205);
    }
    return CGSizeMake(self.superview.bounds.size.width, self.superview.bounds.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
