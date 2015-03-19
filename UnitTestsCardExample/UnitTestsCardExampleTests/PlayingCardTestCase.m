//
//  PlayingCardTestCase.m
//  UnitTestsCardExample
//
//  Created by Hanguang on 11/17/14.
//  Copyright (c) 2014 Hanguang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlayingCard.h"

@interface PlayingCardTestCase : XCTestCase

@end

@implementation PlayingCardTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testTheValidSuits {
    NSArray *theSuits = [PlayingCard validSuits];
    NSUInteger howMany = [theSuits count];
    XCTAssertEqual(howMany, 4, @"Should be only 4");
    XCTAssertTrue([theSuits containsObject:@"♥️"], @"Must have a heart");
    XCTAssertTrue([theSuits containsObject:@"♦️"], @"Must have a heart");
    XCTAssertTrue([theSuits containsObject:@"♠️"], @"Must have a heart");
    XCTAssertTrue([theSuits containsObject:@"♣️"], @"Must have a heart");
    
}

- (void)testSetSuitAnyValidAccepted {
    PlayingCard *card = [[PlayingCard alloc] init];
    [card setSuit:@"♥️"];
    XCTAssertEqual(card.suit, @"♥️", "Should be an Heart");
    
    [card setSuit:@"♦️"];
    XCTAssertEqual(card.suit, @"♦️", "Should be an Diamond");
    
    [card setSuit:@"♠️"];
    XCTAssertEqual(card.suit, @"♠️", "Should be an Spade");
    
    [card setSuit:@"♣️"];
    XCTAssertEqual(card.suit, @"♣️", "Should be an Club");
    
}

- (void)testSetSuitInvalidRejected {
    PlayingCard *card = [[PlayingCard alloc] init];
    [card setSuit:@"A"];
    XCTAssertNotEqual(card.suit, @"?", "Should not have been recognized");
    XCTAssertNotEqual(card.suit, @"A", "Should not have matched");
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


@end
