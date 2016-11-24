//
//  AppDelegate.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/4/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface PNCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *tempPersistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

