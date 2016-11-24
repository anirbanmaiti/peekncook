//
//  PNCRecipeView.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/11/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNCRecipeDetailsTableViewCell.h"
#import "PNCRecipeDetailedView.h"

@interface PNCRecipeView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

- (void)initRecipeView:(PNCRecipe *)recipe;
- (void)addOrUpdateCustomContraints:(CGSize)size;

@end
