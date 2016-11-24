//
//  PNCCoreDataQuery.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/8/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNCAppDelegate.h"


@interface PNCCoreDataQuery : NSObject

+(NSFetchedResultsController*) categoryResultControllerForMenu:(NSNumber*)menu_id withContext:(NSManagedObjectContext*)context;

+(NSFetchedResultsController*) recipeResultControllerWithTag:(NSString*)tag withContext:(NSManagedObjectContext*)context;

@end
