//
//  Card.h
//  UnitTestsCardExample
//
//  Created by Hanguang on 11/17/14.
//  Copyright (c) 2014 Hanguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
