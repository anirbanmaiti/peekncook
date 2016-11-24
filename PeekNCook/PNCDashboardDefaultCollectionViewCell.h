//
//  PNCDashboardDefaultCollectionViewCell.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/5/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNCDashboardDefaultCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *dataLabel;

- (void)setRecipeImageData:(NSData*)image;
- (void)setRecipeImage:(UIImage*)image;
@end
