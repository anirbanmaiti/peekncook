//
//  PNCCategory.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/8/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCCategory.h"
#import "PNCRecipe.h"
#import <Quickblox/Quickblox.h>
#import "PNCCoreDataQuery.h"
#import "PNCContentManager.h"


@implementation PNCCategory

@dynamic category_id;
@dynamic menu_id;
@dynamic name;
@dynamic recipe_tag;
@dynamic order;
@dynamic updated_at;
@dynamic recipes;

//- (BOOL)isEqual:(id)other {
//    if (!other || ![other isKindOfClass:[self class]])
//        return NO;
//    PNCCategory *r = (PNCCategory*)other;
//    return [r.category_id isEqualToString: self.category_id];
//}

-(void)updateWithQBCO:(QBCOCustomObject *)co{
    self.category_id = co.ID;
    self.name = [co.fields objectForKey:@"name"];
    self.menu_id = [co.fields objectForKey:@"menu_id"];
    self.recipe_tag = [co.fields objectForKey:@"recipe_tag"];
    self.order = [co.fields objectForKey:@"order"];
    self.updated_at = co.updatedAt;
    
    NSLog(@"PNCCategory:updateWithQBCO: %@", self);
}
-(void)update:(PNCCategory*)tmpObj{
    self.category_id = tmpObj.category_id;
    self.name = tmpObj.name;
    self.menu_id = tmpObj.menu_id;
    self.recipe_tag = tmpObj.recipe_tag;
    self.order = tmpObj.order;
    self.updated_at = tmpObj.updated_at;
    
}

-(void)updateCategoryWithTempContext:(PNCContentManager*)contentManager{
    NSLog(@"update: %@", self);
    
    NSFetchedResultsController *tempCategoryResultsController = [PNCCoreDataQuery recipeResultControllerWithTag:self.recipe_tag withContext:contentManager.qbManagedObjectContext];
    
    NSError *error = nil;
    if (![tempCategoryResultsController performFetch:&error]) {
        NSLog(@"Error! %@",error);
    }
    
    // for every category in Quickblox, check update and update the core data context
    for (PNCRecipe* tmpR in [tempCategoryResultsController fetchedObjects]) {
        
        PNCRecipe* currentR = nil;
        for (PNCRecipe* r in [self.recipes objectEnumerator]) {
            if ([r.recipe_id isEqualToString:tmpR.recipe_id]) {
                currentR = r;
                break;
            }
        }
        if (!currentR) {
            currentR = [contentManager insertRecipe];
            [self addRecipesObject:currentR];
        }
        [currentR update:tmpR];
    }
 
}


/*-(void)fetchRecipes{

    NSMutableDictionary *getRequest = [NSMutableDictionary dictionary];
    [getRequest setObject:@"1" forKey:@"rating[gt]"];
    [getRequest setObject:@"10" forKey:@"limit"];
    
				if (useNewAPI) {
                    [QBRequest objectsWithClassName:MovieClass extendedRequest:getRequest
                                       successBlock:^(QBResponse *response, NSArray *objects, QBResponsePage *page) {
                                           NSLog(@"Successfull response!");
                                       } errorBlock:^(QBResponse *response) {
                                           NSLog(@"Response error:%@", response.error);
                                       }];

}*/
@end
