//
//  RBYNSDictionaryTest.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/9/13.
//
//  Copyright (c) 2014 Ryan Ilagan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
