//
//  PNCUtilities.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/10/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


#define PNC_FONT "AppleSDGothicNeo-Light"
#define PNC_FONT_BOLD "AppleSDGothicNeo-Regular"
#define PNC_FONT_HEADER "AppleSDGothicNeo-Bold"

@interface PNCUtilities : NSObject
+ (UIImage*) resizedImage:(UIImage *)inImage withRect: (CGRect) thumbRect;
+ (UIImage*) resizedImage:(UIImage *)inImage withSize: (CGSize) thumbSize;
@end

@protocol PNCViewHeightUpdateDelegate <NSObject>

-(void) didSubViewUpdated;

@end