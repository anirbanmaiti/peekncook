//
//  PNCRecipeDetailedViewController.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/9/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNCRecipe.h"

@interface PNCRecipeDetailedViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong) PNCRecipe* recipe;
@end
