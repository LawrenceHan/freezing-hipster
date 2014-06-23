//
//  User.h
//  CoreData
//
//  Created by Hanguang on 14-6-8.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * measure;
@property (nonatomic, retain) NSNumber * age;

@end
