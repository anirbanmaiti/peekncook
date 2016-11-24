//
//  PNCContentManager.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/6/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNCRecipe.h"
#import "PNCCategory.h"
#import "PNCImage.h"

@protocol PNCContentManagerDelegate <NSObject>

-(void)initialSyncCompleted;

@end

@interface PNCContentManager : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) NSDictionary *data;
@property (nonatomic, readonly) NSString *lastUpdatedAt;
@property (readonly, strong, nonatomic) NSManagedObjectContext *qbManagedObjectContext;


- (void)performInitialSyncWithDelegate:(id<PNCContentManagerDelegate>)delegate;
- (NSInteger)categoryCount;
- (PNCCategory*)categoryAtIndex:(NSInteger)index;

- (NSInteger)recipeCountForCategory:(NSInteger)categoryIndex;
- (PNCRecipe*)recipeForCategory:(NSInteger)categoryIndex atIndex:(NSInteger)index;
- (PNCRecipe*)insertRecipe;

- (BOOL)save;

+ (instancetype)sharedInstance;

@end
