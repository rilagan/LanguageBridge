//
//  RBYNSDictionaryTest.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/9/13.
//
//

#import <XCTest/XCTest.h>
#import "NSDictionary+Rubyish.h"

@interface NSDictionaryRubyishTest : XCTestCase

@end

@implementation NSDictionaryRubyishTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEmpty {
    XCTAssert([@{} empty]);
    XCTAssert(![@{@2:@3} empty]);
}

- (void)testInclude {
    XCTAssert([@{@2:@3} include:@2]);
    XCTAssert(![@{@2:@3} include:@4]);
}

- (void)testInvert {
    XCTAssertEqualObjects(@{@3:@2}, [@{@2:@3} invert]);
    NSDictionary *dict = @{@2:@3, @4:@5};
    NSDictionary *result = @{@3:@2, @5:@4};
    XCTAssertEqualObjects(result, [dict invert]);
}

- (void)testMember {
    XCTAssert([@{@2:@3} member:@2]);
    XCTAssert(![@{@2:@3} member:@4]);
}

- (void)testSelect {
    NSDictionary *dict = @{@1:@2, @2:@3, @3:@4, @4:@6, @5:@6};
    NSDictionary *result = @{@1:@2, @3:@4, @4:@6, @5:@6};
    dict = [dict select:^BOOL(id key, id obj) {
        NSNumber *num = (NSNumber *)obj;
        return [num intValue] % 2 == 0;
    }];
    XCTAssertEqualObjects(result, dict);
}

- (void)testReject {
    NSDictionary *dict = @{@1:@2, @2:@3, @3:@4, @4:@6, @5:@6};
    NSDictionary *result = @{@2:@3};
    dict = [dict reject:^BOOL(id key, id obj) {
        NSNumber *num = (NSNumber *)obj;
        return [num intValue] % 2 == 0;
    }];
    XCTAssertEqualObjects(result, dict);
}

@end
