//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Hanguang on 14-4-27.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject
@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

// Archiving
- (BOOL)saveChanges;

@end
