//
//  PNCDashboardDefaultCollectionViewCell.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/5/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCDashboardDefaultCollectionViewCell.h"
#import "PNCUtilities.h"

@implementation PNCDashboardDefaultCollectionViewCell{
    UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:0.0f];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderColor:[[UIColor colorWithWhite:0.8f alpha:1.0f] CGColor]];
        [self.layer setBorderWidth:0.8f];
        [self.layer setShadowOffset:CGSizeMake(2, 2)];
        [self.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
        [self.layer setShadowRadius:3.0];
        [self.layer setShadowOpacity:0.8];
        
        // Initialization code
        _dataLabel = [[UILabel alloc] init];
        [self.dataLabel setFrame:CGRectMake(10, 3, 320, 20)];
        [self.dataLabel setBackgroundColor:[UIColor clearColor]];
        [self.dataLabel setFont:[UIFont fontWithName:@PNC_FONT size:(14.0)]];
        [self.dataLabel setNumberOfLines:0];
        [self.dataLabel setShadowColor:[UIColor colorWithWhite:1.0f alpha:0.6f]];
        [self.dataLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
        [self addSubview:self.dataLabel];



        _imageView = [[UIImageView alloc] init];
//        [_imageView setFrame:CGRectMake(5, 25, 182, 150)];
        [_imageView setFrame:CGRectMake(0, 25, 190, 150)];
        //[_imageView setImage:[UIImage imageNamed:@"Background"]];
//        [_imageView setAlpha:1.0];
        _imageView.layer.shadowOffset = CGSizeMake(0, 1);
        _imageView.layer.shadowOpacity = 1;
        _imageView.layer.shadowRadius = 2.0;
        [_imageView.layer setBorderColor:[[UIColor colorWithWhite:0.85f alpha:1.0f] CGColor]];
        [_imageView.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
        _imageView.clipsToBounds = NO;
//        [_imageView.layer setCornerRadius:2.0f];
        [self addSubview:_imageView];
//
//        UILabel *note = [[UILabel alloc] init];
//        [note setFrame:CGRectMake(10, 10, 60, 20)];
//        [note setText:@"Note: "];
//        [note setBackgroundColor:[UIColor clearColor]];
//        [note setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:17]];
//        [self addSubview:note];
//        
//        _noteLabel = [[UILabel alloc] init];
//        [self.noteLabel setFrame:CGRectMake(70, 10, 260, 20)];
//        [self.noteLabel setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:self.noteLabel];
//        
//        UILabel *status = [[UILabel alloc] init];
//        [status setFrame:CGRectMake(10, 30, 60, 20)];
//        [status setText:@"Status: "];
//        [status setBackgroundColor:[UIColor clearColor]];
//        [status setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:17]];
//        [self addSubview:status];
//        
//        _statusLabel = [[UILabel alloc] init];
//        [self.statusLabel setFrame:CGRectMake(70, 30, 260, 20)];
//        [self.statusLabel setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:self.statusLabel];
//        
//        UILabel *date = [[UILabel alloc] init];
//        [date setFrame:CGRectMake(10, 50, 60, 20)];
//        [date setText:@"Data: "];
//        [date setBackgroundColor:[UIColor clearColor]];
//        [date setFont:[UIFont boldSystemFontOfSize:14.0f]];
//        [self addSubview:date];
//        
//        _dataLabel = [[UILabel alloc] init];
//        [self.dataLabel setFrame:CGRectMake(70, 50, 260, 20)];
//        [self.dataLabel setBackgroundColor:[UIColor clearColor]];
//        [self.dataLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
//        [self.dataLabel setNumberOfLines:0];
//        [self addSubview:self.dataLabel];
        
    }
    
    return self;
}
- (void)setRecipeImage:(UIImage*)image{
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = image;
    });
}
- (void)setRecipeImageData:(NSData*)image{
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = [UIImage imageWithData:image];
    });
}

//- (void)drawRect:(CGRect)rect {
//    CGRect bounds = self.bounds;
//    CGFloat bottomOffset = 1.0f;
//    UIColor *topBorderColor = [UIColor colorWithRed:138./255. green:138./255. blue:141./255. alpha:1.0f];
//    UIColor *bottomBorderColor = [UIColor colorWithRed:138./255. green:138./255. blue:141./255. alpha:1.0f];
//    [topBorderColor set];
//    UIRectFill(CGRectMake(0.0f, 0.0f, bounds.size.width, 1.0f));
//    [bottomBorderColor set];
//    UIRectFill(CGRectMake(0.0f, bounds.size.height - bottomOffset, bounds.size.width, 1.0f));
//    UIRectFill(CGRectMake(0.0f, 0.0f , 1.0f, bounds.size.height - bottomOffset));
//    UIRectFill(CGRectMake(bounds.size.width - 1.0f, 0.0f , 1.0f, bounds.size.height - bottomOffset));
//}


@end
