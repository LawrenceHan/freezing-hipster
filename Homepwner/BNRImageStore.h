//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Hanguang on 14-6-4.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
