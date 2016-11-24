//
//  PNCContentManager.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/6/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Quickblox/Quickblox.h>

#import "PNCContentManager.h"
#import "PNCAppDelegate.h"
#import "PNCCoreDataQuery.h"



@interface PNCCategory ()

@end

@implementation PNCContentManager{
    NSFetchedResultsController* _fetchedResultsController;
    BOOL        _sessionActive;
    dispatch_queue_t        _contextManagerQueue;

}
@synthesize qbManagedObjectContext = _qbManagedObjectContext;

+ (instancetype)sharedInstance
{
    static id instance_ = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fetchedResultsController = nil;
        _sessionActive = NO;
        _contextManagerQueue = dispatch_queue_create("com.peekncook.contextmanager.worker", NULL);

        
        // Set QuickBlox credentials (You must create application in admin.quickblox.com)
        [QBApplication sharedApplication].applicationId = 17266;
        [QBConnection registerServiceKey:@"2wQ4n4eYpQDpqzp"];
        [QBConnection registerServiceSecret:@"4DvJnwzMrYP4RKS"];
        [QBSettings setAccountKey:@"rWjK1sgpGxhDCQxmcmSq"];

        [self fetchPNCCoreData];
    }
    return self;
}

- (void)dealloc
{
    _fetchedResultsController = nil;
}


- (void)performInitialSyncWithDelegate:(id<PNCContentManagerDelegate>)delegate{

//    [delegate performSelector:@selector(initialSyncCompleted)];
//    return;
    void (^onComplete)(void);
    onComplete = ^{
        NSLog(@"initialSyncCompleted");
        [delegate performSelector:@selector(initialSyncCompleted)];
        // save tmp context
        //[[self qbManagedObjectContext] save:nil];
        [self updatePNCCoreDataObjects];
    };
    
    dispatch_async(_contextManagerQueue, ^{
        QBSessionParameters *parameters = [QBSessionParameters new];
        parameters.userLogin = @"anirbanmaiti";
        parameters.userPassword = @"";
        
        [QBRequest createSessionWithExtendedParameters:parameters successBlock:^(QBResponse *response, QBASession *session) {
            _sessionActive = YES;
            [self requestAllCategoryQBCustomObjectsWithCompletion:onComplete];
        } errorBlock:^(QBResponse *response) {
            NSLog(@"Response error %@:", response.error);
        }];
    });
    
    // get all Menu data. For now lets assume me have only once menu ie, Categories (menu id: "1")
//    dispatch_async(_contextManagerQueue, ^{
        
        // get all Category data and build temp context
        //[self requestAllCategoryQBCustomObjects];

        // fetch all recipe data and build temp context
        //[self requestAllRecipeQBCustomObjects];

        // update Core Data with received data
        // wait till we complete loading QB custom data
        
//    });
    
    
}

- (BOOL)save{
    PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
    [app saveContext];
    return YES;
}

-(NSInteger)recipeCountForCategory:(NSInteger)categoryIndex{
    PNCCategory* category =(PNCCategory*)[_fetchedResultsController fetchedObjects][categoryIndex];
    return [category.recipes count];
}

-(PNCRecipe *)recipeForCategory:(NSInteger)categoryIndex atIndex:(NSInteger)index{
    PNCCategory* category =(PNCCategory*)[_fetchedResultsController fetchedObjects][categoryIndex];
    return [category.recipes objectAtIndex:index];
}

-(NSInteger)categoryCount{
    return [[_fetchedResultsController fetchedObjects] count];
}
-(PNCCategory *)categoryAtIndex:(NSInteger)index{
    PNCCategory* category =(PNCCategory*)[_fetchedResultsController fetchedObjects][index];
    return category;
}
#pragma mark -
#pragma mark - Quickblox helper methods
- (void) requestAllCategoryQBCustomObjectsWithCompletion:(void (^)(void))completeBlock{
    
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //NSMutableDictionary *getRequest = [NSMutableDictionary dictionary];
    //[getRequest setObject:@"1" forKey:@"menu_id"];
    //[getRequest setObject:@"10" forKey:@"limit"];
    
    [QBRequest objectsWithClassName:@"PNCCategory" extendedRequest:nil
                       successBlock:^(QBResponse *response, NSArray *objects, QBResponsePage *page) {
                           NSLog(@"Successfull response!");
                           [self performSelector:@selector(buildCategoryTempManagedContextWithQBData:) withObject:objects];
                           [self requestAllRecipeQBCustomObjects:completeBlock];
                       } errorBlock:^(QBResponse *response) {
                           NSLog(@"Response error:%@", response.error);
                       }];
//    if (dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60 * NSEC_PER_SEC))) {
//        NSLog(@"Failed to receive data from quickblox within 60 secs");
}

- (void) requestAllRecipeQBCustomObjects:(void (^)(void))completeBlock{
    //NSMutableDictionary *getRequest = [NSMutableDictionary dictionary];
    //[getRequest setObject:@"1" forKey:@"menu_id"];
    //[getRequest setObject:@"10" forKey:@"limit"];
    
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [QBRequest objectsWithClassName:@"PNCRecipe" extendedRequest:nil
                       successBlock:^(QBResponse *response, NSArray *objects, QBResponsePage *page) {
                           NSLog(@"Successfull response!");
                           [self performSelector:@selector(buildRecipeTempManagedContextWithQBData:) withObject:objects];
                           completeBlock();
                           //dispatch_semaphore_signal(semaphore);
                       } errorBlock:^(QBResponse *response) {
                           NSLog(@"Response error:%@", response.error);
                           //dispatch_semaphore_signal(semaphore);
                       }];
//    if (dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60 * NSEC_PER_SEC))) {
//        NSLog(@"Failed to receive data from quickblox within 60 secs");
//    }

}

#pragma mark -
#pragma mark - Update Core Data

- (NSManagedObjectContext *)qbManagedObjectContext {
    if ( _qbManagedObjectContext!= nil) {
        return _qbManagedObjectContext;
    }
    
    // Do not save this context. This is used as temp context
    PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
    NSPersistentStoreCoordinator* pStore = app.tempPersistentStoreCoordinator;

    _qbManagedObjectContext = [[NSManagedObjectContext alloc] init];
    [_qbManagedObjectContext setPersistentStoreCoordinator:pStore];
    return _qbManagedObjectContext;
}

-(void) buildCategoryTempManagedContextWithQBData:(NSArray*)data{
    dispatch_sync(_contextManagerQueue, ^{
        PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = app.managedObjectContext;
        NSManagedObjectContext* tempContext = [self qbManagedObjectContext];
        NSEntityDescription *category = [NSEntityDescription entityForName:@"PNCCategory" inManagedObjectContext:context];
        for (QBCOCustomObject* co in data) {
            PNCCategory *unassociatedObject = (PNCCategory *) [[NSManagedObject alloc] initWithEntity:category insertIntoManagedObjectContext:tempContext];
            [unassociatedObject updateWithQBCO:co];
        }
    });
}

-(void) buildRecipeTempManagedContextWithQBData:(NSArray*)data{
    dispatch_sync(_contextManagerQueue, ^{
        PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = app.managedObjectContext;
        NSManagedObjectContext* tempContext = [self qbManagedObjectContext];
        NSEntityDescription *recipe = [NSEntityDescription entityForName:@"PNCRecipe" inManagedObjectContext:context];
        for (QBCOCustomObject* co in data) {
            PNCRecipe *unassociatedObject = (PNCRecipe *) [[NSManagedObject alloc] initWithEntity:recipe insertIntoManagedObjectContext:tempContext];
            [unassociatedObject updateWithQBCO:co];
        }
    });
}

- (void)updatePNCCoreDataObjects{
    dispatch_sync(_contextManagerQueue, ^{
        PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = app.managedObjectContext;

        // loop through every menu, for now its menu_id = 1
        // query categories for specific menu_id
        [self fetchPNCCoreData];
        // fetch menu id = 1 from temp core data
        NSFetchedResultsController *tempCategoryResultsController = [PNCCoreDataQuery categoryResultControllerForMenu:@1 withContext:[self qbManagedObjectContext]];

        NSError *error = nil;
        if (![tempCategoryResultsController performFetch:&error]) {
            NSLog(@"Error! %@",error);
        }

        // for every category in Quickblox, check update and update the core data context
        for (PNCCategory* tmpCat in [tempCategoryResultsController fetchedObjects]) {
            
            PNCCategory* currentCat = nil;
            for (PNCCategory* cat in [_fetchedResultsController fetchedObjects]) {
                if ([cat.category_id isEqualToString:tmpCat.category_id]) {
                    currentCat = cat;
                    break;
                }
            }
            if (!currentCat) {
                currentCat = [self insertCategoryWithContext:context];
            }
            [currentCat update:tmpCat];
        }
        // re-run the fetch query
        if (![_fetchedResultsController performFetch:&error]) {
            NSLog(@"Error! %@",error);
        }
        
        for (PNCCategory *c in [_fetchedResultsController fetchedObjects]) {
            NSLog(@"Category: %@", [c name]);
            [c updateCategoryWithTempContext:self];
        }

        // re-run the fetch query
        if (![_fetchedResultsController performFetch:&error]) {
            NSLog(@"Error! %@",error);
        }
        
        // for every category in
        // for every category in core data, query respective recipe by category tag
//        for (PNCCategory* cat in [_fetchedResultsController fetchedObjects]) {
//            
//            }
        
        // update and save the context
        //[app saveContext];
        // update the last update timestamp
    });
}

#pragma mark -
#pragma mark - Fetch PNC Core Data

- (PNCCategory*) insertCategoryWithContext:(NSManagedObjectContext*)context{
    NSEntityDescription *category = [NSEntityDescription entityForName:@"PNCCategory" inManagedObjectContext:context];
    PNCCategory *c = (PNCCategory *) [[NSManagedObject alloc] initWithEntity:category insertIntoManagedObjectContext:context];
    return c;
}

-(PNCRecipe *)insertRecipe{
    PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = app.managedObjectContext;
    NSEntityDescription *recipe = [NSEntityDescription entityForName:@"PNCRecipe" inManagedObjectContext:context];
    PNCRecipe *r = (PNCRecipe *) [[NSManagedObject alloc] initWithEntity:recipe insertIntoManagedObjectContext:context];
    return r;
}

/*-(void) createCoreDataDataset{
    PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = app.managedObjectContext;
    // First Course object
    PNCCategory *first = (PNCCategory *) [NSEntityDescription
                                insertNewObjectForEntityForName:@"PNCCategory"
                                inManagedObjectContext:context];
    first.category_id = @1;
    first.name = @"Fish Dishes";
    first.recipe_tag = @"Top rated";
    
    PNCRecipe *firstR = (PNCRecipe *) [NSEntityDescription
                                          insertNewObjectForEntityForName:@"PNCRecipe"
                                          inManagedObjectContext:context];
    firstR.recipe_id = @1;
    firstR.name = @"Fish Curry";
    firstR.ingredients = @"Ingredients";
    [first addRecipesObject:firstR];

    firstR = (PNCRecipe *) [NSEntityDescription
                                       insertNewObjectForEntityForName:@"PNCRecipe"
                                       inManagedObjectContext:context];
    firstR.recipe_id = @2;
    firstR.name = @"Fish Curry 2";
    firstR.ingredients = @"Ingredients";
    [first addRecipesObject:firstR];

    firstR = (PNCRecipe *) [NSEntityDescription
                            insertNewObjectForEntityForName:@"PNCRecipe"
                            inManagedObjectContext:context];
    firstR.recipe_id = @3;
    firstR.name = @"Fish Curry 3";
    firstR.ingredients = @"Ingredients";
    [first addRecipesObject:firstR];

    
    // Second Course object
    PNCCategory *second = (PNCCategory *) [NSEntityDescription
                                          insertNewObjectForEntityForName:@"PNCCategory"
                                          inManagedObjectContext:context];
    second.category_id = @2;
    second.name = @"Veg Dishes";
    second.recipe_tag = @"Top rated";

    firstR = (PNCRecipe *) [NSEntityDescription
                            insertNewObjectForEntityForName:@"PNCRecipe"
                            inManagedObjectContext:context];
    firstR.recipe_id = @4;
    firstR.name = @"Paneer Curry 1";
    firstR.ingredients = @"Ingredients";
    [second addRecipesObject:firstR];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"There's a problem: %@", error);
    }

}*/

-(void) fetchPNCCoreData{
    
    if (_fetchedResultsController) {
        return;
    }
    
    PNCAppDelegate* app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = app.managedObjectContext;
    
    _fetchedResultsController = [PNCCoreDataQuery categoryResultControllerForMenu:@1 withContext:context];
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Error! %@",error);
    }
    
    //    NSError *error = nil;
    //    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    //    if (fetchedObjects == nil) {
    //        NSLog(@"Problem! %@",error);
    //    }
    
//    for (PNCCategory *c in [_fetchedResultsController fetchedObjects]) {
//        NSLog(@"Category: %@", [c name]);
//        
//        for (PNCRecipe* r in c.recipes) {
//            NSLog(@"PNCRecipe: %@", [r name]);
//        }
//    }
}
- (void) fetchCategoriesTempCoreDataWithMenu:(NSNumber*)menu_id{
    // for every menu item fetch category
}


//
//- (void(^)(QBResponse *, QBASession *))sessionSuccessBlock
//{
//    return ^(QBResponse *response, QBASession *session) {
//        
//        
//        NSString *fileID = @"58294eddbe4c443ea2058ea7d92035d700";
//        // Download file from QuickBlox server
//        [QBRequest downloadFileWithUID:fileID successBlock:^(QBResponse *response, NSData *fileData) {
//            if ( fileData ) {
//                NSError *error;
//                NSPropertyListFormat format;
//                NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:fileData options:NSPropertyListImmutable format:&format error:&error];
//                if (!plist) {
//                    NSLog(@"Error reading plist from file error = '%@'", error);
//                }
//                else{
//                    [[PNCContentManager sharedInstance] addData:plist];
//                }
//            }
//            //[self performSegueWithIdentifier:@"splashSegue" sender:self];
//        } statusBlock:^(QBRequest *request, QBRequestStatus *status) {
//            NSLog(@"progress: %f", status.percentOfCompletion);
//        }  errorBlock:^(QBResponse *response) {
//            NSLog(@"%@", response.error.error);
//        }];
//        
//        
//        //        QBGeneralResponsePage *page = [QBGeneralResponsePage responsePageWithCurrentPage:1 perPage:20];
//        //        [QBRequest blobsForPage:page successBlock:^(QBResponse *response, QBGeneralResponsePage *page, NSArray *blobs) {
//        //
//        //            //[[SSCContentManager instance] saveFileList:blobs];
//        //
//        //            NSLog(@"%@", blobs);
//        //            // hide splash screen
//        //            //[self performSelector:@selector(hideSplashScreen) withObject:self afterDelay:1];
//        //            [self performSegueWithIdentifier:@"splashSegue" sender:self];
//        //
//        //        } errorBlock:^(QBResponse *response) {
//        //            NSLog(@"error: %@", response.error);
//        //        }];
//    };
//}
//

@end
