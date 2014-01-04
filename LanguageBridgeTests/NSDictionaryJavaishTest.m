//
//  NSDictionaryJavaishTest.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+Javaish.h"

@interface NSDictionaryJavaishTest : XCTestCase

@end

@implementation NSDictionaryJavaishTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testContainsKey {
    XCTAssert([@{@2:@3} containsKey:@2]);
    XCTAssert(![@{@2:@3} containsKey:@3]);
}

@end
