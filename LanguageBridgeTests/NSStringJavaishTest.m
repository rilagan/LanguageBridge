//
//  NSStringJavaishTest.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/17/13.
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
#import "NSString+Javaish.h"

@interface NSStringJavaishTest : XCTestCase

@end

@implementation NSStringJavaishTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testConcat {
    XCTAssertEqualObjects(@"v", [@"" concat:@"v"]);
    XCTAssertEqualObjects(@"vv", [@"v" concat:@"v"]);
    XCTAssertEqualObjects(@"hello world", [@"hello " concat:@"world"]);
}

- (void)testContains {
    XCTAssert(![@"" contains:@"v"]);
    XCTAssert([@"value is here" contains:@"is"]);
    XCTAssert(![@"hello" contains:@"l*o"]);
    
}

- (void)testEqual {
    XCTAssert(![@"" equals:@"v"]);
    XCTAssert([@"value is here" equals:@"value is here"]);
    XCTAssert(![@"hello" equals:@"Hello"]);
}

- (void)testEqualsIgnoreCase {
    XCTAssert(![@"" equalsIgnoreCase:@"v"]);
    XCTAssert([@"value is here" equalsIgnoreCase:@"value is here"]);
    XCTAssert([@"hello" equalsIgnoreCase:@"HeLLo"]);
}

- (void)testIndexOf {
    XCTAssertEqual(NSMakeRange(0, 5), [@"hello" indexOf:@"hello"]);
    XCTAssertEqual(NSMakeRange(0, 1), [@"hello" indexOf:@"h"]);
    XCTAssertEqual(NSMakeRange(1, 1), [@"hello" indexOf:@"e"]);
    XCTAssertEqual(NSMakeRange(2, 1), [@"hello" indexOf:@"l"]);
    XCTAssertEqual(NSMakeRange(3, 2), [@"hello" indexOf:@"lo"]);
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" indexOf:@"a"]);
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" indexOf:@"lllo"]);
}

- (void)testIndexOfFromIndex {
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" indexOf:@"a" fromIndex:0]);
    XCTAssertEqual(NSMakeRange(8, 1), [@"test case" indexOf:@"e" fromIndex:2]);
}

- (void)testIsEmpty {
    XCTAssert([@"" isEmpty]);
    XCTAssert(![@"value" isEmpty]);    
}

- (void)testLastIndexOf {
    XCTAssertEqual(NSMakeRange(0, 5), [@"hello" lastIndexOf:@"hello"]);
    XCTAssertEqual(NSMakeRange(3, 1), [@"hello" lastIndexOf:@"l"]);
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" lastIndexOf:@"x"]);
}

- (void)testLastIndexOfFromIndex {
    XCTAssertEqual(NSMakeRange(NSNotFound, 0), [@"hello" lastIndexOf:@"o" fromIndex:3]);
    XCTAssertEqual(NSMakeRange(4, 1), [@"hello" lastIndexOf:@"o" fromIndex:4]);
    XCTAssertEqual(NSMakeRange(1, 1), [@"test case" lastIndexOf:@"e" fromIndex:7]);
    XCTAssertEqual(NSMakeRange(8, 1), [@"test case" lastIndexOf:@"e" fromIndex:8]);
}

- (void)testMatches {
    XCTAssert([@"hello" matches:@"hello"]);
    XCTAssert([@"hhhello" matches:@"\\D+ello"]);
    XCTAssert([@"hello" matches:@"he\\D\\Do"]);
    XCTAssert(![@"hello" matches:@"g"]);
    XCTAssert(![@"hello" matches:@"he\\D-\\Do"]);
}

- (void)testReplaceAll {
    XCTAssertEqualObjects(@"h*ll*", [@"hello" replaceAll:@"[aeiou]" with:@"*"]);
    XCTAssertEqualObjects(@"aaaaavvaa", [@"bbbbbvvbb" replaceAll:@"b" with:@"a"]);
    XCTAssertEqualObjects(@"dateless", [@"dated" replaceAll:@"d$" with:@"less"]);
    XCTAssertEqualObjects(@"value", [@"value data test" replaceAll:@" d.*" with:@""]);
    XCTAssertEqualObjects(@"abababvbvbvb", [@"acacacvkvkvk" replaceAll:@"[ck]" with:@"b"]);
}

- (void)testReplaceFirst {
    XCTAssertEqualObjects(@"h*llo", [@"hello" replaceFirst:@"[aeiou]" with:@"*"]);
    XCTAssertEqualObjects(@"abbbbvvbb", [@"bbbbbvvbb" replaceFirst:@"b" with:@"a"]);
    XCTAssertEqualObjects(@"dateless", [@"dated" replaceFirst:@"d$" with:@"less"]);
    XCTAssertEqualObjects(@"value", [@"value data test" replaceFirst:@" d.*" with:@""]);
    XCTAssertEqualObjects(@"abacacvkvkvk", [@"acacacvkvkvk" replaceFirst:@"[ck]" with:@"b"]);
}

- (void)testSubstring {
    XCTAssertEqualObjects(@"string substringed", [@"string substringed" substringFromIndex:0]);
    XCTAssertEqualObjects(@"substring", [@"string after substring" substringFromIndex:13]);
}

- (void)testSubstringFromIndexToEndIndex {
    XCTAssertEqualObjects(@"string substringed", [@"string substringed" substringFromIndex:0 endIndex:18]);
    XCTAssertEqualObjects(@"substring", [@"string after substring" substringFromIndex:13 endIndex:22]);
    XCTAssertEqualObjects(@"str", [@"string after substring" substringFromIndex:0 endIndex:3]);
    
}

- (void)testStartsWith {
    XCTAssert([@"hello" startsWith:@"he"]);
    XCTAssert(![@"hello" startsWith:@"k"]);
}

- (void)testTrim {
   XCTAssertEqualObjects(@"goodbye", [@"\tgoodbye\r\n" trim]);
}

@end
