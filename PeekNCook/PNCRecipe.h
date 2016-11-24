//
//  PNCRecipe.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/8/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Quickblox/Quickblox.h>


@class PNCImage;

@interface PNCRecipe : NSManagedObject

@property (nonatomic, retain) NSNumber * cooking_level;
@property (nonatomic, retain) NSNumber * cooking_time;
@property (nonatomic, retain) NSDate * date_posted;
@property (nonatomic, retain) NSString * facebook_post_id;
@property (nonatomic, retain) NSData * image1x;
@property (nonatomic, retain) UIImage * lowResImage;
@property (nonatomic, retain) UIImage * dashboardImage;
@property (nonatomic, retain) UIImage * detailedImage;
@property (nonatomic, retain) NSString * image_uid;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * postid;
@property (nonatomic, retain) NSString * steps;
@property (nonatomic, retain) NSString * recipe_id;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * recipe_description;
@property (nonatomic, retain) NSString * recipe_short_description;
@property (nonatomic, retain) NSNumber * yields;
@property (nonatomic, retain) NSNumber * total_time;
@property (nonatomic, retain) NSNumber * preparation_time;
@property (nonatomic, retain) NSString * serving_tips;
@property (nonatomic, retain) NSString * name_long;
@property (nonatomic, retain) NSNumber * notes;
@property (nonatomic, retain) NSString * category_tags;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSOrderedSet *images;

-(void)updateWithQBCO:(QBCOCustomObject*) co;
-(void)update:(PNCRecipe*)tmpObj;
@end

@interface PNCRecipe (CoreDataGeneratedAccessors)

- (void)addImagesObject:(PNCImage *)value;
- (void)removeImagesObject:(PNCImage *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
