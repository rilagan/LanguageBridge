//
//  NSArrayJavaishTest.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Javaish.h"

@interface NSArrayJavaishTest : XCTestCase

@end

@implementation NSArrayJavaishTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testContainsAll {
    NSArray *array = @[@1, @2, @3, @4, @5];
    NSArray *subArray = @[@1, @2];
    XCTAssertTrue([array containsAll:subArray]);
    subArray = @[@1, @6];
    XCTAssertTrue(![array containsAll:subArray]);
}

- (void)testIsEmpty {
    XCTAssertTrue([@[] isEmpty]);
    XCTAssertTrue(![@[@1] isEmpty]);
}

@end
