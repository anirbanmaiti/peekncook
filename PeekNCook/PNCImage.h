//
//  PNCImage.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/8/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PNCRecipe;

@interface PNCImage : NSManagedObject

@property (nonatomic, retain) NSData * image_blob;
@property (nonatomic, retain) NSNumber * image_id;
@property (nonatomic, retain) PNCRecipe *recipe;

@end
