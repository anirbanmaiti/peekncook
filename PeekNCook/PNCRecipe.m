//
//  PNCRecipe.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/8/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCRecipe.h"
#import "PNCImage.h"


@implementation PNCRecipe

@dynamic cooking_level;
@dynamic cooking_time;
@dynamic date_posted;
@dynamic facebook_post_id;
@dynamic image1x;
@synthesize lowResImage;
@synthesize dashboardImage;
@synthesize detailedImage;
@dynamic ingredients;
@dynamic name;
@dynamic postid;
@dynamic steps;
@dynamic recipe_id;
@dynamic version;
@dynamic recipe_description;
@dynamic recipe_short_description;
@dynamic yields;
@dynamic total_time;
@dynamic serving_tips;
@dynamic name_long;
@dynamic category_tags;
@dynamic notes;
@dynamic preparation_time;
@dynamic updated_at;
@dynamic image_uid;
@dynamic images;

//- (BOOL)isEqual:(id)other {
//    if (!other || ![other isKindOfClass:[self class]])
//        return NO;
//    PNCRecipe *r = (PNCRecipe*)other;
//    return [r.recipe_id isEqualToString: self.recipe_id];
//}

-(void)updateWithQBCO:(QBCOCustomObject *)co{
    self.recipe_id = co.ID;
    self.name = [co.fields objectForKey:@"name"];
    self.recipe_description = [co.fields objectForKey:@"description"];
    self.recipe_short_description = [co.fields objectForKey:@"short_description"];
    self.ingredients = [co.fields objectForKey:@"ingredients"];
    self.yields = [co.fields objectForKey:@"yields"];
    self.cooking_level = [co.fields objectForKey:@"cooking_level"];
    self.cooking_time = [co.fields objectForKey:@"cooking_time"];
    self.name_long = [co.fields objectForKey:@"long_name"];
    self.notes = [co.fields objectForKey:@"notes"];
    self.preparation_time = [co.fields objectForKey:@"preparation_time"];
    self.serving_tips = [co.fields objectForKey:@"serving_tips"];
    self.steps = [co.fields objectForKey:@"steps_to_prepare"];
    self.category_tags = [co.fields objectForKey:@"tags"];
    self.total_time = [co.fields objectForKey:@"total_time"];
    self.version = [co.fields objectForKey:@"version"];
    self.image_uid = [co.fields objectForKey:@"image_uid"];
    self.updated_at = co.updatedAt;
    NSLog(@"PNCRecipe:updateWithQBCO: %@", self);

}
-(void)update:(PNCRecipe *)tmpObj{
    self.recipe_id = tmpObj.recipe_id;
    self.name = tmpObj.name;
    self.recipe_description = tmpObj.recipe_description;
    self.recipe_short_description = tmpObj.recipe_short_description;
    self.ingredients = tmpObj.ingredients;
    self.yields = tmpObj.yields;
    self.cooking_level = tmpObj.cooking_level;
    self.cooking_time = tmpObj.cooking_time;
    self.name_long = tmpObj.name_long;
    self.notes = tmpObj.notes;
    self.preparation_time = tmpObj.preparation_time;
    self.serving_tips = tmpObj.serving_tips;
    self.steps = tmpObj.steps;
    self.category_tags = tmpObj.category_tags;
    self.total_time = tmpObj.total_time;
    self.version = tmpObj.version;
    self.image_uid = tmpObj.image_uid;
    self.updated_at = tmpObj.updated_at;
    
}











@end
