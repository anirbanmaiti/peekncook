//
//  PNCCategory.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/8/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Quickblox/Quickblox.h>


@class PNCRecipe;
@class PNCContentManager;

@interface PNCCategory : NSManagedObject

@property (nonatomic, retain) NSString * category_id;
@property (nonatomic, retain) NSNumber * menu_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * recipe_tag;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSOrderedSet *recipes;

-(void)updateWithQBCO:(QBCOCustomObject*) co;
-(void)update:(PNCCategory*)tmpObj;
-(void)updateCategoryWithTempContext:(PNCContentManager *)contextManager;
@end

@interface PNCCategory (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(PNCRecipe *)value;
- (void)removeRecipesObject:(PNCRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
