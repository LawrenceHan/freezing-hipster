//
//  BNRAppDelegate.h
//  CoreData
//
//  Created by Hanguang on 14-6-8.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, assign)BOOL netOK;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
